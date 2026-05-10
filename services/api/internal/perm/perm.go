// Package perm is the central authorization layer. Every mutation resolver
// calls Can; every list resolver either calls Filter or composes the
// visibility predicate into its query. Caching is per-request — see
// WithRequestCache.
//
// M1 covers tag-scoped permissions. M2 layers post tag-roles (the Q3 two-
// layer model) onto this same service.
package perm

import (
	"context"
	"fmt"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"
)

// Bundle names the four permission bundles defined in the product
// architecture. Higher rank implies all the powers of lower ranks.
type Bundle string

const (
	BundleNone        Bundle = ""
	BundleViewer      Bundle = "viewer"
	BundleContributor Bundle = "contributor"
	BundleModerator   Bundle = "moderator"
	BundleOwner       Bundle = "owner"
)

func (b Bundle) rank() int {
	switch b {
	case BundleOwner:
		return 4
	case BundleModerator:
		return 3
	case BundleContributor:
		return 2
	case BundleViewer:
		return 1
	default:
		return 0
	}
}

// AtLeast reports whether b grants every power that other does.
func (b Bundle) AtLeast(other Bundle) bool {
	return b.rank() >= other.rank()
}

// Action is the authorization verb. Each action has a minimum bundle that
// confers it; explicit extra_perms entries can grant individual actions
// without the full bundle.
type Action string

const (
	ActionView       Action = "view"
	ActionContribute Action = "contribute"
	ActionModerate   Action = "moderate"
	ActionOwn        Action = "own"
)

func (a Action) minBundle() Bundle {
	switch a {
	case ActionView:
		return BundleViewer
	case ActionContribute:
		return BundleContributor
	case ActionModerate:
		return BundleModerator
	case ActionOwn:
		return BundleOwner
	default:
		return BundleOwner
	}
}

// Service evaluates permissions. v1 implementation reads tag_grants joined
// with tag_closure; the visibility predicate is the same shape applied
// directly inside list queries via VisibilityPredicateSQL.
type Service struct {
	DB *pgxpool.Pool
}

// EffectiveOnTag returns the maximum bundle and union of extra_perms that
// principal P holds against tag T, considering both direct grants and
// cascading grants from ancestors.
func (s *Service) EffectiveOnTag(ctx context.Context, principal, tag uuid.UUID) (Bundle, []string, error) {
	if c, ok := cacheFromContext(ctx); ok {
		if entry, hit := c.lookup(principal, tag); hit {
			return entry.bundle, entry.extras, nil
		}
	}

	rows, err := s.DB.Query(ctx, `
        SELECT g.bundle, g.extra_perms
        FROM tag_grants g
        JOIN tag_closure c ON c.ancestor_id = g.tag_id
        WHERE c.descendant_id = $1
          AND g.principal_id = $2
          AND (c.depth = 0 OR g.cascade = TRUE)
    `, tag, principal)
	if err != nil {
		return BundleNone, nil, fmt.Errorf("query grants: %w", err)
	}
	defer rows.Close()

	max := BundleNone
	extrasSet := map[string]struct{}{}
	for rows.Next() {
		var bundle Bundle
		var extras []string
		if err := rows.Scan(&bundle, &extras); err != nil {
			return BundleNone, nil, fmt.Errorf("scan grant: %w", err)
		}
		if bundle.rank() > max.rank() {
			max = bundle
		}
		for _, e := range extras {
			extrasSet[e] = struct{}{}
		}
	}
	if err := rows.Err(); err != nil {
		return BundleNone, nil, fmt.Errorf("rows err: %w", err)
	}

	extras := make([]string, 0, len(extrasSet))
	for e := range extrasSet {
		extras = append(extras, e)
	}

	if c, ok := cacheFromContext(ctx); ok {
		c.store(principal, tag, max, extras)
	}
	return max, extras, nil
}

// Can returns true iff principal P may perform action A against tag T.
// Bundle inclusion satisfies the action by default; extra_perms entries
// matching the action name can substitute.
func (s *Service) Can(ctx context.Context, principal uuid.UUID, action Action, tag uuid.UUID) (bool, error) {
	bundle, extras, err := s.EffectiveOnTag(ctx, principal, tag)
	if err != nil {
		return false, err
	}
	if bundle.AtLeast(action.minBundle()) {
		return true, nil
	}
	for _, perm := range extras {
		if perm == string(action) {
			return true, nil
		}
	}
	return false, nil
}

// Filter returns the subset of tags for which principal P may perform
// action A. M1 implementation iterates Can; M2 adds a batched-SQL form
// once posts shovel hundreds of items per request through here.
func (s *Service) Filter(ctx context.Context, principal uuid.UUID, action Action, tags []uuid.UUID) ([]uuid.UUID, error) {
	out := make([]uuid.UUID, 0, len(tags))
	for _, t := range tags {
		ok, err := s.Can(ctx, principal, action, t)
		if err != nil {
			return nil, err
		}
		if ok {
			out = append(out, t)
		}
	}
	return out, nil
}

// VisibilityPredicateSQL returns a Postgres `EXISTS (...)` fragment that
// evaluates to true when principal P has any cascading grant whose tag is
// an ancestor of the named content_tag column. Compose into list queries
// to avoid loading rows we'd just filter out client-side.
//
// Example:
//
//	WHERE %s
//
// where %s is `pgx.NamedArgs`-substituted with the actual column reference.
// For now the callers pass the column expression and the parameter
// placeholders; this returns the literal SQL.
func VisibilityPredicateSQL(contentTagColumn, viewerParam string) string {
	return fmt.Sprintf(`
        EXISTS (
          SELECT 1 FROM tag_grants g
          JOIN tag_closure c ON c.ancestor_id = g.tag_id
          WHERE c.descendant_id = %s
            AND g.principal_id = %s
            AND (c.depth = 0 OR g.cascade = TRUE)
        )
    `, contentTagColumn, viewerParam)
}

// --- per-request cache ---

type cacheCtxKey struct{}

type cacheEntry struct {
	bundle Bundle
	extras []string
}

type cache struct {
	tag      map[[2]uuid.UUID]cacheEntry
	postTags map[postTagsKey][]uuid.UUID
}

type postTagsKey struct {
	postID uuid.UUID
	action Action
}

func newCache() *cache {
	return &cache{
		tag:      make(map[[2]uuid.UUID]cacheEntry),
		postTags: make(map[postTagsKey][]uuid.UUID),
	}
}

func (c *cache) lookup(principal, tag uuid.UUID) (cacheEntry, bool) {
	e, ok := c.tag[[2]uuid.UUID{principal, tag}]
	return e, ok
}

func (c *cache) store(principal, tag uuid.UUID, bundle Bundle, extras []string) {
	c.tag[[2]uuid.UUID{principal, tag}] = cacheEntry{bundle: bundle, extras: extras}
}

func (c *cache) lookupPostTags(postID uuid.UUID, action Action) ([]uuid.UUID, bool) {
	v, ok := c.postTags[postTagsKey{postID, action}]
	return v, ok
}

func (c *cache) storePostTags(postID uuid.UUID, action Action, tags []uuid.UUID) {
	c.postTags[postTagsKey{postID, action}] = tags
}

func cacheFromContext(ctx context.Context) (*cache, bool) {
	c, ok := ctx.Value(cacheCtxKey{}).(*cache)
	return c, ok
}

// WithRequestCache attaches a per-request permission cache. Middleware
// should call this once at the request boundary; resolvers descending the
// tree then share the same cache for the request's lifetime.
func WithRequestCache(ctx context.Context) context.Context {
	if _, ok := cacheFromContext(ctx); ok {
		return ctx
	}
	return context.WithValue(ctx, cacheCtxKey{}, newCache())
}
