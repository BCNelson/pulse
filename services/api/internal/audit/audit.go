// Package audit is the central writer for the audit_events table. Every
// mutation calls Write before the surrounding transaction commits. The
// acting_id/effective_id split is read out of the request context, set by
// auth middleware. M5 layers impersonation on top — when a session is
// acting on someone else's behalf, the two ids diverge and downstream
// readers can tell who pressed the button vs. who the action ran as.
package audit

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgconn"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/auth"
)

var ErrNoIdentity = errors.New("audit: no authenticated identity in context")

// Querier matches both *pgxpool.Pool and pgx.Tx so callers can fold an
// audit write into an enclosing transaction. Mutations that span multiple
// tables MUST use the tx-aware form so a rollback un-audits the action.
type Querier interface {
	Exec(ctx context.Context, sql string, args ...any) (pgconn.CommandTag, error)
}

// Service writes audit rows. Tests typically use the pool form; production
// resolvers thread their tx in.
type Service struct {
	DB *pgxpool.Pool
}

// Event captures everything an auditable action wants to record. diff is
// action-specific JSON; for tag.move, for example, it carries the
// {gained, lost} permission delta. Reason is optional but populated for
// elevated/impersonation actions per the architecture doc.
type Event struct {
	Action     string
	TargetType string
	TargetID   uuid.UUID
	Diff       json.RawMessage
	Reason     string
}

// Write inserts an audit row using the pool. Identity comes from ctx via
// auth.FromContext; anonymous calls return ErrNoIdentity so the caller
// can decide whether to escalate (system action with explicit identity)
// or refuse the operation outright.
func (s *Service) Write(ctx context.Context, e Event) error {
	id := auth.FromContext(ctx)
	if id.IsAnonymous() {
		return ErrNoIdentity
	}
	return WriteAs(ctx, s.DB, id, e)
}

// WriteAs inserts an audit row with an explicit identity, bypassing the
// context lookup. Use this for system-initiated actions (migrations,
// startup tasks, the workspace-config seed) and to write inside a tx.
func WriteAs(ctx context.Context, q Querier, id auth.Identity, e Event) error {
	if e.Action == "" || e.TargetType == "" {
		return errors.New("audit: action and target_type are required")
	}
	diff := e.Diff
	if len(diff) == 0 {
		diff = nil
	}
	var reason any
	if e.Reason != "" {
		reason = e.Reason
	}
	_, err := q.Exec(ctx, `
        INSERT INTO audit_events (acting_id, effective_id, action, target_type, target_id, diff, reason)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
    `, id.ActingID, id.EffectiveID, e.Action, e.TargetType, e.TargetID, diff, reason)
	if err != nil {
		return fmt.Errorf("insert audit: %w", err)
	}
	return nil
}
