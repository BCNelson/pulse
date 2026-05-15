package redaction_test

import (
	"context"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/bootstrap"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/redaction"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestRedactPrincipalSanitizesContent(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	res, err := bootstrap.Run(ctx, pool, bootstrap.Input{
		Email: "admin@example.com", DisplayName: "Admin", Password: "pw-1234",
		OrgSlug: "org", OrgName: "Org",
	})
	if err != nil {
		t.Fatalf("bootstrap: %v", err)
	}

	// Seed a target principal with some authored content.
	target := ids.New(ids.KindUser)
	if _, err := pool.Exec(ctx, `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, 'Target', 'target@example.com')
    `, target, "local://principals/"+ids.FormatID(target)); err != nil {
		t.Fatalf("seed: %v", err)
	}
	hash, _ := auth.HashPassword("pw-target")
	if _, err := pool.Exec(ctx,
		`INSERT INTO user_credentials (principal_id, password_hash) VALUES ($1, $2)`,
		target, hash); err != nil {
		t.Fatalf("creds: %v", err)
	}
	postID := ids.New(ids.KindUser)
	if _, err := pool.Exec(ctx, `
        INSERT INTO posts (id, title, body, author_id) VALUES ($1, 'secret', 'sensitive', $2)
    `, postID, target); err != nil {
		t.Fatalf("post: %v", err)
	}
	if _, err := pool.Exec(ctx,
		`INSERT INTO post_tags (post_id, tag_id) VALUES ($1, $2)`,
		postID, res.OrgTagID); err != nil {
		t.Fatalf("post_tag: %v", err)
	}

	svc := &redaction.Service{DB: pool, Audit: &audit.Service{DB: pool}}

	// Redaction needs an authenticated identity in ctx for audit.
	adminCtx := perm.WithRequestCache(auth.WithIdentity(ctx, auth.Identity{
		ActingID: res.PrincipalID, EffectiveID: res.PrincipalID,
	}))
	if err := svc.RedactPrincipal(adminCtx, target, "GDPR request 2026-Q2"); err != nil {
		t.Fatalf("redact: %v", err)
	}

	var displayName string
	var email *string
	var status string
	if err := pool.QueryRow(ctx,
		`SELECT display_name, email, status FROM principals WHERE id = $1`, target).
		Scan(&displayName, &email, &status); err != nil {
		t.Fatalf("scan: %v", err)
	}
	if displayName != redaction.RedactedDisplayName {
		t.Errorf("display_name: got %q", displayName)
	}
	if email != nil {
		t.Errorf("email should be NULL, got %v", *email)
	}
	if status != "tombstoned" {
		t.Errorf("status: got %q", status)
	}

	var title, body string
	if err := pool.QueryRow(ctx,
		`SELECT title, body FROM posts WHERE id = $1`, postID).
		Scan(&title, &body); err != nil {
		t.Fatalf("post scan: %v", err)
	}
	if title != redaction.RedactedBody || body != redaction.RedactedBody {
		t.Errorf("post not redacted: title=%q body=%q", title, body)
	}

	var auditCount int
	if err := pool.QueryRow(ctx,
		`SELECT count(*) FROM audit_events WHERE action = 'principal.redact' AND target_id = $1`,
		target).Scan(&auditCount); err != nil {
		t.Fatalf("audit count: %v", err)
	}
	if auditCount != 1 {
		t.Errorf("audit rows: got %d want 1", auditCount)
	}

	// Idempotency: second redact returns ErrAlreadyRedacted.
	if err := svc.RedactPrincipal(adminCtx, target, "again"); err != redaction.ErrAlreadyRedacted {
		t.Errorf("expected ErrAlreadyRedacted on second call, got %v", err)
	}
}
