package perm

import (
	"context"
	"fmt"
)

// roleColumn returns the post_tags column that gates an action against a
// post. View walks tags with view_role=true; contribute uses interact_role;
// moderate and own use moderate_role (owners on a tag necessarily moderate
// posts attached to it).
func roleColumn(a Action) string {
	switch a {
	case ActionView:
		return "view_role"
	case ActionContribute:
		return "interact_role"
	case ActionModerate, ActionOwn:
		return "moderate_role"
	}
	return "view_role"
}

// CanOnPost evaluates the Q3 two-layer permission model: post visibility
// passes when the viewer holds the required tag-level bundle on at least
// one tag where the corresponding role flag is set. A non-existent post
// or one with no tags returns false.
func (s *Service) CanOnPost(ctx context.Context, viewer int64, action Action, postID int64) (bool, error) {
	tagIDs, err := s.postTagsForAction(ctx, postID, action)
	if err != nil {
		return false, err
	}
	for _, tagID := range tagIDs {
		ok, err := s.Can(ctx, viewer, action, tagID)
		if err != nil {
			return false, err
		}
		if ok {
			return true, nil
		}
	}
	return false, nil
}

// EffectiveOnPost returns the maximum bundle the viewer holds across all
// tags where the post's view_role is set, plus the union of extras. This
// is used by clients to render which actions are available; for binary
// authorization checks prefer CanOnPost which short-circuits.
func (s *Service) EffectiveOnPost(ctx context.Context, viewer int64, postID int64) (Bundle, []string, error) {
	// Visibility uses view_role; the returned bundle represents what the
	// viewer can do on tags with that role flag. Per-action role flags
	// can shrink the effective bundle further — clients re-check via
	// CanOnPost(contribute) etc.
	tagIDs, err := s.postTagsForAction(ctx, postID, ActionView)
	if err != nil {
		return BundleNone, nil, err
	}
	max := BundleNone
	extrasSet := map[string]struct{}{}
	for _, tagID := range tagIDs {
		bundle, extras, err := s.EffectiveOnTag(ctx, viewer, tagID)
		if err != nil {
			return BundleNone, nil, err
		}
		if bundle.rank() > max.rank() {
			max = bundle
		}
		for _, e := range extras {
			extrasSet[e] = struct{}{}
		}
	}
	out := make([]string, 0, len(extrasSet))
	for e := range extrasSet {
		out = append(out, e)
	}
	return max, out, nil
}

// postTagsForAction returns the tag ids attached to postID with the
// per-action role flag set to true. Cached per request: post_tags is
// stable within an operation's lifetime and would otherwise be hit
// multiple times when listing post fields.
func (s *Service) postTagsForAction(ctx context.Context, postID int64, action Action) ([]int64, error) {
	if c, ok := cacheFromContext(ctx); ok {
		if tags, hit := c.lookupPostTags(postID, action); hit {
			return tags, nil
		}
	}
	column := roleColumn(action)
	sql := fmt.Sprintf(`SELECT tag_id FROM post_tags WHERE post_id = $1 AND %s = TRUE`, column)
	rows, err := s.DB.Query(ctx, sql, postID)
	if err != nil {
		return nil, fmt.Errorf("query post_tags: %w", err)
	}
	defer rows.Close()
	var tags []int64
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, fmt.Errorf("scan post_tag: %w", err)
		}
		tags = append(tags, id)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("rows err: %w", err)
	}
	if c, ok := cacheFromContext(ctx); ok {
		c.storePostTags(postID, action, tags)
	}
	return tags, nil
}

// PostVisibilityPredicateSQL returns a Postgres EXISTS fragment that
// passes when the viewer has any cascading grant whose tag is an
// ancestor of a tag the post is attached to with view_role set. Compose
// into list queries (tag(id).posts, search) to filter at the DB layer.
//
// Parameters: postIDColumn (the post column to constrain against, e.g.
// "p.id") and viewerParam (the SQL parameter placeholder for the viewer
// principal id, e.g. "$1").
func PostVisibilityPredicateSQL(postIDColumn, viewerParam string) string {
	return fmt.Sprintf(`
        EXISTS (
          SELECT 1
          FROM post_tags pt
          JOIN tag_closure c ON c.descendant_id = pt.tag_id
          JOIN tag_grants  g ON g.tag_id = c.ancestor_id
          WHERE pt.post_id = %s
            AND pt.view_role = TRUE
            AND g.principal_id = %s
            AND (c.depth = 0 OR g.cascade = TRUE)
        )
    `, postIDColumn, viewerParam)
}
