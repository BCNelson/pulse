package graphql

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"strings"

	"github.com/jackc/pgx/v5"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/graphql/loaders"
	"github.com/bcnelson/pulse/services/api/internal/graphql/model"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// loadTag fetches a tag by id and assembles its model representation,
// including parent (single hop), direct children, computed path, viewer's
// permissions, and subscription. Returns nil, nil when the viewer cannot
// view it (visibility = view permission). Returns nil, error for real errors.
func (r *Resolver) loadTag(ctx context.Context, id int64) (*model.Tag, error) {
	identity := auth.FromContext(ctx)
	if identity.IsAnonymous() {
		return nil, nil
	}
	canView, err := r.Perm.Can(ctx, identity.EffectiveID, perm.ActionView, id)
	if err != nil {
		return nil, fmt.Errorf("permission check: %w", err)
	}
	if !canView {
		return nil, nil
	}

	row := r.DB.QueryRow(ctx, `
        SELECT id, parent_id, slug, display_name, root_kind, defaults, archived_at, created_at
        FROM tags
        WHERE id = $1
    `, id)
	var t tagRow
	if err := row.Scan(&t.id, &t.parentID, &t.slug, &t.displayName, &t.rootKind, &t.defaults, &t.archivedAt, &t.createdAt); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, nil
		}
		return nil, fmt.Errorf("load tag: %w", err)
	}

	out := r.toModelTag(t)

	// Path: walk parent links. Costlier on deep trees; M2 caches on read.
	path, err := r.computePath(ctx, t.id)
	if err != nil {
		return nil, err
	}
	out.Path = path

	// Parent (one hop only — recursive parents are visible via the same
	// tag(id) query when the client wants them).
	if t.parentID != nil {
		parent, err := r.loadTagShallow(ctx, *t.parentID)
		if err != nil {
			return nil, err
		}
		out.Parent = parent
	}

	// Direct children are populated lazily by the Tag.children field
	// resolver — see schema.resolvers.go. Loading here would over-fetch
	// for queries that don't ask for them and miss deeper levels for
	// queries that ask for nested children.

	// MyPermissions
	bundle, extras, err := r.Perm.EffectiveOnTag(ctx, identity.EffectiveID, t.id)
	if err != nil {
		return nil, err
	}
	out.MyPermissions = buildPermissions(bundle, extras)

	// MySubscription
	sub, err := r.loadSubscription(ctx, identity.EffectiveID, t.id)
	if err != nil {
		return nil, err
	}
	out.MySubscription = sub

	return out, nil
}

// resolveTagRef accepts either a typed Crockford tag id ("T1XB7NE7X7RV")
// or a slug path ("org/infra") and returns the int64 tag id. Empty
// strings, malformed inputs, and unresolvable paths all return 0 and
// nil — callers translate that into "tag not found" at the response
// boundary. Real errors (DB failure) come back as the second return.
//
// Shape detection rule:
//   - contains `/`  → slug path (multi-segment)
//   - exactly 12 chars in the Crockford alphabet → typed id
//   - anything else → treat as a single-segment slug path (root slug)
//
// This keeps the GraphQL surface stable while letting callers pass
// human-readable paths instead of opaque ids.
func (r *Resolver) resolveTagRef(ctx context.Context, ref string) (int64, error) {
	if ref == "" {
		return 0, nil
	}
	if strings.Contains(ref, "/") {
		return r.resolveTagSlugPath(ctx, strings.Split(ref, "/"))
	}
	// Try parsing as a typed id; if that fails, fall back to treating it
	// as a single-segment slug (root tag).
	if id, err := ids.ParseAs(ids.KindTag, ref); err == nil {
		return id, nil
	}
	return r.resolveTagSlugPath(ctx, []string{ref})
}

// resolveTagSlugPath walks the slug hierarchy in one recursive CTE and
// returns the leaf tag id (or 0 if no tag matches the path). Empty path
// returns 0; the resolver translates that into a nil GraphQL response.
//
// SQL plan: anchor against the root row (parent_id IS NULL, slug = $1[1]),
// then recursively match each next slug against children of the prior
// match's id. The unique-slug-per-parent index makes each hop O(log N).
func (r *Resolver) resolveTagSlugPath(ctx context.Context, path []string) (int64, error) {
	if len(path) == 0 {
		return 0, nil
	}
	row := r.DB.QueryRow(ctx, `
        WITH RECURSIVE walk(id, depth) AS (
          SELECT id, 0
          FROM tags
          WHERE parent_id IS NULL AND slug = ($1::text[])[1]
          UNION ALL
          SELECT t.id, walk.depth + 1
          FROM tags t
          JOIN walk ON t.parent_id = walk.id
          WHERE t.slug = ($1::text[])[walk.depth + 2]
        )
        SELECT id FROM walk WHERE depth = array_length($1::text[], 1) - 1
    `, path)
	var id int64
	if err := row.Scan(&id); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return 0, nil
		}
		return 0, fmt.Errorf("resolve tag slug path: %w", err)
	}
	return id, nil
}

// loadTagShallow returns the model with no children/parent/permissions —
// just the structural fields plus the computed path. Used for hydrating
// the parent pointer. Goes through the per-request loader cache when
// available.
func (r *Resolver) loadTagShallow(ctx context.Context, id int64) (*model.Tag, error) {
	if l := loaders.FromContext(ctx); l != nil {
		row, err := l.Tags.Get(ctx, id)
		if err != nil {
			return nil, err
		}
		if row == nil {
			return nil, nil
		}
		return r.shallowFromLoader(ctx, row)
	}

	var t tagRow
	err := r.DB.QueryRow(ctx, `
        SELECT id, parent_id, slug, display_name, root_kind, defaults, archived_at, created_at
        FROM tags WHERE id = $1
    `, id).Scan(&t.id, &t.parentID, &t.slug, &t.displayName, &t.rootKind, &t.defaults, &t.archivedAt, &t.createdAt)
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, nil
		}
		return nil, fmt.Errorf("load tag shallow: %w", err)
	}
	out := r.toModelTag(t)
	out.MyPermissions = &model.TagPermissions{Extras: []string{}}
	if out.Path, err = r.computePath(ctx, t.id); err != nil {
		return nil, err
	}
	return out, nil
}

// shallowFromLoader builds a Tag model from a loaders.TagRow.
func (r *Resolver) shallowFromLoader(ctx context.Context, row *loaders.TagRow) (*model.Tag, error) {
	t := tagRow{
		id: row.ID, parentID: row.ParentID, slug: row.Slug,
		displayName: row.DisplayName, rootKind: row.RootKind,
		defaults: row.Defaults, archivedAt: row.ArchivedAt, createdAt: row.CreatedAt,
	}
	out := r.toModelTag(t)
	out.MyPermissions = &model.TagPermissions{Extras: []string{}}
	path, err := r.computePath(ctx, t.id)
	if err != nil {
		return nil, err
	}
	out.Path = path
	return out, nil
}

// loadVisibleChildren returns each child of parentID that the viewer can
// see. Path is computed inline: every child's path is `parentPath +
// "/" + child.slug`, so one extra SELECT (for parentPath) covers the
// whole batch rather than N separate computePath calls.
func (r *Resolver) loadVisibleChildren(ctx context.Context, parentID, viewer int64) ([]*model.Tag, error) {
	parentPath, err := r.computePath(ctx, parentID)
	if err != nil {
		return nil, err
	}

	rows, err := r.DB.Query(ctx, `
        SELECT id, parent_id, slug, display_name, root_kind, defaults, archived_at, created_at
        FROM tags
        WHERE parent_id = $1
          AND archived_at IS NULL
        ORDER BY slug
    `, parentID)
	if err != nil {
		return nil, fmt.Errorf("load children: %w", err)
	}
	defer rows.Close()

	var children []*model.Tag
	for rows.Next() {
		var t tagRow
		if err := rows.Scan(&t.id, &t.parentID, &t.slug, &t.displayName, &t.rootKind, &t.defaults, &t.archivedAt, &t.createdAt); err != nil {
			return nil, fmt.Errorf("scan child: %w", err)
		}
		can, err := r.Perm.Can(ctx, viewer, perm.ActionView, t.id)
		if err != nil {
			return nil, err
		}
		if !can {
			continue
		}
		m := r.toModelTag(t)
		m.MyPermissions = &model.TagPermissions{Extras: []string{}}
		if parentPath == "" {
			m.Path = t.slug
		} else {
			m.Path = parentPath + "/" + t.slug
		}
		children = append(children, m)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("rows err: %w", err)
	}
	if children == nil {
		children = []*model.Tag{}
	}
	return children, nil
}

func (r *Resolver) computePath(ctx context.Context, leaf int64) (string, error) {
	rows, err := r.DB.Query(ctx, `
        SELECT t.slug
        FROM tag_closure c
        JOIN tags t ON t.id = c.ancestor_id
        WHERE c.descendant_id = $1
        ORDER BY c.depth DESC
    `, leaf)
	if err != nil {
		return "", fmt.Errorf("compute path: %w", err)
	}
	defer rows.Close()
	var parts []string
	for rows.Next() {
		var s string
		if err := rows.Scan(&s); err != nil {
			return "", err
		}
		parts = append(parts, s)
	}
	if err := rows.Err(); err != nil {
		return "", err
	}
	return joinPath(parts), nil
}

func joinPath(parts []string) string {
	if len(parts) == 0 {
		return ""
	}
	out := parts[0]
	for _, p := range parts[1:] {
		out += "/" + p
	}
	return out
}

// loadFeedSettings returns the viewer's saved feed view prefs for tagID.
// Missing rows mean defaults (all FALSE) — the row only exists once a
// pref has been flipped away from default.
func (r *Resolver) loadFeedSettings(ctx context.Context, principal, tagID int64) (*model.TagFeedSettings, error) {
	out := &model.TagFeedSettings{}
	err := r.DB.QueryRow(ctx, `
        SELECT include_descendants
        FROM tag_view_prefs
        WHERE principal_id = $1 AND tag_id = $2
    `, principal, tagID).Scan(&out.IncludeDescendants)
	if errors.Is(err, pgx.ErrNoRows) {
		return out, nil
	}
	if err != nil {
		return nil, fmt.Errorf("load feed settings: %w", err)
	}
	return out, nil
}

func (r *Resolver) loadSubscription(ctx context.Context, principal, tagID int64) (*model.TagSubscription, error) {
	var cascade bool
	var urgency string
	var reasonFilter []string
	err := r.DB.QueryRow(ctx, `
        SELECT cascade, urgency, reason_filter
        FROM subscriptions
        WHERE principal_id = $1 AND tag_id = $2
    `, principal, tagID).Scan(&cascade, &urgency, &reasonFilter)
	if errors.Is(err, pgx.ErrNoRows) {
		return nil, nil
	}
	if err != nil {
		return nil, fmt.Errorf("load subscription: %w", err)
	}
	if reasonFilter == nil {
		reasonFilter = []string{}
	}
	return &model.TagSubscription{
		Cascade:      cascade,
		Urgency:      mapUrgencyDBToGQL(urgency),
		ReasonFilter: reasonFilter,
	}, nil
}

func buildPermissions(bundle perm.Bundle, extras []string) *model.TagPermissions {
	out := &model.TagPermissions{Extras: extras}
	if extras == nil {
		out.Extras = []string{}
	}
	if bundle != perm.BundleNone {
		b := mapBundleDBToGQL(bundle)
		out.Bundle = &b
	}
	out.CanView = bundle.AtLeast(perm.BundleViewer) || hasExtra(extras, "view")
	out.CanContribute = bundle.AtLeast(perm.BundleContributor) || hasExtra(extras, "contribute")
	out.CanModerate = bundle.AtLeast(perm.BundleModerator) || hasExtra(extras, "moderate")
	out.CanOwn = bundle.AtLeast(perm.BundleOwner) || hasExtra(extras, "own")
	return out
}

func hasExtra(extras []string, want string) bool {
	for _, e := range extras {
		if e == want {
			return true
		}
	}
	return false
}

// --- mapping ---

type tagRow struct {
	id          int64
	parentID    *int64
	slug        string
	displayName string
	rootKind    string
	defaults    []byte
	archivedAt  *anyTime
	createdAt   anyTime
}

// anyTime is just time.Time; keeping a typedef for symmetry with future
// Postgres-typed scanners (interval, etc.) without dragging in an alias.
type anyTime = anyTimeImpl

func (r *Resolver) toModelTag(t tagRow) *model.Tag {
	defaults := "{}"
	if len(t.defaults) > 0 {
		defaults = string(t.defaults)
	}
	out := &model.Tag{
		ID:          ids.FormatID(t.id),
		GlobalURI:   ids.URI(ids.KindTag, t.id),
		Slug:        t.slug,
		DisplayName: t.displayName,
		RootKind:    mapRootKindDBToGQL(t.rootKind),
		Defaults:    defaults,
		CreatedAt:   t.createdAt,
	}
	if t.archivedAt != nil {
		v := *t.archivedAt
		out.ArchivedAt = &v
	}
	return out
}

func mapRootKindDBToGQL(s string) model.TagRootKind {
	switch s {
	case tag.RootKindOrg:
		return model.TagRootKindOrg
	case tag.RootKindUser:
		return model.TagRootKindUser
	}
	return ""
}

func mapBundleDBToGQL(b perm.Bundle) model.PermissionBundle {
	switch b {
	case perm.BundleViewer:
		return model.PermissionBundleViewer
	case perm.BundleContributor:
		return model.PermissionBundleContributor
	case perm.BundleModerator:
		return model.PermissionBundleModerator
	case perm.BundleOwner:
		return model.PermissionBundleOwner
	}
	return ""
}

func mapBundleGQLToDB(b model.PermissionBundle) perm.Bundle {
	switch b {
	case model.PermissionBundleViewer:
		return perm.BundleViewer
	case model.PermissionBundleContributor:
		return perm.BundleContributor
	case model.PermissionBundleModerator:
		return perm.BundleModerator
	case model.PermissionBundleOwner:
		return perm.BundleOwner
	}
	return perm.BundleNone
}

func mapUrgencyDBToGQL(u string) model.SubscriptionUrgency {
	switch u {
	case "high":
		return model.SubscriptionUrgencyHigh
	case "low":
		return model.SubscriptionUrgencyLow
	case "mute":
		return model.SubscriptionUrgencyMute
	}
	return model.SubscriptionUrgencyNormal
}

func mapUrgencyGQLToDB(u model.SubscriptionUrgency) string {
	switch u {
	case model.SubscriptionUrgencyHigh:
		return "high"
	case model.SubscriptionUrgencyLow:
		return "low"
	case model.SubscriptionUrgencyMute:
		return "mute"
	}
	return "normal"
}

// jsonOrEmpty unmarshals a *string defaults blob into a JSON.RawMessage.
// Empty/nil yields a "{}" payload — the DB column has NOT NULL DEFAULT '{}'.
func jsonOrEmpty(s *string) (json.RawMessage, error) {
	if s == nil || *s == "" {
		return json.RawMessage("{}"), nil
	}
	if !json.Valid([]byte(*s)) {
		return nil, fmt.Errorf("defaults: invalid JSON")
	}
	return json.RawMessage(*s), nil
}
