package perm

import (
	"context"
	"fmt"

	"github.com/google/uuid"
)

// CanOnTask evaluates the Q3 two-layer permission model for tasks. It
// passes when the viewer holds the required tag-level bundle on at least
// one tag where the corresponding role flag (view_role/interact_role/
// moderate_role) is set on task_tags.
//
// Standalone tasks (no task_tags rows) are visible only to creators,
// assignees, and watchers — checked separately by callers via
// IsAssigneeOrWatcher.
func (s *Service) CanOnTask(ctx context.Context, viewer uuid.UUID, action Action, taskID uuid.UUID) (bool, error) {
	tagIDs, err := s.taskTagsForAction(ctx, taskID, action)
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

// EffectiveOnTask returns the maximum bundle the viewer holds across all
// tags where the task's view_role is set, plus the union of extras.
func (s *Service) EffectiveOnTask(ctx context.Context, viewer uuid.UUID, taskID uuid.UUID) (Bundle, []string, error) {
	tagIDs, err := s.taskTagsForAction(ctx, taskID, ActionView)
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

// taskTagsForAction returns the tag ids attached to taskID with the
// per-action role flag set to true. Cached per request like postTags.
func (s *Service) taskTagsForAction(ctx context.Context, taskID uuid.UUID, action Action) ([]uuid.UUID, error) {
	if c, ok := cacheFromContext(ctx); ok {
		if tags, hit := c.lookupTaskTags(taskID, action); hit {
			return tags, nil
		}
	}
	column := roleColumn(action)
	sql := fmt.Sprintf(`SELECT tag_id FROM task_tags WHERE task_id = $1 AND %s = TRUE`, column)
	rows, err := s.DB.Query(ctx, sql, taskID)
	if err != nil {
		return nil, fmt.Errorf("query task_tags: %w", err)
	}
	defer rows.Close()
	var tags []uuid.UUID
	for rows.Next() {
		var id uuid.UUID
		if err := rows.Scan(&id); err != nil {
			return nil, fmt.Errorf("scan task_tag: %w", err)
		}
		tags = append(tags, id)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("rows err: %w", err)
	}
	if c, ok := cacheFromContext(ctx); ok {
		c.storeTaskTags(taskID, action, tags)
	}
	return tags, nil
}

// TaskVisibilityPredicateSQL returns a Postgres EXISTS fragment that
// passes when the viewer can see the named task — either via a tag
// grant on a tag attached with view_role, OR via direct involvement
// (creator, assignee, watcher) for standalone tasks. Compose into list
// queries (tag(id).tasks).
//
// Parameters: taskIDColumn (the task id column in the outer query, e.g.
// "t.id") and viewerParam (the SQL placeholder for viewer principal id,
// e.g. "$1").
func TaskVisibilityPredicateSQL(taskIDColumn, viewerParam string) string {
	return fmt.Sprintf(`
        (
          EXISTS (
            SELECT 1 FROM task_tags tt
            JOIN tag_closure c ON c.descendant_id = tt.tag_id
            JOIN tag_grants  g ON g.tag_id = c.ancestor_id
            WHERE tt.task_id = %s
              AND tt.view_role = TRUE
              AND g.principal_id = %s
              AND (c.depth = 0 OR g.cascade = TRUE)
          )
          OR EXISTS (
            SELECT 1 FROM task_assignees ta
            WHERE ta.task_id = %s AND ta.principal_id = %s
          )
          OR EXISTS (
            SELECT 1 FROM task_watchers tw
            WHERE tw.task_id = %s AND tw.principal_id = %s
          )
          OR EXISTS (
            SELECT 1 FROM tasks tk
            WHERE tk.id = %s AND tk.created_by = %s
          )
        )
    `,
		taskIDColumn, viewerParam,
		taskIDColumn, viewerParam,
		taskIDColumn, viewerParam,
		taskIDColumn, viewerParam,
	)
}
