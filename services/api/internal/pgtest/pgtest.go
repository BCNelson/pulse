// Package pgtest is the integration-test harness for Postgres-backed
// services. Each test calls Pool(t) to receive a freshly migrated, freshly
// truncated database. Tests skip themselves when PULSE_TEST_DB_URL is unset
// so this package stays a no-op in environments without Postgres.
package pgtest

import (
	"context"
	"os"
	"path/filepath"
	"runtime"
	"sync"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"

	pulsedb "github.com/bcnelson/pulse/services/api/internal/db"
)

const envURL = "PULSE_TEST_DB_URL"

var (
	migrateOnce sync.Once
	migrateErr  error
)

// Pool returns a *pgxpool.Pool against the test database. The schema is
// migrated to head exactly once per process; data is truncated on every
// call so tests stay independent.
func Pool(t *testing.T) *pgxpool.Pool {
	t.Helper()
	dsn := os.Getenv(envURL)
	if dsn == "" {
		t.Skipf("%s not set; skipping integration test", envURL)
	}

	migrateOnce.Do(func() {
		migrateErr = pulsedb.Migrate(context.Background(), dsn, migrationsDir())
	})
	if migrateErr != nil {
		t.Fatalf("migrate test db: %v", migrateErr)
	}

	pool, err := pulsedb.NewPool(context.Background(), dsn)
	if err != nil {
		t.Fatalf("open test pool: %v", err)
	}
	t.Cleanup(pool.Close)

	truncate(t, pool)
	return pool
}

// truncate wipes all writable tables. workspace_config is left intact since
// it's a singleton bootstrap row.
func truncate(t *testing.T, pool *pgxpool.Pool) {
	t.Helper()
	_, err := pool.Exec(context.Background(), `
        TRUNCATE
            audit_events,
            tag_grants,
            subscriptions,
            tag_closure,
            user_credentials,
            bot_credentials,
            tags,
            principals
        RESTART IDENTITY CASCADE
    `)
	if err != nil {
		t.Fatalf("truncate: %v", err)
	}
}

// migrationsDir returns the absolute path to db/migrations relative to this
// source file, so tests work regardless of the cwd Go's test runner picks.
func migrationsDir() string {
	_, file, _, _ := runtime.Caller(0)
	// file is .../services/api/internal/pgtest/pgtest.go
	return filepath.Join(file, "..", "..", "..", "..", "..", "db", "migrations")
}
