// Package impersonation lets workspace admins act on behalf of another
// principal. Audit events stamp acting/effective separately so the
// trail tells the truth even after the action ran "as" someone else.
//
// Authorization: only callers who hold the OWNER bundle on a top-level
// org tag (no parent) may impersonate, and they may only impersonate
// active users (not other bots).
//
// Mechanics: a session row gains an effective_principal_id column.
// Start: the token's session row is updated with the target principal
// id; reason is captured in audit_events. Stop: the column is reset to
// NULL.
package impersonation

import (
	"context"
	"errors"
	"fmt"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/perm"
)

var (
	ErrNotAdmin      = errors.New("impersonation: caller is not a workspace admin")
	ErrTargetMissing = errors.New("impersonation: target principal not found")
	ErrTargetIsBot   = errors.New("impersonation: cannot impersonate a bot")
)

type Service struct {
	DB    *pgxpool.Pool
	Perm  *perm.Service
	Audit *audit.Service
}

// Begin starts impersonation for the session identified by sessionID.
// The acting principal must hold owner on at least one root org tag.
// Returns the new effective principal id (the target).
func (s *Service) Begin(ctx context.Context, sessionID, target uuid.UUID, reason string) error {
	id := auth.FromContext(ctx)
	if id.IsAnonymous() {
		return errors.New("impersonation: not authenticated")
	}
	ok, err := s.callerIsAdmin(ctx, id.ActingID)
	if err != nil {
		return err
	}
	if !ok {
		return ErrNotAdmin
	}

	// Validate target.
	var kind, status string
	if err := s.DB.QueryRow(ctx,
		`SELECT kind, status FROM principals WHERE id = $1`, target).
		Scan(&kind, &status); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return ErrTargetMissing
		}
		return fmt.Errorf("load target: %w", err)
	}
	if kind == "bot" {
		return ErrTargetIsBot
	}

	if _, err := s.DB.Exec(ctx, `
        UPDATE sessions SET effective_principal_id = $1
         WHERE id = $2 AND revoked_at IS NULL
    `, target, sessionID); err != nil {
		return fmt.Errorf("update session: %w", err)
	}

	return s.Audit.Write(ctx, audit.Event{
		Action: "impersonation.begin", TargetType: "principal", TargetID: target, Reason: reason,
	})
}

// End clears the impersonation on the named session.
func (s *Service) End(ctx context.Context, sessionID uuid.UUID) error {
	id := auth.FromContext(ctx)
	if id.IsAnonymous() {
		return errors.New("impersonation: not authenticated")
	}
	if id.ActingID == id.EffectiveID {
		// Not currently impersonating — silently succeed for idempotency.
		return nil
	}
	target := id.EffectiveID
	if _, err := s.DB.Exec(ctx, `
        UPDATE sessions SET effective_principal_id = NULL
         WHERE id = $1
    `, sessionID); err != nil {
		return fmt.Errorf("clear session: %w", err)
	}
	return s.Audit.Write(ctx, audit.Event{
		Action: "impersonation.end", TargetType: "principal", TargetID: target,
	})
}

// callerIsAdmin returns true iff principal P holds owner on any root
// org tag (parent IS NULL).
func (s *Service) callerIsAdmin(ctx context.Context, p uuid.UUID) (bool, error) {
	rows, err := s.DB.Query(ctx, `
        SELECT id FROM tags WHERE parent_id IS NULL AND root_kind = 'org'
    `)
	if err != nil {
		return false, fmt.Errorf("query roots: %w", err)
	}
	defer rows.Close()
	for rows.Next() {
		var tagID uuid.UUID
		if err := rows.Scan(&tagID); err != nil {
			return false, err
		}
		bundle, _, err := s.Perm.EffectiveOnTag(ctx, p, tagID)
		if err != nil {
			return false, err
		}
		if bundle == perm.BundleOwner {
			return true, nil
		}
	}
	return false, rows.Err()
}
