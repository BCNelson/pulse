package bootstrap_test

import (
	"context"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/bootstrap"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
)

func TestRunCreatesUserAndOrgTag(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	res, err := bootstrap.Run(ctx, pool, bootstrap.Input{
		Email: "alice@example.com", DisplayName: "Alice",
		Password: "alice-pw-123",
		OrgSlug:  "org", OrgName: "Org",
	})
	if err != nil {
		t.Fatalf("bootstrap: %v", err)
	}
	if res.AlreadyDone {
		t.Fatal("expected fresh bootstrap, got AlreadyDone")
	}
	if res.PrincipalID == res.OrgTagID {
		t.Errorf("ids should differ")
	}

	// Login should now work.
	authSvc := &auth.Service{DB: pool}
	issued, principalID, err := authSvc.Login(ctx, "alice@example.com", "alice-pw-123", "test")
	if err != nil {
		t.Fatalf("login: %v", err)
	}
	if principalID != res.PrincipalID {
		t.Errorf("login principal: got %s want %s", principalID, res.PrincipalID)
	}
	if issued.Token == "" {
		t.Error("expected non-empty token")
	}

	// And the bootstrap user should hold owner+cascade on the org tag.
	permSvc := &perm.Service{DB: pool}
	bundle, _, err := permSvc.EffectiveOnTag(ctx, res.PrincipalID, res.OrgTagID)
	if err != nil {
		t.Fatalf("effective: %v", err)
	}
	if bundle != perm.BundleOwner {
		t.Errorf("bundle: got %v want owner", bundle)
	}
}

func TestRunIsIdempotent(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()
	in := bootstrap.Input{
		Email: "alice@example.com", DisplayName: "Alice",
		Password: "alice-pw-123", OrgSlug: "org", OrgName: "Org",
	}
	if _, err := bootstrap.Run(ctx, pool, in); err != nil {
		t.Fatalf("first run: %v", err)
	}
	// Second run with different inputs should still report AlreadyDone.
	res, err := bootstrap.Run(ctx, pool, bootstrap.Input{
		Email: "bob@example.com", DisplayName: "Bob",
		Password: "bob-pw-123", OrgSlug: "org2", OrgName: "Org Two",
	})
	if err != nil {
		t.Fatalf("second run: %v", err)
	}
	if !res.AlreadyDone {
		t.Errorf("expected AlreadyDone on second run")
	}

	// And bob should not have been created.
	var count int
	if err := pool.QueryRow(ctx,
		`SELECT count(*) FROM principals WHERE email = 'bob@example.com'`).Scan(&count); err != nil {
		t.Fatalf("count: %v", err)
	}
	if count != 0 {
		t.Errorf("bob got created on idempotent path")
	}
}

func TestRunValidatesInput(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()
	if _, err := bootstrap.Run(ctx, pool, bootstrap.Input{
		Email: "", DisplayName: "Alice", Password: "x", OrgSlug: "org", OrgName: "Org",
	}); err == nil {
		t.Error("empty email should fail validation")
	}
}
