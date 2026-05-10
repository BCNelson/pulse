package job_test

import (
	"context"
	"encoding/json"
	"errors"
	"log/slog"
	"os"
	"sync/atomic"
	"testing"
	"time"

	"github.com/bcnelson/pulse/services/api/internal/job"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
)

func newWorker(t *testing.T, reg *job.Registry) *job.Worker {
	t.Helper()
	pool := pgtest.Pool(t)
	return &job.Worker{
		DB:         pool,
		Registry:   reg,
		Logger:     slog.New(slog.NewTextHandler(os.Stderr, nil)),
		WorkerName: "test-worker",
		BatchSize:  4,
	}
}

func TestEnqueueRunsHandler(t *testing.T) {
	reg := job.NewRegistry()
	var runs atomic.Int32
	reg.Register("count", func(ctx context.Context, p json.RawMessage) error {
		runs.Add(1)
		return nil
	})

	w := newWorker(t, reg)

	if err := job.Enqueue(context.Background(), w.DB, "count", map[string]int{"n": 1}); err != nil {
		t.Fatalf("enqueue: %v", err)
	}
	if err := job.Enqueue(context.Background(), w.DB, "count", map[string]int{"n": 2}); err != nil {
		t.Fatalf("enqueue: %v", err)
	}

	processed, err := w.RunOnce(context.Background())
	if err != nil {
		t.Fatalf("run: %v", err)
	}
	if processed != 2 {
		t.Errorf("processed: got %d want 2", processed)
	}
	if runs.Load() != 2 {
		t.Errorf("runs: got %d want 2", runs.Load())
	}

	// Both jobs should be terminal.
	var pending int
	if err := w.DB.QueryRow(context.Background(),
		`SELECT count(*) FROM jobs WHERE status = 'pending'`).Scan(&pending); err != nil {
		t.Fatalf("count: %v", err)
	}
	if pending != 0 {
		t.Errorf("expected 0 pending jobs, got %d", pending)
	}
}

func TestHandlerErrorRetriesUntilExhausted(t *testing.T) {
	reg := job.NewRegistry()
	reg.Register("always-fails", func(ctx context.Context, p json.RawMessage) error {
		return errors.New("boom")
	})

	w := newWorker(t, reg)

	// Insert with max_attempts=2 so we can drive it to exhaustion fast.
	if _, err := w.DB.Exec(context.Background(), `
        INSERT INTO jobs (kind, payload, max_attempts) VALUES ('always-fails', '{}', 2)
    `); err != nil {
		t.Fatalf("insert: %v", err)
	}

	// First tick: handler fails, retry scheduled in the future.
	if _, err := w.RunOnce(context.Background()); err != nil {
		t.Fatalf("run1: %v", err)
	}
	var status string
	var attempts int
	row := w.DB.QueryRow(context.Background(),
		`SELECT status, attempts FROM jobs WHERE kind = 'always-fails'`)
	if err := row.Scan(&status, &attempts); err != nil {
		t.Fatalf("scan1: %v", err)
	}
	if status != "pending" || attempts != 1 {
		t.Errorf("after 1st run: status=%s attempts=%d (want pending,1)", status, attempts)
	}

	// Force run_at to now so the retry is immediately claimable.
	if _, err := w.DB.Exec(context.Background(),
		`UPDATE jobs SET run_at = now() WHERE kind = 'always-fails'`); err != nil {
		t.Fatalf("rewind run_at: %v", err)
	}
	if _, err := w.RunOnce(context.Background()); err != nil {
		t.Fatalf("run2: %v", err)
	}

	row = w.DB.QueryRow(context.Background(),
		`SELECT status, attempts, last_error FROM jobs WHERE kind = 'always-fails'`)
	var lastErr *string
	if err := row.Scan(&status, &attempts, &lastErr); err != nil {
		t.Fatalf("scan2: %v", err)
	}
	if status != "failed" {
		t.Errorf("expected failed after exhaustion, got %s", status)
	}
	if attempts != 2 {
		t.Errorf("attempts: got %d want 2", attempts)
	}
	if lastErr == nil || *lastErr == "" {
		t.Errorf("expected last_error populated")
	}
}

func TestUnknownKindMarksFailed(t *testing.T) {
	w := newWorker(t, job.NewRegistry())
	if err := job.Enqueue(context.Background(), w.DB, "no-such-kind", map[string]any{}); err != nil {
		t.Fatalf("enqueue: %v", err)
	}
	if _, err := w.RunOnce(context.Background()); err != nil {
		t.Fatalf("run: %v", err)
	}
	var status, lastErr string
	if err := w.DB.QueryRow(context.Background(),
		`SELECT status, last_error FROM jobs WHERE kind = 'no-such-kind'`).
		Scan(&status, &lastErr); err != nil {
		t.Fatalf("scan: %v", err)
	}
	if status != "failed" {
		t.Errorf("status: got %s want failed", status)
	}
	if lastErr == "" {
		t.Errorf("expected last_error set")
	}
}

func TestDelayedJobDoesNotRunYet(t *testing.T) {
	reg := job.NewRegistry()
	var ran atomic.Bool
	reg.Register("delayed", func(ctx context.Context, p json.RawMessage) error {
		ran.Store(true)
		return nil
	})

	w := newWorker(t, reg)
	future := time.Now().Add(10 * time.Minute)
	if err := job.EnqueueAt(context.Background(), w.DB, "delayed", map[string]any{}, future); err != nil {
		t.Fatalf("enqueue: %v", err)
	}

	processed, err := w.RunOnce(context.Background())
	if err != nil {
		t.Fatalf("run: %v", err)
	}
	if processed != 0 {
		t.Errorf("processed: got %d want 0", processed)
	}
	if ran.Load() {
		t.Errorf("delayed handler ran prematurely")
	}
}
