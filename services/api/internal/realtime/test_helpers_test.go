package realtime_test

import (
	"context"
	"testing"

	"github.com/jackc/pgx/v5"
)

func mustOpenConn(t *testing.T, ctx context.Context, dsn string) *pgx.Conn {
	t.Helper()
	c, err := pgx.Connect(ctx, dsn)
	if err != nil {
		t.Fatalf("pgx.Connect: %v", err)
	}
	return c
}
