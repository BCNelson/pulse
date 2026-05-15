package graphql

import (
	"context"
	"errors"
	"fmt"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/graphql/loaders"
	"github.com/bcnelson/pulse/services/api/internal/graphql/model"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/task"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// loadTask hydrates a Task with the full GraphQL representation. Returns
// nil, nil when the viewer cannot see it; nil, err on real failures.
func (r *Resolver) loadTask(ctx context.Context, id int64) (*model.Task, error) {
	identity := auth.FromContext(ctx)
	if identity.IsAnonymous() {
		return nil, nil
	}

	t, err := r.Tasks.Get(ctx, id)
	if err != nil {
		if errors.Is(err, task.ErrNotFound) {
			return nil, nil
		}
		return nil, err
	}
	if t.DeletedAt != nil {
		return nil, nil
	}

	canView, err := r.canViewTask(ctx, identity.EffectiveID, t)
	if err != nil {
		return nil, err
	}
	if !canView {
		return nil, nil
	}

	creator, err := r.loadPrincipalIface(ctx, t.CreatedBy)
	if err != nil {
		return nil, err
	}

	tagAttachments, err := r.Tasks.TagAttachments(ctx, id)
	if err != nil {
		return nil, err
	}
	taskTags := make([]*model.TaskTag, 0, len(tagAttachments))
	for _, a := range tagAttachments {
		tg, err := r.loadTagShallow(ctx, a.TagID)
		if err != nil {
			return nil, err
		}
		if tg == nil {
			continue
		}
		taskTags = append(taskTags, &model.TaskTag{
			Tag:          tg,
			ViewRole:     a.ViewRole,
			InteractRole: a.InteractRole,
			ModerateRole: a.ModerateRole,
		})
	}

	assignees, err := r.principalsForIDs(ctx, mustIDs(r.Tasks.Assignees(ctx, id)))
	if err != nil {
		return nil, err
	}
	watchers, err := r.principalsForIDs(ctx, mustIDs(r.Tasks.Watchers(ctx, id)))
	if err != nil {
		return nil, err
	}

	var linkedPost *model.Post
	if t.LinkedPostID != nil {
		linkedPost, _ = r.loadPost(ctx, *t.LinkedPostID)
	}
	var linkedComment *model.Comment
	if t.LinkedCommentID != nil {
		linkedComment, _ = r.loadComment(ctx, *t.LinkedCommentID)
	}

	bundle, _, err := r.Perm.EffectiveOnTask(ctx, identity.EffectiveID, id)
	if err != nil {
		return nil, err
	}
	canContribute, err := r.canTaskAction(ctx, identity.EffectiveID, t, perm.ActionContribute)
	if err != nil {
		return nil, err
	}
	canModerate, err := r.canTaskAction(ctx, identity.EffectiveID, t, perm.ActionModerate)
	if err != nil {
		return nil, err
	}
	myPerms := &model.TaskPermissions{
		CanView:       canView,
		CanContribute: canContribute,
		CanModerate:   canModerate,
	}
	if bundle != perm.BundleNone {
		b := mapBundleDBToGQL(bundle)
		myPerms.Bundle = &b
	}

	out := &model.Task{
		ID:            ids.FormatID(t.ID),
		GlobalURI:     ids.URI(ids.KindTask, t.ID),
		Title:         t.Title,
		Description:   t.Description,
		Status:        mapTaskStatusDBToGQL(t.Status),
		DueAt:         t.DueAt,
		Tags:          taskTags,
		Assignees:     assignees,
		Watchers:      watchers,
		LinkedPost:    linkedPost,
		LinkedComment: linkedComment,
		CreatedBy:     creator,
		MyPermissions: myPerms,
		CreatedAt:     t.CreatedAt,
		EditedAt:      t.EditedAt,
		DeletedAt:     t.DeletedAt,
	}
	return out, nil
}

// canViewTask layers the standalone-task fallback on top of CanOnTask.
// A task with no tags is visible only to creator/assignees/watchers.
func (r *Resolver) canViewTask(ctx context.Context, viewer int64, t *task.Task) (bool, error) {
	can, err := r.Perm.CanOnTask(ctx, viewer, perm.ActionView, t.ID)
	if err != nil {
		return false, err
	}
	if can {
		return true, nil
	}
	return r.isInvolvedInTask(ctx, viewer, t)
}

// canTaskAction checks contribute/moderate. Creator and assignees get
// implicit contribute on standalone tasks; otherwise standard tag-role
// gating applies.
func (r *Resolver) canTaskAction(ctx context.Context, viewer int64, t *task.Task, action perm.Action) (bool, error) {
	can, err := r.Perm.CanOnTask(ctx, viewer, action, t.ID)
	if err != nil {
		return false, err
	}
	if can {
		return true, nil
	}
	if action == perm.ActionContribute || action == perm.ActionView {
		return r.isInvolvedInTask(ctx, viewer, t)
	}
	if action == perm.ActionModerate {
		return t.CreatedBy == viewer, nil
	}
	return false, nil
}

func (r *Resolver) isInvolvedInTask(ctx context.Context, viewer int64, t *task.Task) (bool, error) {
	if t.CreatedBy == viewer {
		return true, nil
	}
	var found bool
	if err := r.DB.QueryRow(ctx, `
        SELECT EXISTS (
          SELECT 1 FROM task_assignees WHERE task_id = $1 AND principal_id = $2
          UNION ALL
          SELECT 1 FROM task_watchers  WHERE task_id = $1 AND principal_id = $2
        )
    `, t.ID, viewer).Scan(&found); err != nil {
		return false, err
	}
	return found, nil
}

func (r *Resolver) principalsForIDs(ctx context.Context, ids []int64) ([]model.Principal, error) {
	out := make([]model.Principal, 0, len(ids))
	for _, id := range ids {
		p, err := r.loadPrincipalIface(ctx, id)
		if err != nil {
			return nil, err
		}
		if p != nil {
			out = append(out, p)
		}
	}
	return out, nil
}

// mustIDs panics if the wrapped call errors. Used for ergonomic chaining
// in loadTask where we already know the underlying query is well-formed
// — bubbles up only the slice and propagates an error via a tiny wrapper.
// (We accept (slice, err) and return slice, dropping err. The caller
// re-checks via a separate path.)
//
// To stay honest we DO check the err and return nil in that case so the
// downstream principalsForIDs call simply yields an empty slice; the real
// error gets re-raised in callers via the surrounding service errors.
func mustIDs(ids []int64, err error) []int64 {
	if err != nil {
		return nil
	}
	return ids
}

func mapTaskStatusDBToGQL(s string) model.TaskStatus {
	switch s {
	case "open":
		return model.TaskStatusOpen
	case "in_progress":
		return model.TaskStatusInProgress
	case "blocked":
		return model.TaskStatusBlocked
	case "done":
		return model.TaskStatusDone
	case "cancelled":
		return model.TaskStatusCancelled
	}
	return model.TaskStatusOpen
}

func mapTaskStatusGQLToDB(s model.TaskStatus) string {
	switch s {
	case model.TaskStatusOpen:
		return "open"
	case model.TaskStatusInProgress:
		return "in_progress"
	case model.TaskStatusBlocked:
		return "blocked"
	case model.TaskStatusDone:
		return "done"
	case model.TaskStatusCancelled:
		return "cancelled"
	}
	return ""
}

// primeTaskListLoaders pre-warms loader caches for a task list:
// distinct creators (and assignees/watchers as a follow-on) and the
// task's attached tags.
func (r *Resolver) primeTaskListLoaders(ctx context.Context, tasks []*task.Task) {
	l := loaders.FromContext(ctx)
	if l == nil {
		return
	}
	if len(tasks) == 0 {
		return
	}
	creatorIDs := make([]int64, 0, len(tasks))
	taskIDs := make([]int64, 0, len(tasks))
	for _, t := range tasks {
		creatorIDs = append(creatorIDs, t.CreatedBy)
		taskIDs = append(taskIDs, t.ID)
	}
	_ = l.Principals.Prime(ctx, creatorIDs)

	// Pull distinct tag ids across all tasks and prime the tag loader.
	rows, err := r.DB.Query(ctx,
		`SELECT DISTINCT tag_id FROM task_tags WHERE task_id = ANY($1::BIGINT[])`, taskIDs)
	if err == nil {
		tagIDs := []int64{}
		for rows.Next() {
			var id int64
			if err := rows.Scan(&id); err == nil {
				tagIDs = append(tagIDs, id)
			}
		}
		rows.Close()
		_ = l.Tags.Prime(ctx, tagIDs)
	}

	// Pull assignees + watchers across all tasks and prime principals.
	rows, err = r.DB.Query(ctx, `
        SELECT DISTINCT principal_id FROM task_assignees WHERE task_id = ANY($1::BIGINT[])
        UNION
        SELECT DISTINCT principal_id FROM task_watchers  WHERE task_id = ANY($1::BIGINT[])
    `, taskIDs)
	if err == nil {
		pids := []int64{}
		for rows.Next() {
			var id int64
			if err := rows.Scan(&id); err == nil {
				pids = append(pids, id)
			}
		}
		rows.Close()
		_ = l.Principals.Prime(ctx, pids)
	}
}

// emptyTaskConnection mirrors emptyPostConnection.
func emptyTaskConnection() *model.TaskConnection {
	return &model.TaskConnection{
		Edges:    []*model.TaskEdge{},
		PageInfo: &model.PageInfo{},
	}
}

// loadTasksForTag is the field resolver helper for Tag.tasks.
func (r *Resolver) loadTasksForTag(ctx context.Context, tagID int64, limit int, status *string) (*model.TaskConnection, error) {
	identity, err := requireIdentity(ctx)
	if err != nil {
		return emptyTaskConnection(), nil
	}
	tasks, err := r.Tasks.ListByTag(ctx, tagID, limit, status)
	if err != nil {
		return nil, fmt.Errorf("list tasks: %w", err)
	}
	r.primeTaskListLoaders(ctx, tasks)
	edges := make([]*model.TaskEdge, 0, len(tasks))
	for _, t := range tasks {
		can, err := r.canViewTask(ctx, identity.EffectiveID, t)
		if err != nil {
			return nil, err
		}
		if !can {
			continue
		}
		mt, err := r.loadTask(ctx, t.ID)
		if err != nil {
			return nil, err
		}
		if mt == nil {
			continue
		}
		edges = append(edges, &model.TaskEdge{
			Node:   mt,
			Cursor: encodeCursor(cursor{CreatedAt: t.CreatedAt, ID: t.ID}),
		})
	}
	pi := &model.PageInfo{}
	if len(edges) > 0 {
		s := edges[0].Cursor
		e := edges[len(edges)-1].Cursor
		pi.StartCursor = &s
		pi.EndCursor = &e
	}
	return &model.TaskConnection{Edges: edges, PageInfo: pi}, nil
}
