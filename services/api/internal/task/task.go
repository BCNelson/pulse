// Package task owns tasks, task_tags, task_assignees, task_watchers, and
// the promote-from-content flows. Authorization checks live one layer up
// in perm.CanOnTask + the assignee/watcher visibility rules; this package
// is the data-shape and enqueueing guardian.
package task

import (
	"context"
	"errors"
	"fmt"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/job"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

var (
	ErrNotFound        = errors.New("task: not found")
	ErrAlreadyAssigned = errors.New("task: principal already assigned")
	ErrInvalidStatus   = errors.New("task: invalid status")
)

// validStatuses mirrors the CHECK constraint in 000006_*.sql. Validation
// in Go gives a friendlier error than the underlying constraint
// violation.
var validStatuses = map[string]struct{}{
	"open": {}, "in_progress": {}, "blocked": {}, "done": {}, "cancelled": {},
}

type Service struct {
	DB *pgxpool.Pool
}

// TagAttachment carries the per-task role-flag overrides on a tag.
type TagAttachment struct {
	TagID        int64
	ViewRole     bool
	InteractRole bool
	ModerateRole bool
}

// CreateInput is the payload for createTask. Tags can be empty for a
// "standalone" task — visibility then depends only on creator/assignees/
// watchers.
type CreateInput struct {
	CreatorID       int64
	Title           string
	Description     string
	DueAt           *time.Time
	Tags            []TagAttachment
	Assignees       []int64
	LinkedPostID    *int64
	LinkedCommentID *int64
}

// Task is the read-side row.
type Task struct {
	ID              int64
	Title           string
	Description     *string
	Status          string
	DueAt           *time.Time
	LinkedPostID    *int64
	LinkedCommentID *int64
	CreatedBy       int64
	CreatedAt       time.Time
	EditedAt        *time.Time
	DeletedAt       *time.Time
}

// Create inserts a task with tags, assignees, and an implicit watcher
// row for the creator. All in one transaction; the surrounding caller
// can wrap with notification enqueue (notification.fanout) too — but
// since enqueue takes a Querier we don't fold it in here, keeping this
// package job-agnostic.
func (s *Service) Create(ctx context.Context, in CreateInput) (int64, error) {
	var id int64
	err := s.runInTx(ctx, func(tx pgx.Tx) error {
		row := tx.QueryRow(ctx, `
            INSERT INTO tasks (title, description, due_at, linked_post_id, linked_comment_id, created_by)
            VALUES ($1, NULLIF($2, ''), $3, $4, $5, $6)
            RETURNING id
        `, in.Title, in.Description, in.DueAt, in.LinkedPostID, in.LinkedCommentID, in.CreatorID)
		if err := row.Scan(&id); err != nil {
			return fmt.Errorf("insert task: %w", err)
		}
		for _, t := range in.Tags {
			if _, err := tx.Exec(ctx, `
                INSERT INTO task_tags (task_id, tag_id, view_role, interact_role, moderate_role)
                VALUES ($1, $2, $3, $4, $5)
            `, id, t.TagID, t.ViewRole, t.InteractRole, t.ModerateRole); err != nil {
				return fmt.Errorf("insert task_tag: %w", err)
			}
		}
		for _, p := range in.Assignees {
			if _, err := tx.Exec(ctx, `
                INSERT INTO task_assignees (task_id, principal_id, assigned_by)
                VALUES ($1, $2, $3) ON CONFLICT DO NOTHING
            `, id, p, in.CreatorID); err != nil {
				return fmt.Errorf("insert assignee: %w", err)
			}
		}
		// Creator is auto-watching unless they're already an assignee.
		if _, err := tx.Exec(ctx, `
            INSERT INTO task_watchers (task_id, principal_id) VALUES ($1, $2)
            ON CONFLICT DO NOTHING
        `, id, in.CreatorID); err != nil {
			return fmt.Errorf("insert watcher: %w", err)
		}
		// Enqueue notification fan-out alongside the create. The handler
		// reads tag-typed-fields (assignees, mentions, watchers, tag
		// subscribers) and writes notifications + emits pg_notify.
		if err := job.Enqueue(ctx, tx, "notification.fanout", map[string]any{
			"source_type": "task",
			"source_id":   ids.FormatID(id),
			"actor_id":    ids.FormatID(in.CreatorID),
			"event":       "created",
		}); err != nil {
			return fmt.Errorf("enqueue notification: %w", err)
		}
		return nil
	})
	return id, err
}

func (s *Service) Get(ctx context.Context, id int64) (*Task, error) {
	row := s.DB.QueryRow(ctx, `
        SELECT id, title, description, status, due_at, linked_post_id, linked_comment_id,
               created_by, created_at, edited_at, deleted_at
        FROM tasks WHERE id = $1
    `, id)
	var t Task
	if err := row.Scan(&t.ID, &t.Title, &t.Description, &t.Status, &t.DueAt,
		&t.LinkedPostID, &t.LinkedCommentID, &t.CreatedBy, &t.CreatedAt, &t.EditedAt, &t.DeletedAt); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, ErrNotFound
		}
		return nil, fmt.Errorf("load task: %w", err)
	}
	return &t, nil
}

// Edit updates title/description/due_at; nil means "leave unchanged".
func (s *Service) Edit(ctx context.Context, id int64, title, description *string, dueAt *time.Time, clearDueAt bool) error {
	tag, err := s.DB.Exec(ctx, `
        UPDATE tasks
           SET title       = COALESCE($2, title),
               description = COALESCE($3, description),
               due_at      = CASE WHEN $5 THEN NULL ELSE COALESCE($4, due_at) END,
               edited_at   = now()
         WHERE id = $1 AND deleted_at IS NULL
    `, id, title, description, dueAt, clearDueAt)
	if err != nil {
		return fmt.Errorf("edit task: %w", err)
	}
	if tag.RowsAffected() == 0 {
		return ErrNotFound
	}
	return nil
}

// SetStatus transitions a task. Caller is responsible for the perm check.
func (s *Service) SetStatus(ctx context.Context, id int64, status string) error {
	if _, ok := validStatuses[status]; !ok {
		return ErrInvalidStatus
	}
	tag, err := s.DB.Exec(ctx, `
        UPDATE tasks SET status = $1, edited_at = now()
         WHERE id = $2 AND deleted_at IS NULL
    `, status, id)
	if err != nil {
		return fmt.Errorf("set status: %w", err)
	}
	if tag.RowsAffected() == 0 {
		return ErrNotFound
	}
	return nil
}

// Delete soft-deletes a task.
func (s *Service) Delete(ctx context.Context, id int64) error {
	tag, err := s.DB.Exec(ctx,
		`UPDATE tasks SET deleted_at = now() WHERE id = $1 AND deleted_at IS NULL`, id)
	if err != nil {
		return fmt.Errorf("soft-delete: %w", err)
	}
	if tag.RowsAffected() == 0 {
		return ErrNotFound
	}
	return nil
}

// Assign adds a principal to task_assignees and enqueues an "assigned"
// notification job. Idempotent on the row but enqueueing always emits
// (the worker dedupes).
func (s *Service) Assign(ctx context.Context, taskID, principal, assignedBy int64) error {
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		ct, err := tx.Exec(ctx, `
            INSERT INTO task_assignees (task_id, principal_id, assigned_by)
            VALUES ($1, $2, $3) ON CONFLICT DO NOTHING
        `, taskID, principal, assignedBy)
		if err != nil {
			return fmt.Errorf("assign: %w", err)
		}
		if ct.RowsAffected() == 0 {
			// Idempotent — already assigned. Don't enqueue duplicate
			// "assignment" notifications.
			return nil
		}
		return job.Enqueue(ctx, tx, "notification.fanout", map[string]any{
			"source_type":  "task",
			"source_id":    ids.FormatID(taskID),
			"actor_id":     ids.FormatID(assignedBy),
			"event":        "assigned",
			"recipient_id": ids.FormatID(principal),
		})
	})
}

func (s *Service) Unassign(ctx context.Context, taskID, principal int64) error {
	_, err := s.DB.Exec(ctx, `
        DELETE FROM task_assignees WHERE task_id = $1 AND principal_id = $2
    `, taskID, principal)
	return err
}

func (s *Service) Watch(ctx context.Context, taskID, principal int64) error {
	_, err := s.DB.Exec(ctx, `
        INSERT INTO task_watchers (task_id, principal_id) VALUES ($1, $2)
        ON CONFLICT DO NOTHING
    `, taskID, principal)
	return err
}

func (s *Service) Unwatch(ctx context.Context, taskID, principal int64) error {
	_, err := s.DB.Exec(ctx, `
        DELETE FROM task_watchers WHERE task_id = $1 AND principal_id = $2
    `, taskID, principal)
	return err
}

// Assignees returns principal ids currently assigned to the task.
func (s *Service) Assignees(ctx context.Context, taskID int64) ([]int64, error) {
	rows, err := s.DB.Query(ctx,
		`SELECT principal_id FROM task_assignees WHERE task_id = $1`, taskID)
	if err != nil {
		return nil, fmt.Errorf("load assignees: %w", err)
	}
	defer rows.Close()
	out := []int64{}
	for rows.Next() {
		var p int64
		if err := rows.Scan(&p); err != nil {
			return nil, err
		}
		out = append(out, p)
	}
	return out, rows.Err()
}

func (s *Service) Watchers(ctx context.Context, taskID int64) ([]int64, error) {
	rows, err := s.DB.Query(ctx,
		`SELECT principal_id FROM task_watchers WHERE task_id = $1`, taskID)
	if err != nil {
		return nil, fmt.Errorf("load watchers: %w", err)
	}
	defer rows.Close()
	out := []int64{}
	for rows.Next() {
		var p int64
		if err := rows.Scan(&p); err != nil {
			return nil, err
		}
		out = append(out, p)
	}
	return out, rows.Err()
}

// TagAttachments returns the tag rows for a task. Mirror of
// post.TagAttachments — same shape so resolvers can share helpers.
func (s *Service) TagAttachments(ctx context.Context, id int64) ([]TagRow, error) {
	rows, err := s.DB.Query(ctx, `
        SELECT tag_id, view_role, interact_role, moderate_role
        FROM task_tags WHERE task_id = $1
    `, id)
	if err != nil {
		return nil, fmt.Errorf("load task_tags: %w", err)
	}
	defer rows.Close()
	out := []TagRow{}
	for rows.Next() {
		var r TagRow
		if err := rows.Scan(&r.TagID, &r.ViewRole, &r.InteractRole, &r.ModerateRole); err != nil {
			return nil, err
		}
		out = append(out, r)
	}
	return out, rows.Err()
}

type TagRow struct {
	TagID        int64
	ViewRole     bool
	InteractRole bool
	ModerateRole bool
}

// ListByTag returns tasks attached to tagID, paginated by created_at DESC.
// Caller is responsible for visibility filtering.
func (s *Service) ListByTag(ctx context.Context, tagID int64, limit int, status *string) ([]*Task, error) {
	if limit <= 0 || limit > 100 {
		limit = 50
	}
	rows, err := s.DB.Query(ctx, `
        SELECT t.id, t.title, t.description, t.status, t.due_at,
               t.linked_post_id, t.linked_comment_id, t.created_by,
               t.created_at, t.edited_at, t.deleted_at
        FROM tasks t
        JOIN task_tags tt ON tt.task_id = t.id
        WHERE tt.tag_id = $1
          AND t.deleted_at IS NULL
          AND ($3::TEXT IS NULL OR t.status = $3)
        ORDER BY t.created_at DESC
        LIMIT $2
    `, tagID, limit, status)
	if err != nil {
		return nil, fmt.Errorf("list by tag: %w", err)
	}
	defer rows.Close()
	out := []*Task{}
	for rows.Next() {
		var t Task
		if err := rows.Scan(&t.ID, &t.Title, &t.Description, &t.Status, &t.DueAt,
			&t.LinkedPostID, &t.LinkedCommentID, &t.CreatedBy, &t.CreatedAt, &t.EditedAt, &t.DeletedAt); err != nil {
			return nil, err
		}
		out = append(out, &t)
	}
	return out, rows.Err()
}

// PromoteInput captures the fields needed to promote a post or comment
// into a task. Exactly one of PostID/CommentID must be set.
type PromoteInput struct {
	PostID    *int64
	CommentID *int64
	CreatorID int64
	Title     string
	DueAt     *time.Time
	Assignees []int64
}

// PromotePost creates a task linked to a post, copying the post's tags
// onto the new task at default role flags. Mirrors chat.PromoteMessage.
func (s *Service) PromotePost(ctx context.Context, in PromoteInput) (int64, error) {
	if in.PostID == nil {
		return int64(0), errors.New("task: PromotePost requires PostID")
	}
	var taskID int64
	err := s.runInTx(ctx, func(tx pgx.Tx) error {
		// Pull post tags to copy onto the task.
		rows, err := tx.Query(ctx, `
            SELECT tag_id FROM post_tags WHERE post_id = $1
        `, *in.PostID)
		if err != nil {
			return fmt.Errorf("load post tags: %w", err)
		}
		var tagIDs []int64
		for rows.Next() {
			var id int64
			if err := rows.Scan(&id); err != nil {
				rows.Close()
				return err
			}
			tagIDs = append(tagIDs, id)
		}
		rows.Close()
		if err := rows.Err(); err != nil {
			return err
		}

		row := tx.QueryRow(ctx, `
            INSERT INTO tasks (title, due_at, linked_post_id, created_by)
            VALUES ($1, $2, $3, $4) RETURNING id
        `, in.Title, in.DueAt, *in.PostID, in.CreatorID)
		if err := row.Scan(&taskID); err != nil {
			return fmt.Errorf("insert task: %w", err)
		}
		for _, t := range tagIDs {
			if _, err := tx.Exec(ctx, `
                INSERT INTO task_tags (task_id, tag_id) VALUES ($1, $2)
            `, taskID, t); err != nil {
				return fmt.Errorf("copy tag: %w", err)
			}
		}
		for _, p := range in.Assignees {
			if _, err := tx.Exec(ctx, `
                INSERT INTO task_assignees (task_id, principal_id, assigned_by)
                VALUES ($1, $2, $3) ON CONFLICT DO NOTHING
            `, taskID, p, in.CreatorID); err != nil {
				return err
			}
		}
		if _, err := tx.Exec(ctx, `
            INSERT INTO task_watchers (task_id, principal_id) VALUES ($1, $2)
            ON CONFLICT DO NOTHING
        `, taskID, in.CreatorID); err != nil {
			return err
		}
		return job.Enqueue(ctx, tx, "notification.fanout", map[string]any{
			"source_type": "task",
			"source_id":   ids.FormatID(taskID),
			"actor_id":    ids.FormatID(in.CreatorID),
			"event":       "created",
		})
	})
	return taskID, err
}

// PromoteComment is like PromotePost but copies tags from the comment's
// parent post.
func (s *Service) PromoteComment(ctx context.Context, in PromoteInput) (int64, error) {
	if in.CommentID == nil {
		return int64(0), errors.New("task: PromoteComment requires CommentID")
	}
	var taskID int64
	err := s.runInTx(ctx, func(tx pgx.Tx) error {
		var postID int64
		if err := tx.QueryRow(ctx,
			`SELECT post_id FROM comments WHERE id = $1`, *in.CommentID).Scan(&postID); err != nil {
			if errors.Is(err, pgx.ErrNoRows) {
				return ErrNotFound
			}
			return fmt.Errorf("load comment: %w", err)
		}
		rows, err := tx.Query(ctx,
			`SELECT tag_id FROM post_tags WHERE post_id = $1`, postID)
		if err != nil {
			return fmt.Errorf("load post tags: %w", err)
		}
		var tagIDs []int64
		for rows.Next() {
			var id int64
			if err := rows.Scan(&id); err != nil {
				rows.Close()
				return err
			}
			tagIDs = append(tagIDs, id)
		}
		rows.Close()
		if err := rows.Err(); err != nil {
			return err
		}

		row := tx.QueryRow(ctx, `
            INSERT INTO tasks (title, due_at, linked_comment_id, created_by)
            VALUES ($1, $2, $3, $4) RETURNING id
        `, in.Title, in.DueAt, *in.CommentID, in.CreatorID)
		if err := row.Scan(&taskID); err != nil {
			return fmt.Errorf("insert task: %w", err)
		}
		for _, t := range tagIDs {
			if _, err := tx.Exec(ctx, `
                INSERT INTO task_tags (task_id, tag_id) VALUES ($1, $2)
            `, taskID, t); err != nil {
				return err
			}
		}
		for _, p := range in.Assignees {
			if _, err := tx.Exec(ctx, `
                INSERT INTO task_assignees (task_id, principal_id, assigned_by)
                VALUES ($1, $2, $3) ON CONFLICT DO NOTHING
            `, taskID, p, in.CreatorID); err != nil {
				return err
			}
		}
		if _, err := tx.Exec(ctx, `
            INSERT INTO task_watchers (task_id, principal_id) VALUES ($1, $2)
            ON CONFLICT DO NOTHING
        `, taskID, in.CreatorID); err != nil {
			return err
		}
		return job.Enqueue(ctx, tx, "notification.fanout", map[string]any{
			"source_type": "task",
			"source_id":   ids.FormatID(taskID),
			"actor_id":    ids.FormatID(in.CreatorID),
			"event":       "created",
		})
	})
	return taskID, err
}

func (s *Service) runInTx(ctx context.Context, fn func(pgx.Tx) error) error {
	tx, err := s.DB.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return fmt.Errorf("begin: %w", err)
	}
	defer func() { _ = tx.Rollback(ctx) }()
	if err := fn(tx); err != nil {
		return err
	}
	return tx.Commit(ctx)
}
