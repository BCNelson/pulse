package perm_test

import (
	"context"
	"testing"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

func TestDirectGrantConfersBundle(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "org")

	mustGrant(t, pool, root, alice, "viewer", true, nil)

	can, err := svc.Can(context.Background(), alice, perm.ActionView, root)
	if err != nil {
		t.Fatalf("Can: %v", err)
	}
	if !can {
		t.Errorf("alice should be able to view root by direct grant")
	}

	if can, _ := svc.Can(context.Background(), alice, perm.ActionContribute, root); can {
		t.Errorf("viewer bundle should NOT permit contribute")
	}
}

func TestCascadingGrantReachesDescendants(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "org")
	child := mustCreateTagChild(t, tags, root, "team-a")
	grandchild := mustCreateTagChild(t, tags, child, "feature-x")

	mustGrant(t, pool, root, alice, "moderator", true, nil)

	for name, target := range map[string]uuid.UUID{
		"root":       root,
		"child":      child,
		"grandchild": grandchild,
	} {
		bundle, _, err := svc.EffectiveOnTag(context.Background(), alice, target)
		if err != nil {
			t.Fatalf("EffectiveOnTag %s: %v", name, err)
		}
		if bundle != perm.BundleModerator {
			t.Errorf("%s: expected moderator, got %q", name, bundle)
		}
	}
}

func TestNonCascadingGrantConfinedToTag(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "org")
	child := mustCreateTagChild(t, tags, root, "team-a")

	// cascade=false: grant applies only at root, not its descendants.
	mustGrant(t, pool, root, alice, "viewer", false, nil)

	if can, _ := svc.Can(context.Background(), alice, perm.ActionView, root); !can {
		t.Errorf("non-cascading grant should still cover the granted tag itself")
	}
	if can, _ := svc.Can(context.Background(), alice, perm.ActionView, child); can {
		t.Errorf("non-cascading grant should NOT reach descendants")
	}
}

func TestMaxBundleAcrossMultipleGrants(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "org")
	child := mustCreateTagChild(t, tags, root, "team-a")

	// Grant viewer at root (cascading) and owner at child (direct).
	// Effective on child should be owner (max bundle wins).
	mustGrant(t, pool, root, alice, "viewer", true, nil)
	mustGrant(t, pool, child, alice, "owner", true, nil)

	bundle, _, err := svc.EffectiveOnTag(context.Background(), alice, child)
	if err != nil {
		t.Fatalf("EffectiveOnTag: %v", err)
	}
	if bundle != perm.BundleOwner {
		t.Errorf("expected owner (max), got %q", bundle)
	}
}

func TestExtraPermsUnion(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "org")
	child := mustCreateTagChild(t, tags, root, "team-a")

	// viewer + extra "delete" at root, viewer + extra "publish" at child.
	mustGrant(t, pool, root, alice, "viewer", true, []string{"delete"})
	mustGrant(t, pool, child, alice, "viewer", true, []string{"publish"})

	_, extras, err := svc.EffectiveOnTag(context.Background(), alice, child)
	if err != nil {
		t.Fatalf("EffectiveOnTag: %v", err)
	}
	got := map[string]bool{}
	for _, e := range extras {
		got[e] = true
	}
	if !got["delete"] || !got["publish"] {
		t.Errorf("expected extras to include both delete and publish, got %v", extras)
	}
}

func TestRequestCacheReusesResult(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "org")
	mustGrant(t, pool, root, alice, "viewer", true, nil)

	ctx := perm.WithRequestCache(context.Background())

	// First call hits DB; cached result should reflect it.
	bundle1, _, err := svc.EffectiveOnTag(ctx, alice, root)
	if err != nil {
		t.Fatalf("EffectiveOnTag #1: %v", err)
	}

	// Mutate the underlying state and call again — cached result wins.
	mustGrant(t, pool, root, alice, "owner", true, nil)
	bundle2, _, err := svc.EffectiveOnTag(ctx, alice, root)
	if err != nil {
		t.Fatalf("EffectiveOnTag #2: %v", err)
	}
	if bundle1 != bundle2 {
		t.Errorf("cache should pin the first result; got %q -> %q", bundle1, bundle2)
	}
	// Without the cache, the new state is visible.
	bundle3, _, err := svc.EffectiveOnTag(context.Background(), alice, root)
	if err != nil {
		t.Fatalf("EffectiveOnTag #3: %v", err)
	}
	if bundle3 != perm.BundleOwner {
		t.Errorf("uncached should see new state, got %q", bundle3)
	}
}

// --- helpers ---

func mustCreatePrincipal(t *testing.T, pool *pgxpool.Pool, displayName string) uuid.UUID {
	t.Helper()
	id := uuid.New()
	uri := "local://principals/" + id.String()
	_, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name)
        VALUES ($1, 'user', 'active', $2, $3)
    `, id, uri, displayName)
	if err != nil {
		t.Fatalf("insert principal %s: %v", displayName, err)
	}
	return id
}

func mustCreateTagRoot(t *testing.T, svc *tag.Service, slug string) uuid.UUID {
	t.Helper()
	id, err := svc.Create(context.Background(), tag.CreateInput{
		Slug:        slug,
		DisplayName: slug,
		RootKind:    tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root %q: %v", slug, err)
	}
	return id
}

func mustCreateTagChild(t *testing.T, svc *tag.Service, parent uuid.UUID, slug string) uuid.UUID {
	t.Helper()
	p := parent
	id, err := svc.Create(context.Background(), tag.CreateInput{
		ParentID:    &p,
		Slug:        slug,
		DisplayName: slug,
		RootKind:    tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create child %q: %v", slug, err)
	}
	return id
}

func mustGrant(t *testing.T, pool *pgxpool.Pool, tag, principal uuid.UUID, bundle string, cascade bool, extras []string) {
	t.Helper()
	if extras == nil {
		extras = []string{}
	}
	_, err := pool.Exec(context.Background(), `
        INSERT INTO tag_grants (tag_id, principal_id, bundle, cascade, extra_perms)
        VALUES ($1, $2, $3, $4, $5)
        ON CONFLICT (tag_id, principal_id) DO UPDATE
            SET bundle = EXCLUDED.bundle,
                cascade = EXCLUDED.cascade,
                extra_perms = EXCLUDED.extra_perms
    `, tag, principal, bundle, cascade, extras)
	if err != nil {
		t.Fatalf("grant %s on tag %s to %s: %v", bundle, tag, principal, err)
	}
}
