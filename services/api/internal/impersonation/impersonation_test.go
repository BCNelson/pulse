package impersonation_test

import (
	"context"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/bootstrap"
	"github.com/bcnelson/pulse/services/api/internal/impersonation"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestImpersonationOnlyAdmins(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	// Bootstrap creates an org admin.
	_, _ = bootstrap.Run(ctx, pool, bootstrap.Input{
		Email: "owner@example.com", DisplayName: "Owner", Password: "pw-1234",
		OrgSlug: "org", OrgName: "Org",
	})

	// Seed a non-admin user (no grant).
	authSvc := &auth.Service{DB: pool}
	contributorID := ids.New(ids.KindUser)
	if _, err := pool.Exec(ctx, `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, 'Contributor', 'c@example.com')
    `, contributorID, "local://principals/"+ids.FormatID(contributorID)); err != nil {
		t.Fatalf("seed contributor: %v", err)
	}
	hash, _ := auth.HashPassword("pw-c")
	if _, err := pool.Exec(ctx,
		`INSERT INTO user_credentials (principal_id, password_hash) VALUES ($1, $2)`,
		contributorID, hash); err != nil {
		t.Fatalf("credential: %v", err)
	}

	// And a target user.
	targetID := ids.New(ids.KindUser)
	if _, err := pool.Exec(ctx, `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, 'Target', 't@example.com')
    `, targetID, "local://principals/"+ids.FormatID(targetID)); err != nil {
		t.Fatalf("seed target: %v", err)
	}

	imp := &impersonation.Service{
		DB:    pool,
		Perm:  &perm.Service{DB: pool},
		Audit: &audit.Service{DB: pool},
	}

	// Contributor logs in, gets a session, tries to impersonate -> denied.
	cIssued, _, err := authSvc.Login(ctx, "c@example.com", "pw-c", "test")
	if err != nil {
		t.Fatalf("login c: %v", err)
	}
	cSess, _ := authSvc.LookupSession(ctx, cIssued.Token)
	cCtx := perm.WithRequestCache(auth.WithIdentity(ctx, auth.Identity{
		ActingID: contributorID, EffectiveID: contributorID,
	}))
	if err := imp.Begin(cCtx, cSess.SessionID, targetID, "evil"); err == nil {
		t.Error("contributor should not be able to impersonate")
	}

	// Owner logs in, can impersonate.
	oIssued, ownerID, err := authSvc.Login(ctx, "owner@example.com", "pw-1234", "test")
	if err != nil {
		t.Fatalf("login owner: %v", err)
	}
	oSess, _ := authSvc.LookupSession(ctx, oIssued.Token)
	oCtx := perm.WithRequestCache(auth.WithIdentity(ctx, auth.Identity{
		ActingID: ownerID, EffectiveID: ownerID,
	}))
	if err := imp.Begin(oCtx, oSess.SessionID, targetID, "support call"); err != nil {
		t.Fatalf("owner impersonate: %v", err)
	}

	// LookupSession after impersonation should report effective = target.
	sess, err := authSvc.LookupSession(ctx, oIssued.Token)
	if err != nil {
		t.Fatalf("lookup post-impersonate: %v", err)
	}
	if sess.ActingID != ownerID {
		t.Errorf("acting: got %d want %d", sess.ActingID, ownerID)
	}
	if sess.EffectiveID != targetID {
		t.Errorf("effective: got %d want %d", sess.EffectiveID, targetID)
	}

	// End impersonation.
	endCtx := perm.WithRequestCache(auth.WithIdentity(ctx, auth.Identity{
		ActingID: ownerID, EffectiveID: targetID,
	}))
	if err := imp.End(endCtx, sess.SessionID); err != nil {
		t.Fatalf("end: %v", err)
	}
	sess, _ = authSvc.LookupSession(ctx, oIssued.Token)
	if sess.EffectiveID != ownerID {
		t.Errorf("after end, effective should be owner: got %d", sess.EffectiveID)
	}

	// Audit trail: begin + end events.
	var beginCount, endCount int
	if err := pool.QueryRow(ctx,
		`SELECT count(*) FROM audit_events WHERE action = 'impersonation.begin'`).
		Scan(&beginCount); err != nil {
		t.Fatalf("count begin: %v", err)
	}
	if beginCount != 1 {
		t.Errorf("begin events: got %d want 1", beginCount)
	}
	if err := pool.QueryRow(ctx,
		`SELECT count(*) FROM audit_events WHERE action = 'impersonation.end'`).
		Scan(&endCount); err != nil {
		t.Fatalf("count end: %v", err)
	}
	if endCount != 1 {
		t.Errorf("end events: got %d want 1", endCount)
	}
}
