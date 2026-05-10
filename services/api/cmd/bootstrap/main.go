// Bootstrap CLI: seeds the first user + org root tag for a fresh
// deployment. Idempotent: a second run is a no-op if a user already
// exists.
//
// Usage:
//
//	pulse-bootstrap -email alice@example.com -name "Alice" -password 'sup3r-secret'
//
// All values can also come from PULSE_BOOTSTRAP_* env vars; the flag
// takes precedence. Defaults: org slug "org", org name "Org".
package main

import (
	"context"
	"flag"
	"fmt"
	"os"

	"github.com/bcnelson/pulse/services/api/internal/bootstrap"
	pulsedb "github.com/bcnelson/pulse/services/api/internal/db"
)

func main() {
	email := flag.String("email", os.Getenv("PULSE_BOOTSTRAP_EMAIL"), "first user's email")
	name := flag.String("name", os.Getenv("PULSE_BOOTSTRAP_NAME"), "first user's display name")
	password := flag.String("password", os.Getenv("PULSE_BOOTSTRAP_PASSWORD"), "first user's password")
	orgSlug := flag.String("org-slug", envOr("PULSE_BOOTSTRAP_ORG_SLUG", "org"), "org root tag slug")
	orgName := flag.String("org-name", envOr("PULSE_BOOTSTRAP_ORG_NAME", "Org"), "org root tag display name")
	flag.Parse()

	dsn := envOr("DATABASE_URL", "postgres://pulse:pulse@127.0.0.1:5432/pulse?sslmode=disable")
	migrationsDir := envOr("GOOSE_MIGRATION_DIR", "db/migrations")

	ctx := context.Background()
	if err := pulsedb.Migrate(ctx, dsn, migrationsDir); err != nil {
		fmt.Fprintf(os.Stderr, "migrate: %v\n", err)
		os.Exit(1)
	}
	pool, err := pulsedb.NewPool(ctx, dsn)
	if err != nil {
		fmt.Fprintf(os.Stderr, "pool: %v\n", err)
		os.Exit(1)
	}
	defer pool.Close()

	res, err := bootstrap.Run(ctx, pool, bootstrap.Input{
		Email:       *email,
		DisplayName: *name,
		Password:    *password,
		OrgSlug:     *orgSlug,
		OrgName:     *orgName,
	})
	if err != nil {
		fmt.Fprintf(os.Stderr, "bootstrap: %v\n", err)
		os.Exit(1)
	}
	if res.AlreadyDone {
		fmt.Println("bootstrap: already done — workspace has at least one active user.")
		return
	}
	fmt.Printf("bootstrap: created principal %s and org tag %s\n", res.PrincipalID, res.OrgTagID)
}

func envOr(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
