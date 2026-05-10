// Package retention hard-deletes content past
// workspace_config.retention_window_days after its soft-delete. The
// architecture treats soft-delete as "user disappeared this from view"
// and retention sweep as "operator promised to forget it for real".
//
// The sweep runs as a job kind, scheduled at boot from --mode=worker.
// We don't pre-emptively delete bucket bytes here — the attachment
// row's storage_key is what links to the bucket, and a bucket
// lifecycle policy is the right tool for byte-level expiry.
package retention

import (
	"context"
	"encoding/json"
	"fmt"
	"log/slog"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

const JobKind = "retention.sweep"

// Service runs sweeps. Tests can call Sweep directly without the job
// queue.
type Service struct {
	DB     *pgxpool.Pool
	Logger *slog.Logger
}

// SweepResult counts what got purged. Useful for the slog output and
// for tests asserting sweep behavior.
type SweepResult struct {
	Posts             int64
	Comments          int64
	Messages          int64
	Tasks             int64
	Attachments       int64
	NotificationsRead int64
	WindowDays        int
}

// Sweep does one pass: find rows with deleted_at older than the
// retention window and DELETE them. Cascading FKs handle their own
// dependents (post_tags, comment_mentions, etc.) so the per-table
// DELETEs are simple.
func (s *Service) Sweep(ctx context.Context) (*SweepResult, error) {
	var window int
	if err := s.DB.QueryRow(ctx,
		`SELECT retention_window_days FROM workspace_config WHERE id = 1`).
		Scan(&window); err != nil {
		return nil, fmt.Errorf("load retention window: %w", err)
	}
	cutoff := time.Now().Add(-time.Duration(window) * 24 * time.Hour)
	out := &SweepResult{WindowDays: window}

	// Hard-delete soft-deleted content older than the cutoff. ON DELETE
	// CASCADE on dependents (mentions, tags) propagates.
	tag, err := s.DB.Exec(ctx,
		`DELETE FROM posts WHERE deleted_at IS NOT NULL AND deleted_at < $1`, cutoff)
	if err != nil {
		return nil, fmt.Errorf("delete posts: %w", err)
	}
	out.Posts = tag.RowsAffected()

	tag, err = s.DB.Exec(ctx,
		`DELETE FROM comments WHERE deleted_at IS NOT NULL AND deleted_at < $1`, cutoff)
	if err != nil {
		return nil, fmt.Errorf("delete comments: %w", err)
	}
	out.Comments = tag.RowsAffected()

	tag, err = s.DB.Exec(ctx,
		`DELETE FROM messages WHERE deleted_at IS NOT NULL AND deleted_at < $1`, cutoff)
	if err != nil {
		return nil, fmt.Errorf("delete messages: %w", err)
	}
	out.Messages = tag.RowsAffected()

	tag, err = s.DB.Exec(ctx,
		`DELETE FROM tasks WHERE deleted_at IS NOT NULL AND deleted_at < $1`, cutoff)
	if err != nil {
		return nil, fmt.Errorf("delete tasks: %w", err)
	}
	out.Tasks = tag.RowsAffected()

	// Attachments: tombstoned past cutoff. The bytes in the bucket are
	// reclaimed by the bucket's lifecycle rule; we delete only the row
	// here so reads stop counting them.
	tag, err = s.DB.Exec(ctx, `
        DELETE FROM attachments
         WHERE state = 'tombstoned' AND created_at < $1
    `, cutoff)
	if err != nil {
		return nil, fmt.Errorf("delete attachments: %w", err)
	}
	out.Attachments = tag.RowsAffected()

	// Notifications: read notifications past cutoff. Unread stays —
	// dropping unread on retention would surprise users.
	tag, err = s.DB.Exec(ctx, `
        DELETE FROM notifications
         WHERE read_at IS NOT NULL AND read_at < $1
    `, cutoff)
	if err != nil {
		return nil, fmt.Errorf("delete notifications: %w", err)
	}
	out.NotificationsRead = tag.RowsAffected()

	if s.Logger != nil {
		s.Logger.Info("retention.sweep",
			"window_days", window,
			"posts", out.Posts,
			"comments", out.Comments,
			"messages", out.Messages,
			"tasks", out.Tasks,
			"attachments", out.Attachments,
			"notifications_read", out.NotificationsRead,
		)
	}
	return out, nil
}

// Handler is the worker handler for retention.sweep jobs. Wire into
// the registry at startup.
func (s *Service) Handler(ctx context.Context, _ json.RawMessage) error {
	_, err := s.Sweep(ctx)
	return err
}
