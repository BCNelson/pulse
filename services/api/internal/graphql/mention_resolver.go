package graphql

import (
	"context"
	"errors"
	"fmt"

	"github.com/jackc/pgx/v5"
)

// resolveUserMentions maps user-tag root slugs to principal ids in a
// single batched query. Slugs that match no active user are silently
// dropped — the mention text remains in the body and the notification
// fan-out just doesn't ping anyone.
//
// A user's canonical handle is the slug of their user-tag root (the row
// in `tags` where `parent_id IS NULL`, `root_kind = 'user'`, and
// `bound_principal = principals.id`). This is the same identity the
// /feed/u/<slug>/... router uses.
func (r *Resolver) resolveUserMentions(ctx context.Context, slugs []string) ([]int64, error) {
	if len(slugs) == 0 {
		return nil, nil
	}
	rows, err := r.DB.Query(ctx, `
        SELECT p.id
        FROM principals p
        JOIN tags t ON t.id = p.home_tag_id
        WHERE p.status = 'active'
          AND t.parent_id IS NULL
          AND t.root_kind = 'user'
          AND t.slug = ANY($1::text[])
    `, slugs)
	if err != nil {
		return nil, fmt.Errorf("resolve user mentions: %w", err)
	}
	defer rows.Close()
	seen := make(map[int64]struct{}, len(slugs))
	out := make([]int64, 0, len(slugs))
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, fmt.Errorf("scan user mention: %w", err)
		}
		if _, dup := seen[id]; dup {
			continue
		}
		seen[id] = struct{}{}
		out = append(out, id)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("iterate user mentions: %w", err)
	}
	return out, nil
}

// resolveTagRefs maps slug paths (split into segments) to tag ids. Paths
// that don't match anything are silently dropped.
func (r *Resolver) resolveTagRefs(ctx context.Context, paths [][]string) ([]int64, error) {
	if len(paths) == 0 {
		return nil, nil
	}
	seen := make(map[int64]struct{}, len(paths))
	out := make([]int64, 0, len(paths))
	for _, p := range paths {
		id, err := r.resolveTagSlugPath(ctx, p)
		if err != nil {
			if errors.Is(err, pgx.ErrNoRows) {
				continue
			}
			return nil, err
		}
		if id == 0 {
			continue
		}
		if _, dup := seen[id]; dup {
			continue
		}
		seen[id] = struct{}{}
		out = append(out, id)
	}
	return out, nil
}
