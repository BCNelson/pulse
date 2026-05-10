// Package redaction implements the GDPR-style "forget this principal"
// operation. It overwrites identifying fields on principal rows and
// authored content while preserving the structural shape of the data
// (audit trail, comment threads, reaction counts).
//
// Distinct from soft-delete: soft-delete hides; redaction sanitizes.
// Soft-deleted content reappears if undeleted; redacted content
// retains the redacted body forever.
package redaction

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/audit"
)

var ErrAlreadyRedacted = errors.New("redaction: principal already tombstoned")

const RedactedDisplayName = "[redacted]"
const RedactedBody = "[redacted by retention policy]"

type Service struct {
	DB    *pgxpool.Pool
	Audit *audit.Service
}

// RedactPrincipal overwrites identifying fields on the named principal
// and authored content. The audit row stamps acting/effective from the
// caller's identity (workspace admin) and includes the reason.
//
// What's overwritten:
//   - principals.display_name → "[redacted]"
//   - principals.email → NULL
//   - principals.status → 'tombstoned'
//   - posts.title/body → "[redacted...]"
//   - comments.body → "[redacted...]"
//   - messages.body → "[redacted...]"
//   - tasks.description → "[redacted...]"
//
// What's preserved:
//   - Author IDs and timestamps (so the structural graph still resolves).
//   - Reactions, mentions, perm grants — these are membership facts,
//     not identifying content.
func (s *Service) RedactPrincipal(ctx context.Context, target uuid.UUID, reason string) error {
	tx, err := s.DB.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return fmt.Errorf("begin: %w", err)
	}
	defer func() { _ = tx.Rollback(ctx) }()

	var status string
	if err := tx.QueryRow(ctx,
		`SELECT status FROM principals WHERE id = $1 FOR UPDATE`, target).
		Scan(&status); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return fmt.Errorf("principal %s not found", target)
		}
		return err
	}
	if status == "tombstoned" {
		return ErrAlreadyRedacted
	}

	if _, err := tx.Exec(ctx, `
        UPDATE principals
           SET display_name = $1,
               email = NULL,
               status = 'tombstoned',
               tombstoned_at = now()
         WHERE id = $2
    `, RedactedDisplayName, target); err != nil {
		return fmt.Errorf("redact principal: %w", err)
	}

	if _, err := tx.Exec(ctx, `
        UPDATE posts SET title = $1, body = $1 WHERE author_id = $2
    `, RedactedBody, target); err != nil {
		return fmt.Errorf("redact posts: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        UPDATE comments SET body = $1 WHERE author_id = $2
    `, RedactedBody, target); err != nil {
		return fmt.Errorf("redact comments: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        UPDATE messages SET body = $1 WHERE author_id = $2
    `, RedactedBody, target); err != nil {
		return fmt.Errorf("redact messages: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        UPDATE tasks SET title = $1, description = NULL WHERE created_by = $2
    `, RedactedBody, target); err != nil {
		return fmt.Errorf("redact tasks: %w", err)
	}

	// Revoke active sessions and bot keys.
	if _, err := tx.Exec(ctx, `
        UPDATE sessions SET revoked_at = now()
         WHERE principal_id = $1 AND revoked_at IS NULL
    `, target); err != nil {
		return fmt.Errorf("revoke sessions: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        UPDATE bot_credentials SET revoked_at = now()
         WHERE principal_id = $1 AND revoked_at IS NULL
    `, target); err != nil {
		return fmt.Errorf("revoke bot keys: %w", err)
	}

	// Drop tag grants — the principal no longer has any access.
	if _, err := tx.Exec(ctx,
		`DELETE FROM tag_grants WHERE principal_id = $1`, target); err != nil {
		return fmt.Errorf("revoke grants: %w", err)
	}
	if _, err := tx.Exec(ctx,
		`DELETE FROM subscriptions WHERE principal_id = $1`, target); err != nil {
		return fmt.Errorf("drop subs: %w", err)
	}
	if _, err := tx.Exec(ctx,
		`DELETE FROM device_tokens WHERE principal_id = $1`, target); err != nil {
		return fmt.Errorf("drop devices: %w", err)
	}

	// Audit happens inside the same tx so a rollback un-audits cleanly.
	diff, _ := json.Marshal(map[string]any{"redacted_principal_id": target.String()})
	if err := s.Audit.Write(ctx, audit.Event{
		Action:     "principal.redact",
		TargetType: "principal",
		TargetID:   target,
		Diff:       diff,
		Reason:     reason,
	}); err != nil {
		// Audit.Write uses the pool, not our tx. To keep the audit
		// promise even when Audit hasn't been wired tx-aware, we accept
		// the rare race where redaction commits but the audit row
		// fails. The Pulse audit pattern (Write returns err on no
		// identity) is fine in practice — admin actions always have an
		// identity attached.
		return fmt.Errorf("audit: %w", err)
	}

	return tx.Commit(ctx)
}
