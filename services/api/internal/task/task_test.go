package task_test

import (
	"context"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/task"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestCreateGetAndEditRoundTrip(t *testing.T) {
	ctx := context.Background()
	pool := pgtest.Pool(t)

	creator := seedPrincipal(t, pool, "creator@example.com")
	tagID := seedTag(t, pool, "engineering")

	svc := &task.Service{DB: pool}

	id, err := svc.Create(ctx, task.CreateInput{
		CreatorID:   creator,
		Title:       "Investigate flake",
		Description: "stack trace in logs",
		Tags: []task.TagAttachment{{
			TagID:    tagID,
			ViewRole: true,
		}},
	})
	if err != nil {
		t.Fatalf("create: %v", err)
	}

	got, err := svc.Get(ctx, id)
	if err != nil {
		t.Fatalf("get: %v", err)
	}
	if got.Title != "Investigate flake" {
		t.Errorf("title: got %q want %q", got.Title, "Investigate flake")
	}
	if got.Status != "open" {
		t.Errorf("status: got %q want %q", got.Status, "open")
	}
	if got.CreatedBy != creator {
		t.Errorf("created_by: got %d want %d", got.CreatedBy, creator)
	}

	// Creator should be auto-watching.
	watchers, err := svc.Watchers(ctx, id)
	if err != nil {
		t.Fatalf("watchers: %v", err)
	}
	if len(watchers) != 1 || watchers[0] != creator {
		t.Errorf("watchers: got %v want [%d]", watchers, creator)
	}

	// Create enqueues a notification.fanout job in the same tx. Confirm
	// the row landed — proves the cross-package job.Enqueue wiring works
	// without booting a worker.
	var jobs int
	if err := pool.QueryRow(ctx,
		`SELECT count(*) FROM jobs WHERE kind = 'notification.fanout'`).
		Scan(&jobs); err != nil {
		t.Fatalf("count jobs: %v", err)
	}
	if jobs != 1 {
		t.Errorf("expected 1 notification.fanout job after Create, got %d", jobs)
	}

	newTitle := "Investigate flake (urgent)"
	if err := svc.Edit(ctx, id, &newTitle, nil, nil, false); err != nil {
		t.Fatalf("edit: %v", err)
	}
	got, err = svc.Get(ctx, id)
	if err != nil {
		t.Fatalf("get after edit: %v", err)
	}
	if got.Title != newTitle {
		t.Errorf("title after edit: got %q want %q", got.Title, newTitle)
	}
	if got.EditedAt == nil {
		t.Error("expected edited_at to be set after Edit")
	}

	if err := svc.SetStatus(ctx, id, "done"); err != nil {
		t.Fatalf("set status: %v", err)
	}
	got, _ = svc.Get(ctx, id)
	if got.Status != "done" {
		t.Errorf("status after SetStatus: got %q want done", got.Status)
	}

	if err := svc.SetStatus(ctx, id, "not-a-real-status"); err != task.ErrInvalidStatus {
		t.Errorf("expected ErrInvalidStatus, got %v", err)
	}

	if err := svc.Delete(ctx, id); err != nil {
		t.Fatalf("delete: %v", err)
	}
	got, err = svc.Get(ctx, id)
	if err != nil {
		t.Fatalf("get after delete: %v", err)
	}
	if got.DeletedAt == nil {
		t.Error("expected deleted_at to be populated after Delete (soft-delete)")
	}
	// A second Delete is a no-op (row already soft-deleted) — must
	// return ErrNotFound so callers can distinguish from success.
	if err := svc.Delete(ctx, id); err != task.ErrNotFound {
		t.Errorf("second Delete: got %v want %v", err, task.ErrNotFound)
	}
}

func TestAssignIsIdempotent(t *testing.T) {
	ctx := context.Background()
	pool := pgtest.Pool(t)

	creator := seedPrincipal(t, pool, "c@example.com")
	assignee := seedPrincipal(t, pool, "a@example.com")
	tagID := seedTag(t, pool, "team")

	svc := &task.Service{DB: pool}
	id, err := svc.Create(ctx, task.CreateInput{
		CreatorID: creator,
		Title:     "T",
		Tags:      []task.TagAttachment{{TagID: tagID, ViewRole: true}},
	})
	if err != nil {
		t.Fatalf("create: %v", err)
	}

	if err := svc.Assign(ctx, id, assignee, creator); err != nil {
		t.Fatalf("assign 1: %v", err)
	}
	// Second Assign call with same args must not enqueue a second job.
	if err := svc.Assign(ctx, id, assignee, creator); err != nil {
		t.Fatalf("assign 2: %v", err)
	}

	var assignJobs int
	if err := pool.QueryRow(ctx, `
        SELECT count(*) FROM jobs
        WHERE kind = 'notification.fanout'
          AND payload->>'event' = 'assigned'
    `).Scan(&assignJobs); err != nil {
		t.Fatalf("count assigned jobs: %v", err)
	}
	if assignJobs != 1 {
		t.Errorf("expected 1 'assigned' job after duplicate Assign, got %d", assignJobs)
	}

	got, err := svc.Assignees(ctx, id)
	if err != nil {
		t.Fatalf("assignees: %v", err)
	}
	if len(got) != 1 || got[0] != assignee {
		t.Errorf("assignees: got %v want [%d]", got, assignee)
	}
}

func seedPrincipal(t *testing.T, pool *pgxpool.Pool, email string) int64 {
	t.Helper()
	id := ids.New(ids.KindUser)
	if _, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, $3, $4)
    `, id, "local://principals/"+ids.FormatID(id), email, email); err != nil {
		t.Fatalf("seed principal: %v", err)
	}
	return id
}

func seedTag(t *testing.T, pool *pgxpool.Pool, slug string) int64 {
	t.Helper()
	id := ids.New(ids.KindTag)
	ctx := context.Background()
	if _, err := pool.Exec(ctx, `
        INSERT INTO tags (id, parent_id, slug, display_name, root_kind, defaults)
        VALUES ($1, NULL, $2, $2, 'org', '{}')
    `, id, slug); err != nil {
		t.Fatalf("seed tag: %v", err)
	}
	if _, err := pool.Exec(ctx,
		`INSERT INTO tag_closure (ancestor_id, descendant_id, depth) VALUES ($1, $1, 0)`,
		id); err != nil {
		t.Fatalf("seed tag closure: %v", err)
	}
	return id
}
