// Package bootstrap creates the workspace's first user and org-root tag.
// Run once on a fresh deployment. Idempotent: if any active user already
// exists, the call is a no-op (so startup hooks can call it safely).
//
// This solves the chicken-and-egg problem in M1's GraphQL surface: the
// only way to create a principal is through grants from an authenticated
// caller, but there's no caller until someone exists. We sidestep
// GraphQL and write principals/tags/credentials directly, then exit —
// the resulting user logs in normally and uses the GraphQL surface from
// there.
package bootstrap

import (
	"context"
	"errors"
	"fmt"
	"strings"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

// Input describes the seed. All fields are required.
type Input struct {
	Email       string
	DisplayName string
	Password    string
	OrgSlug     string // root org tag slug, e.g. "org"
	OrgName     string // root org tag display name
}

// Result reports what was created. PrincipalID and OrgTagID are zero on
// the no-op path (when bootstrap was already done).
type Result struct {
	PrincipalID uuid.UUID
	OrgTagID    uuid.UUID
	AlreadyDone bool
}

var ErrInvalidInput = errors.New("bootstrap: missing required fields")

// Run seeds the workspace. Idempotent: if any active user already exists
// the call returns AlreadyDone=true without modifying state.
func Run(ctx context.Context, pool *pgxpool.Pool, in Input) (*Result, error) {
	if err := validate(in); err != nil {
		return nil, err
	}

	var existing int
	if err := pool.QueryRow(ctx,
		`SELECT count(*) FROM principals WHERE kind = 'user' AND status = 'active'`).
		Scan(&existing); err != nil {
		return nil, fmt.Errorf("count users: %w", err)
	}
	if existing > 0 {
		return &Result{AlreadyDone: true}, nil
	}

	hash, err := auth.HashPassword(in.Password)
	if err != nil {
		return nil, fmt.Errorf("hash password: %w", err)
	}

	tx, err := pool.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return nil, fmt.Errorf("begin: %w", err)
	}
	defer func() { _ = tx.Rollback(ctx) }()

	principalID := uuid.New()
	uri := "local://principals/" + principalID.String()
	if _, err := tx.Exec(ctx, `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, $3, $4)
    `, principalID, uri, in.DisplayName, strings.ToLower(in.Email)); err != nil {
		return nil, fmt.Errorf("insert principal: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        INSERT INTO user_credentials (principal_id, password_hash) VALUES ($1, $2)
    `, principalID, hash); err != nil {
		return nil, fmt.Errorf("insert credential: %w", err)
	}

	// Create the org root tag. We call straight into SQL rather than the
	// tag.Service so the whole bootstrap stays inside one transaction —
	// tag.Service uses its own pool tx which would split atomicity.
	orgID := uuid.New()
	if _, err := tx.Exec(ctx, `
        INSERT INTO tags (id, parent_id, slug, display_name, root_kind, defaults)
        VALUES ($1, NULL, $2, $3, $4, '{}')
    `, orgID, in.OrgSlug, in.OrgName, tag.RootKindOrg); err != nil {
		return nil, fmt.Errorf("insert org tag: %w", err)
	}
	// Self-edge at depth 0 (mirrors tag.Service.Create).
	if _, err := tx.Exec(ctx,
		`INSERT INTO tag_closure (ancestor_id, descendant_id, depth) VALUES ($1, $1, 0)`,
		orgID); err != nil {
		return nil, fmt.Errorf("insert closure: %w", err)
	}

	// Grant the bootstrap user OWNER on the org root with cascade so they
	// can manage everything underneath.
	if _, err := tx.Exec(ctx, `
        INSERT INTO tag_grants (tag_id, principal_id, bundle, cascade)
        VALUES ($1, $2, 'owner', TRUE)
    `, orgID, principalID); err != nil {
		return nil, fmt.Errorf("insert grant: %w", err)
	}

	// Audit the action — acting and effective both equal the new principal
	// since they're the only one in the workspace.
	if _, err := tx.Exec(ctx, `
        INSERT INTO audit_events (acting_id, effective_id, action, target_type, target_id, reason)
        VALUES ($1, $1, 'workspace.bootstrap', 'principal', $1, 'first-user bootstrap')
    `, principalID); err != nil {
		return nil, fmt.Errorf("audit: %w", err)
	}

	if err := tx.Commit(ctx); err != nil {
		return nil, fmt.Errorf("commit: %w", err)
	}
	return &Result{PrincipalID: principalID, OrgTagID: orgID}, nil
}

func validate(in Input) error {
	if strings.TrimSpace(in.Email) == "" ||
		strings.TrimSpace(in.DisplayName) == "" ||
		strings.TrimSpace(in.Password) == "" ||
		strings.TrimSpace(in.OrgSlug) == "" ||
		strings.TrimSpace(in.OrgName) == "" {
		return ErrInvalidInput
	}
	return nil
}
