package db_test

import (
	"context"
	"path/filepath"
	"runtime"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/db"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
)

// repoMigrationsDir returns the absolute path to db/migrations, mirroring
// internal/pgtest's approach so this test works regardless of the cwd
// the test runner picks.
func repoMigrationsDir(t *testing.T) string {
	t.Helper()
	_, file, _, _ := runtime.Caller(0)
	// file is .../services/api/internal/db/db_test.go
	return filepath.Join(file, "..", "..", "..", "..", "..", "db", "migrations")
}

func TestNewPoolPingsAndQueriesMigratedSchema(t *testing.T) {
	ctx := context.Background()
	dsn := pgtest.DSN(t)

	pool, err := db.NewPool(ctx, dsn)
	if err != nil {
		t.Fatalf("NewPool: %v", err)
	}
	t.Cleanup(pool.Close)

	// workspace_config is seeded by migrations with id=1 — confirms goose
	// has run successfully against this DSN.
	var window int
	if err := pool.QueryRow(ctx,
		`SELECT retention_window_days FROM workspace_config WHERE id = 1`).
		Scan(&window); err != nil {
		t.Fatalf("query workspace_config: %v", err)
	}
	if window <= 0 {
		t.Errorf("retention_window_days: got %d, expected positive seeded value", window)
	}
}

func TestMigrateIsIdempotent(t *testing.T) {
	// pgtest already runs goose to set up the DSN. Calling Migrate again
	// must be a no-op — guards against a future change that re-runs
	// already-applied versions on startup.
	dsn := pgtest.DSN(t)
	migrationsDir := repoMigrationsDir(t)

	if err := db.Migrate(context.Background(), dsn, migrationsDir); err != nil {
		t.Fatalf("re-Migrate: %v", err)
	}
}
