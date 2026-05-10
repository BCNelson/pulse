// Package db owns the Postgres connection pool and the migration runner.
// Higher layers receive a *pgxpool.Pool and never reach for connection state
// directly. Migrations run on startup so a deployed binary always advances
// schema in lockstep with code.
package db

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/jackc/pgx/v5/pgxpool"
	_ "github.com/jackc/pgx/v5/stdlib" // register the pgx driver for database/sql so goose can use it
	"github.com/pressly/goose/v3"
)

// NewPool opens a pgx pool against dsn and verifies connectivity with a Ping.
func NewPool(ctx context.Context, dsn string) (*pgxpool.Pool, error) {
	pool, err := pgxpool.New(ctx, dsn)
	if err != nil {
		return nil, fmt.Errorf("create pool: %w", err)
	}
	if err := pool.Ping(ctx); err != nil {
		pool.Close()
		return nil, fmt.Errorf("ping: %w", err)
	}
	return pool, nil
}

// Migrate applies any pending goose migrations from dir against dsn. Uses a
// short-lived database/sql connection because goose drives schema changes
// through the stdlib interface rather than pgx natively.
func Migrate(ctx context.Context, dsn, dir string) error {
	sqlDB, err := sql.Open("pgx", dsn)
	if err != nil {
		return fmt.Errorf("open sql db: %w", err)
	}
	defer func() { _ = sqlDB.Close() }()

	if err := goose.SetDialect("postgres"); err != nil {
		return fmt.Errorf("set dialect: %w", err)
	}
	if err := goose.UpContext(ctx, sqlDB, dir); err != nil {
		return fmt.Errorf("goose up: %w", err)
	}
	return nil
}
