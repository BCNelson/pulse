// Package pgtest is the integration-test harness for Postgres-backed
// services. Each test calls Pool(t) to receive a freshly migrated, isolated
// database. A single Postgres testcontainer is started lazily per test
// process; pgtestdb caches the migrated schema as a template and clones a
// fresh database for every test, dropping it on cleanup.
package pgtest

import (
	"context"
	"fmt"
	"os"
	"path/filepath"
	"runtime"
	"sync"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"
	_ "github.com/jackc/pgx/v5/stdlib" // register the pgx driver for database/sql so pgtestdb can connect to the template DB
	"github.com/peterldowns/pgtestdb"
	"github.com/peterldowns/pgtestdb/migrators/goosemigrator"
	"github.com/testcontainers/testcontainers-go/modules/postgres"
)

const (
	pgImage    = "postgres:16-alpine"
	pgUser     = "pulse"
	pgPassword = "pulse"
	pgDatabase = "pulse"
)

var (
	containerOnce sync.Once
	baseConf      pgtestdb.Config
	startErr      error
)

func startContainer() {
	ctx := context.Background()
	c, err := postgres.Run(ctx, pgImage,
		postgres.WithDatabase(pgDatabase),
		postgres.WithUsername(pgUser),
		postgres.WithPassword(pgPassword),
		postgres.BasicWaitStrategies(),
	)
	if err != nil {
		startErr = fmt.Errorf("start postgres container: %w", err)
		return
	}
	host, err := c.Host(ctx)
	if err != nil {
		startErr = fmt.Errorf("container host: %w", err)
		return
	}
	port, err := c.MappedPort(ctx, "5432/tcp")
	if err != nil {
		startErr = fmt.Errorf("container port: %w", err)
		return
	}
	baseConf = pgtestdb.Config{
		DriverName: "pgx",
		Host:       host,
		Port:       port.Port(),
		User:       pgUser,
		Password:   pgPassword,
		Database:   pgDatabase,
		Options:    "sslmode=disable",
	}
}

// Pool returns a *pgxpool.Pool against a fresh, fully-migrated database. The
// underlying Postgres container is shared across all tests in the process;
// each test gets its own database via pgtestdb's template-clone strategy.
// pgtestdb registers a t.Cleanup that drops the database after the test;
// the pool itself is closed via a separate t.Cleanup here.
func Pool(t *testing.T) *pgxpool.Pool {
	pool, _ := PoolAndDSN(t)
	return pool
}

// DSN returns the connection string for a fresh, fully-migrated database.
// Use this for tests that need a connection beyond the pgxpool — for example,
// realtime tests that open their own LISTEN connection.
func DSN(t *testing.T) string {
	return newDB(t)
}

// PoolAndDSN is like Pool but also returns the underlying DSN, so callers
// that need both a pool and an extra side connection (e.g., LISTEN/NOTIFY)
// can target the same database.
func PoolAndDSN(t *testing.T) (*pgxpool.Pool, string) {
	t.Helper()
	dsn := newDB(t)
	pool, err := pgxpool.New(context.Background(), dsn)
	if err != nil {
		t.Fatalf("open test pool: %v", err)
	}
	t.Cleanup(pool.Close)
	return pool, dsn
}

func newDB(t *testing.T) string {
	t.Helper()
	containerOnce.Do(startContainer)
	if startErr != nil {
		t.Fatalf("%v", startErr)
	}
	// goosemigrator treats its dir argument as a path inside its FS, and the
	// default FS is os.DirFS(".") which rejects absolute paths via fs.Sub.
	// Mount our absolute path as the FS root and pass "." instead.
	mig := goosemigrator.New(".", goosemigrator.WithFS(os.DirFS(migrationsDir())))
	return pgtestdb.Custom(t, baseConf, mig).URL()
}

// migrationsDir returns the absolute path to db/migrations relative to this
// source file, so tests work regardless of the cwd Go's test runner picks.
func migrationsDir() string {
	_, file, _, _ := runtime.Caller(0)
	// file is .../services/api/internal/pgtest/pgtest.go
	return filepath.Join(file, "..", "..", "..", "..", "..", "db", "migrations")
}
