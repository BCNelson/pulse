// Package loaders is the per-request batch-and-cache layer for the
// GraphQL resolvers. The architecture flags this as non-negotiable: a
// naive feed view that resolves N posts will fire N queries for authors,
// N for tag attachments, N for reaction tallies — instant performance
// disaster.
//
// Design: simple synchronous batching. gqlgen runs field resolvers
// sequentially; we don't need goroutine-driven debouncing. Each loader
// caches by id within the request lifetime and exposes a Prime call so
// list resolvers can pre-warm the cache with one batched SELECT before
// iterating their items.
//
// Pattern in resolvers:
//
//	posts := s.ListByTag(...)
//	authorIDs := uniqueAuthorIDs(posts)
//	if err := loaders.FromContext(ctx).Principals.Prime(ctx, authorIDs); err != nil { ... }
//	for _, p := range posts {
//	    author, _ := loaders.FromContext(ctx).Principals.Get(ctx, p.AuthorID)  // cache hit
//	    ...
//	}
package loaders

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"sync"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

// anyTime is the local time type used by scanned rows. Mirrors the
// alias in the parent graphql package.
type anyTime = time.Time

// Loaders aggregates the per-request loader instances. Construct with
// New(pool); attach via Middleware. Resolvers retrieve via FromContext.
type Loaders struct {
	Principals    *PrincipalLoader
	Tags          *TagLoader
	PostReactions *PostReactionLoader
}

// New builds a fresh Loaders backed by pool. Use one per request — the
// caches are not safe to share across operations because they hold
// permission-filtered values implicitly (a row visible to one viewer may
// not be visible to another).
func New(pool *pgxpool.Pool) *Loaders {
	return &Loaders{
		Principals:    newPrincipalLoader(pool),
		Tags:          newTagLoader(pool),
		PostReactions: newPostReactionLoader(pool),
	}
}

type ctxKey struct{}

// WithLoaders attaches loaders to ctx.
func WithLoaders(ctx context.Context, l *Loaders) context.Context {
	return context.WithValue(ctx, ctxKey{}, l)
}

// FromContext returns the loaders attached to ctx, or nil if missing.
// Callers should check for nil and fall back to direct DB access — tests
// that don't go through Middleware often skip the loader path.
func FromContext(ctx context.Context) *Loaders {
	l, _ := ctx.Value(ctxKey{}).(*Loaders)
	return l
}

// Middleware attaches a fresh Loaders to every inbound request's context.
// Wrap the GraphQL handler so resolvers see them.
func Middleware(pool *pgxpool.Pool, next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := WithLoaders(r.Context(), New(pool))
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}

// PrincipalRow is the loader's cache value: just the columns the
// resolver needs. The loader returns nil for ids that don't exist; the
// resolver decides how to surface that.
type PrincipalRow struct {
	ID          int64
	Kind        string
	Status      string
	DisplayName string
	Email       *string
	HomeTagID   *int64
	BotOwnerID  *int64
}

// PrincipalLoader batches principal reads.
type PrincipalLoader struct {
	pool  *pgxpool.Pool
	mu    sync.Mutex
	cache map[int64]*PrincipalRow
}

func newPrincipalLoader(pool *pgxpool.Pool) *PrincipalLoader {
	return &PrincipalLoader{pool: pool, cache: map[int64]*PrincipalRow{}}
}

// Prime loads the named ids in one SELECT and populates the cache. ids
// that don't resolve are stored as nil so subsequent Get calls don't
// re-query.
func (l *PrincipalLoader) Prime(ctx context.Context, ids []int64) error {
	missing := l.uniqueMissing(ids)
	if len(missing) == 0 {
		return nil
	}
	rows, err := l.pool.Query(ctx, `
        SELECT p.id, p.kind, p.status, p.display_name, p.email, p.home_tag_id,
               bc.owner_principal_id
        FROM principals p
        LEFT JOIN bot_credentials bc ON bc.principal_id = p.id
        WHERE p.id = ANY($1::BIGINT[])
    `, missing)
	if err != nil {
		return fmt.Errorf("batch principals: %w", err)
	}
	defer rows.Close()
	found := map[int64]*PrincipalRow{}
	for rows.Next() {
		var r PrincipalRow
		if err := rows.Scan(&r.ID, &r.Kind, &r.Status, &r.DisplayName,
			&r.Email, &r.HomeTagID, &r.BotOwnerID); err != nil {
			return fmt.Errorf("scan principal: %w", err)
		}
		found[r.ID] = &r
	}
	if err := rows.Err(); err != nil {
		return err
	}
	l.mu.Lock()
	defer l.mu.Unlock()
	for _, id := range missing {
		l.cache[id] = found[id] // nil if not found — cached as a tombstone
	}
	return nil
}

// Get returns the cached principal or loads it if not present.
func (l *PrincipalLoader) Get(ctx context.Context, id int64) (*PrincipalRow, error) {
	l.mu.Lock()
	if v, ok := l.cache[id]; ok {
		l.mu.Unlock()
		return v, nil
	}
	l.mu.Unlock()
	if err := l.Prime(ctx, []int64{id}); err != nil {
		return nil, err
	}
	l.mu.Lock()
	defer l.mu.Unlock()
	return l.cache[id], nil
}

func (l *PrincipalLoader) uniqueMissing(ids []int64) []int64 {
	l.mu.Lock()
	defer l.mu.Unlock()
	seen := map[int64]struct{}{}
	out := make([]int64, 0, len(ids))
	for _, id := range ids {
		if _, dup := seen[id]; dup {
			continue
		}
		seen[id] = struct{}{}
		if _, has := l.cache[id]; has {
			continue
		}
		out = append(out, id)
	}
	return out
}

// TagRow mirrors the columns the tag resolver shaping needs. Closure-
// derived path is computed lazily by the resolver — keeping it out of
// the loader so the batch query stays a single table read.
type TagRow struct {
	ID          int64
	ParentID    *int64
	Slug        string
	DisplayName string
	RootKind    string
	Defaults    []byte
	ArchivedAt  *anyTime
	CreatedAt   anyTime
}

// TagLoader batches tag reads.
type TagLoader struct {
	pool  *pgxpool.Pool
	mu    sync.Mutex
	cache map[int64]*TagRow
}

func newTagLoader(pool *pgxpool.Pool) *TagLoader {
	return &TagLoader{pool: pool, cache: map[int64]*TagRow{}}
}

func (l *TagLoader) Prime(ctx context.Context, ids []int64) error {
	missing := l.uniqueMissing(ids)
	if len(missing) == 0 {
		return nil
	}
	rows, err := l.pool.Query(ctx, `
        SELECT id, parent_id, slug, display_name, root_kind, defaults, archived_at, created_at
        FROM tags
        WHERE id = ANY($1::BIGINT[])
    `, missing)
	if err != nil {
		return fmt.Errorf("batch tags: %w", err)
	}
	defer rows.Close()
	found := map[int64]*TagRow{}
	for rows.Next() {
		var r TagRow
		if err := rows.Scan(&r.ID, &r.ParentID, &r.Slug, &r.DisplayName,
			&r.RootKind, &r.Defaults, &r.ArchivedAt, &r.CreatedAt); err != nil {
			return fmt.Errorf("scan tag: %w", err)
		}
		found[r.ID] = &r
	}
	if err := rows.Err(); err != nil {
		return err
	}
	l.mu.Lock()
	defer l.mu.Unlock()
	for _, id := range missing {
		l.cache[id] = found[id]
	}
	return nil
}

func (l *TagLoader) Get(ctx context.Context, id int64) (*TagRow, error) {
	l.mu.Lock()
	if v, ok := l.cache[id]; ok {
		l.mu.Unlock()
		return v, nil
	}
	l.mu.Unlock()
	if err := l.Prime(ctx, []int64{id}); err != nil {
		return nil, err
	}
	l.mu.Lock()
	defer l.mu.Unlock()
	return l.cache[id], nil
}

func (l *TagLoader) uniqueMissing(ids []int64) []int64 {
	l.mu.Lock()
	defer l.mu.Unlock()
	seen := map[int64]struct{}{}
	out := make([]int64, 0, len(ids))
	for _, id := range ids {
		if _, dup := seen[id]; dup {
			continue
		}
		seen[id] = struct{}{}
		if _, has := l.cache[id]; has {
			continue
		}
		out = append(out, id)
	}
	return out
}

// PostReactionTally is the per-emoji aggregate for a single post.
// ByViewer is computed against the viewer associated with the request.
type PostReactionTally struct {
	Emoji    string
	Count    int
	ByViewer bool
}

// PostReactionLoader batches reaction-aggregate reads. Cache is keyed by
// (postID, viewerID) since ByViewer is viewer-scoped.
type PostReactionLoader struct {
	pool  *pgxpool.Pool
	mu    sync.Mutex
	cache map[postReactionKey][]PostReactionTally
}

type postReactionKey struct {
	postID int64
	viewer int64
}

func newPostReactionLoader(pool *pgxpool.Pool) *PostReactionLoader {
	return &PostReactionLoader{pool: pool, cache: map[postReactionKey][]PostReactionTally{}}
}

// Prime aggregates reaction tallies for each (postID, viewer) pair in
// one query and populates the cache. Posts with no reactions are cached
// as an empty slice so subsequent calls don't re-query.
func (l *PostReactionLoader) Prime(ctx context.Context, postIDs []int64, viewer int64) error {
	missing := []int64{}
	l.mu.Lock()
	for _, id := range postIDs {
		if _, has := l.cache[postReactionKey{id, viewer}]; has {
			continue
		}
		missing = append(missing, id)
	}
	l.mu.Unlock()
	if len(missing) == 0 {
		return nil
	}
	rows, err := l.pool.Query(ctx, `
        SELECT post_id, emoji, COUNT(*)::INT, BOOL_OR(principal_id = $2)
        FROM post_reactions
        WHERE post_id = ANY($1::BIGINT[])
        GROUP BY post_id, emoji
        ORDER BY post_id, emoji
    `, missing, viewer)
	if err != nil {
		return fmt.Errorf("batch reactions: %w", err)
	}
	defer rows.Close()

	by := map[int64][]PostReactionTally{}
	for rows.Next() {
		var pid int64
		var t PostReactionTally
		if err := rows.Scan(&pid, &t.Emoji, &t.Count, &t.ByViewer); err != nil {
			return fmt.Errorf("scan reaction: %w", err)
		}
		by[pid] = append(by[pid], t)
	}
	if err := rows.Err(); err != nil {
		return err
	}
	l.mu.Lock()
	defer l.mu.Unlock()
	for _, id := range missing {
		l.cache[postReactionKey{id, viewer}] = by[id] // nil → empty
	}
	return nil
}

// Get returns the cached tally or loads it.
func (l *PostReactionLoader) Get(ctx context.Context, postID, viewer int64) ([]PostReactionTally, error) {
	l.mu.Lock()
	if v, ok := l.cache[postReactionKey{postID, viewer}]; ok {
		l.mu.Unlock()
		return v, nil
	}
	l.mu.Unlock()
	if err := l.Prime(ctx, []int64{postID}, viewer); err != nil {
		return nil, err
	}
	l.mu.Lock()
	defer l.mu.Unlock()
	return l.cache[postReactionKey{postID, viewer}], nil
}

// ErrNoLoaders signals that resolvers attempted a loader call without
// the middleware in place. Callers should fall back to direct DB rather
// than fail the request.
var ErrNoLoaders = errors.New("loaders: not attached to context")

// QueryRowsViaPool is a small typing escape so we don't import pgx
// elsewhere just to thread typed scans. Not currently used externally;
// kept for symmetry with future loaders that need a raw row scan.
func QueryRowsViaPool(ctx context.Context, pool *pgxpool.Pool, sql string, args ...any) (pgx.Rows, error) {
	return pool.Query(ctx, sql, args...)
}
