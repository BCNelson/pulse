package main

import (
	"context"
	"io"
	"log/slog"
	"testing"
	"time"

	pulsejob "github.com/bcnelson/pulse/services/api/internal/job"
	pulsenotification "github.com/bcnelson/pulse/services/api/internal/notification"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	pulseretention "github.com/bcnelson/pulse/services/api/internal/retention"
)

// TestWorkerBootDrainsRetentionSweep exercises the exact wiring that
// --mode=worker uses: build the registry via newJobRegistry, construct
// a Worker with the same fields run() does, enqueue a registered kind,
// and confirm RunOnce drains it to status='done'. Catches
// handler-registration drift (e.g. someone removes a Register call) and
// schema/poll-query drift that internal/job tests alone wouldn't see
// because they don't go through main's wiring.
func TestWorkerBootDrainsRetentionSweep(t *testing.T) {
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	pool := pgtest.Pool(t)
	logger := slog.New(slog.NewTextHandler(io.Discard, nil))

	notifSvc := &pulsenotification.Service{DB: pool}
	retentionSvc := &pulseretention.Service{DB: pool, Logger: logger}
	registry := newJobRegistry(notifSvc, retentionSvc)

	// Sanity: both expected kinds are registered. Use Enqueue+RunOnce as
	// the observation channel since Registry.lookup is unexported — an
	// unknown kind would mark the job 'failed' with a "no handler"
	// error, which we'd catch below.
	if err := pulsejob.Enqueue(ctx, pool, pulseretention.JobKind, map[string]any{}); err != nil {
		t.Fatalf("enqueue retention.sweep: %v", err)
	}

	worker := &pulsejob.Worker{
		DB:       pool,
		Logger:   logger,
		Registry: registry,
	}
	n, err := worker.RunOnce(ctx)
	if err != nil {
		t.Fatalf("RunOnce: %v", err)
	}
	if n != 1 {
		t.Fatalf("processed: got %d want 1", n)
	}

	var status string
	var lastErr *string
	if err := pool.QueryRow(ctx, `
        SELECT status, last_error FROM jobs WHERE kind = $1
    `, pulseretention.JobKind).Scan(&status, &lastErr); err != nil {
		t.Fatalf("scan job: %v", err)
	}
	if status != "done" {
		errStr := ""
		if lastErr != nil {
			errStr = *lastErr
		}
		t.Errorf("status: got %q want %q (last_error=%q)", status, "done", errStr)
	}
}

func TestWorkerBootUnknownKindMarksFailed(t *testing.T) {
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	pool := pgtest.Pool(t)
	logger := slog.New(slog.NewTextHandler(io.Discard, nil))
	registry := newJobRegistry(
		&pulsenotification.Service{DB: pool},
		&pulseretention.Service{DB: pool, Logger: logger},
	)

	if err := pulsejob.Enqueue(ctx, pool, "not.a.registered.kind", map[string]any{}); err != nil {
		t.Fatalf("enqueue: %v", err)
	}

	worker := &pulsejob.Worker{DB: pool, Logger: logger, Registry: registry}
	if _, err := worker.RunOnce(ctx); err != nil {
		t.Fatalf("RunOnce: %v", err)
	}

	var status string
	if err := pool.QueryRow(ctx,
		`SELECT status FROM jobs WHERE kind = 'not.a.registered.kind'`).Scan(&status); err != nil {
		t.Fatalf("scan: %v", err)
	}
	if status != "failed" {
		t.Errorf("status: got %q want failed", status)
	}
}
