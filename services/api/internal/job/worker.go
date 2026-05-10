// Package job is the v1 background-job runner. M0 ships only the worker
// loop scaffold; the jobs table, handler registry, and SELECT FOR UPDATE
// SKIP LOCKED dispatch land in M4 alongside notifications.
package job

import (
	"context"
	"log/slog"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

// Worker polls the jobs table and dispatches to registered handlers.
// In --mode=worker or --mode=both processes one Worker runs in a goroutine.
type Worker struct {
	DB     *pgxpool.Pool
	Logger *slog.Logger
}

// Run blocks until ctx is cancelled. M0 is a heartbeat-only stub.
func (w *Worker) Run(ctx context.Context) error {
	w.Logger.Info("worker started (M0 stub)")
	ticker := time.NewTicker(5 * time.Second)
	defer ticker.Stop()
	for {
		select {
		case <-ctx.Done():
			w.Logger.Info("worker shutting down")
			return nil
		case <-ticker.C:
			// M4: claim and dispatch jobs here.
		}
	}
}
