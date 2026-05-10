// Package job is the v1 background-job runner. M4 wires it up: a typed
// handler registry, a queue that workers claim with FOR UPDATE SKIP
// LOCKED, exponential retries, and a worker pool driven by a poll loop.
//
// Adding a new job kind:
//
//  1. Define a payload struct and json-(un)marshal it.
//  2. Register a handler at startup: registry.Register("kind",
//     func(ctx, payload) error { ... }).
//  3. Producers call job.Enqueue(ctx, tx, "kind", payload) inside the
//     same transaction as the underlying write so the job is atomic
//     with the state change that triggered it.
//
// This is intentionally Postgres-only — no Redis, no separate broker.
// Q. why not pgmq? It's a fine choice but adds an extension we don't
// otherwise need. The standard SKIP LOCKED pattern is good enough up to
// tens of thousands of jobs/min on modest hardware, well past v1 needs.
package job

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log/slog"
	"math/rand/v2"
	"runtime/debug"
	"sync"
	"time"

	"github.com/jackc/pgx/v5/pgconn"
	"github.com/jackc/pgx/v5/pgxpool"
)

// Querier accepts both *pgxpool.Pool and pgx.Tx so producers can enqueue
// inside their transaction.
type Querier interface {
	Exec(ctx context.Context, sql string, args ...any) (pgconn.CommandTag, error)
}

// HandlerFunc handles one job. The framework hands it the raw JSON
// payload — the handler does its own typed unmarshal so the registry
// stays generic.
type HandlerFunc func(ctx context.Context, payload json.RawMessage) error

// Registry maps job kind → handler. Safe for concurrent reads after the
// last Register call (typically at startup). Don't register from
// goroutines.
type Registry struct {
	mu       sync.RWMutex
	handlers map[string]HandlerFunc
}

// NewRegistry returns an empty registry.
func NewRegistry() *Registry {
	return &Registry{handlers: map[string]HandlerFunc{}}
}

// Register associates a handler with a kind. Panics on duplicate
// registration so tests catch it loudly.
func (r *Registry) Register(kind string, fn HandlerFunc) {
	r.mu.Lock()
	defer r.mu.Unlock()
	if _, exists := r.handlers[kind]; exists {
		panic(fmt.Sprintf("job: handler already registered for kind %q", kind))
	}
	r.handlers[kind] = fn
}

func (r *Registry) lookup(kind string) (HandlerFunc, bool) {
	r.mu.RLock()
	defer r.mu.RUnlock()
	h, ok := r.handlers[kind]
	return h, ok
}

// Enqueue inserts a pending job. q is a tx if you want atomicity with
// the surrounding write; pass the pool for a fire-and-forget enqueue.
func Enqueue(ctx context.Context, q Querier, kind string, payload any) error {
	bs, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("marshal job payload: %w", err)
	}
	if _, err := q.Exec(ctx, `
        INSERT INTO jobs (kind, payload) VALUES ($1, $2)
    `, kind, bs); err != nil {
		return fmt.Errorf("insert job: %w", err)
	}
	return nil
}

// EnqueueAt schedules a job to run no earlier than runAt.
func EnqueueAt(ctx context.Context, q Querier, kind string, payload any, runAt time.Time) error {
	bs, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("marshal job payload: %w", err)
	}
	if _, err := q.Exec(ctx, `
        INSERT INTO jobs (kind, payload, run_at) VALUES ($1, $2, $3)
    `, kind, bs, runAt); err != nil {
		return fmt.Errorf("insert delayed job: %w", err)
	}
	return nil
}

// Worker polls the jobs table and dispatches to registered handlers.
// One Worker runs in a goroutine in --mode=worker or --mode=both.
type Worker struct {
	DB         *pgxpool.Pool
	Logger     *slog.Logger
	Registry   *Registry
	WorkerName string

	// PollInterval controls how often the worker scans for pending jobs
	// when the previous scan was idle. Defaults to 1s.
	PollInterval time.Duration

	// BatchSize is the max jobs claimed per poll. Defaults to 8.
	BatchSize int
}

// Run blocks until ctx is cancelled. The poll loop runs continuously:
// claim a batch, dispatch, and either sleep PollInterval (idle) or
// loop again immediately (work was available).
func (w *Worker) Run(ctx context.Context) error {
	if w.Logger == nil {
		w.Logger = slog.Default()
	}
	if w.Registry == nil {
		return errors.New("job: Worker.Registry is required")
	}
	if w.PollInterval == 0 {
		w.PollInterval = time.Second
	}
	if w.BatchSize == 0 {
		w.BatchSize = 8
	}
	if w.WorkerName == "" {
		w.WorkerName = "pulse-worker"
	}

	w.Logger.Info("worker started", "name", w.WorkerName, "poll", w.PollInterval, "batch", w.BatchSize)
	for {
		select {
		case <-ctx.Done():
			w.Logger.Info("worker shutting down")
			return nil
		default:
		}
		n, err := w.tick(ctx)
		if err != nil {
			w.Logger.Error("worker tick", "err", err)
		}
		if n == 0 {
			select {
			case <-ctx.Done():
				return nil
			case <-time.After(w.PollInterval):
			}
		}
	}
}

// RunOnce drains the queue once and returns. Useful in tests.
func (w *Worker) RunOnce(ctx context.Context) (int, error) {
	if w.Registry == nil {
		return 0, errors.New("job: Worker.Registry is required")
	}
	if w.BatchSize == 0 {
		w.BatchSize = 8
	}
	if w.WorkerName == "" {
		w.WorkerName = "pulse-worker"
	}
	if w.Logger == nil {
		w.Logger = slog.Default()
	}
	total := 0
	for {
		n, err := w.tick(ctx)
		if err != nil {
			return total, err
		}
		total += n
		if n == 0 {
			return total, nil
		}
	}
}

type claimedJob struct {
	id          int64
	kind        string
	payload     json.RawMessage
	attempts    int
	maxAttempts int
}

// tick claims up to BatchSize pending jobs, dispatches each, and returns
// the count processed. Errors come back when the *claim* fails — handler
// failures are recorded on the job row and don't bubble up here.
func (w *Worker) tick(ctx context.Context) (int, error) {
	tx, err := w.DB.Begin(ctx)
	if err != nil {
		return 0, fmt.Errorf("begin tx: %w", err)
	}
	rolled := false
	defer func() {
		if !rolled {
			_ = tx.Rollback(ctx)
		}
	}()

	// SKIP LOCKED + LIMIT lets multiple workers fight over the same queue
	// without blocking. The UPDATE flips status so the job is invisible
	// to a second poller while we work it.
	rows, err := tx.Query(ctx, `
        WITH claimed AS (
            SELECT id
            FROM jobs
            WHERE status = 'pending'
              AND run_at <= now()
            ORDER BY run_at
            FOR UPDATE SKIP LOCKED
            LIMIT $1
        )
        UPDATE jobs j
           SET status     = 'running',
               locked_at  = now(),
               locked_by  = $2,
               attempts   = j.attempts + 1
          FROM claimed
         WHERE j.id = claimed.id
         RETURNING j.id, j.kind, j.payload, j.attempts, j.max_attempts
    `, w.BatchSize, w.WorkerName)
	if err != nil {
		return 0, fmt.Errorf("claim jobs: %w", err)
	}

	var jobs []claimedJob
	for rows.Next() {
		var j claimedJob
		if err := rows.Scan(&j.id, &j.kind, &j.payload, &j.attempts, &j.maxAttempts); err != nil {
			rows.Close()
			return 0, fmt.Errorf("scan job: %w", err)
		}
		jobs = append(jobs, j)
	}
	rows.Close()
	if err := rows.Err(); err != nil {
		return 0, err
	}

	if err := tx.Commit(ctx); err != nil {
		return 0, fmt.Errorf("commit claim: %w", err)
	}
	rolled = true

	for _, j := range jobs {
		w.dispatch(ctx, j)
	}
	return len(jobs), nil
}

// dispatch runs one handler and writes back terminal status. Handler
// panics are caught so one bad payload can't take the worker down.
func (w *Worker) dispatch(ctx context.Context, j claimedJob) {
	handler, ok := w.Registry.lookup(j.kind)
	if !ok {
		w.markFailed(ctx, j, fmt.Sprintf("no handler registered for kind %q", j.kind))
		return
	}

	start := time.Now()
	var runErr error
	func() {
		defer func() {
			if r := recover(); r != nil {
				runErr = fmt.Errorf("handler panic: %v\n%s", r, debug.Stack())
			}
		}()
		runErr = handler(ctx, j.payload)
	}()
	dur := time.Since(start)

	if runErr == nil {
		if _, err := w.DB.Exec(ctx, `
            UPDATE jobs
               SET status = 'done',
                   locked_at = NULL,
                   locked_by = NULL,
                   last_error = NULL
             WHERE id = $1
        `, j.id); err != nil {
			w.Logger.Error("mark job done", "id", j.id, "err", err)
		}
		w.Logger.Debug("job ok", "id", j.id, "kind", j.kind, "dur", dur)
		return
	}

	if j.attempts >= j.maxAttempts {
		w.markFailed(ctx, j, runErr.Error())
		w.Logger.Warn("job exhausted", "id", j.id, "kind", j.kind, "attempts", j.attempts, "err", runErr)
		return
	}
	// Exponential backoff with jitter — quadratic-ish for first few then
	// flattens. Capped so a slow-failing job doesn't drift into next year.
	backoff := nextBackoff(j.attempts)
	if _, err := w.DB.Exec(ctx, `
        UPDATE jobs
           SET status     = 'pending',
               run_at     = now() + ($2 || ' seconds')::interval,
               locked_at  = NULL,
               locked_by  = NULL,
               last_error = $3
         WHERE id = $1
    `, j.id, fmt.Sprintf("%.3f", backoff.Seconds()), runErr.Error()); err != nil {
		w.Logger.Error("retry-schedule job", "id", j.id, "err", err)
	}
	w.Logger.Info("job retry scheduled", "id", j.id, "kind", j.kind, "attempts", j.attempts, "backoff", backoff, "err", runErr)
}

func (w *Worker) markFailed(ctx context.Context, j claimedJob, msg string) {
	if _, err := w.DB.Exec(ctx, `
        UPDATE jobs
           SET status = 'failed',
               locked_at = NULL,
               locked_by = NULL,
               last_error = $2
         WHERE id = $1
    `, j.id, msg); err != nil {
		w.Logger.Error("mark job failed", "id", j.id, "err", err)
	}
}

func nextBackoff(attempts int) time.Duration {
	// 2s, 4s, 8s, 16s, 30s, 60s, 60s ... with ±20% jitter.
	base := time.Duration(1<<min(attempts, 6)) * time.Second
	if base > time.Minute {
		base = time.Minute
	}
	jitter := 1 + (rand.Float64()*0.4 - 0.2)
	return time.Duration(float64(base) * jitter)
}
