package perm_test

import (
	"context"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

func TestCanOnPostHonorsRoleFlag(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "org")
	mustGrant(t, pool, root, alice, "moderator", true, nil)

	// post with view_role=true on root: alice can view it.
	postVisible := mustCreatePost(t, pool, alice, "Visible", "Body")
	mustAttachPostTag(t, pool, postVisible, root, true, true, true)

	can, err := svc.CanOnPost(context.Background(), alice, perm.ActionView, postVisible)
	if err != nil {
		t.Fatalf("CanOnPost: %v", err)
	}
	if !can {
		t.Errorf("alice should be able to view post on her granted tag")
	}

	// post with view_role=false on root: alice cannot view it even though
	// she has a tag-level grant.
	postHidden := mustCreatePost(t, pool, alice, "Hidden", "Body")
	mustAttachPostTag(t, pool, postHidden, root, false, true, true)

	can, err = svc.CanOnPost(context.Background(), alice, perm.ActionView, postHidden)
	if err != nil {
		t.Fatalf("CanOnPost: %v", err)
	}
	if can {
		t.Errorf("post with view_role=false should be hidden from tag-grant holders")
	}
}

func TestCanOnPostMultipleTagsAnyVisible(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	rootA := mustCreateTagRoot(t, tags, "org-a")
	rootB := mustCreateTagRoot(t, tags, "org-b")

	// alice has a grant on rootB only.
	mustGrant(t, pool, rootB, alice, "viewer", true, nil)

	post := mustCreatePost(t, pool, alice, "Multi", "Body")
	mustAttachPostTag(t, pool, post, rootA, true, true, true)
	mustAttachPostTag(t, pool, post, rootB, true, true, true)

	can, err := svc.CanOnPost(context.Background(), alice, perm.ActionView, post)
	if err != nil {
		t.Fatalf("CanOnPost: %v", err)
	}
	if !can {
		t.Errorf("any-tag-visible should make multi-tagged post visible")
	}
}

func TestCanOnPostContributeNeedsInteractRole(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "org")
	// Contributor bundle (covers contribute action at the tag level).
	mustGrant(t, pool, root, alice, "contributor", true, nil)

	// View ok but interact_role=false on the only tag → cannot contribute.
	post := mustCreatePost(t, pool, alice, "ReadOnly", "Body")
	mustAttachPostTag(t, pool, post, root, true /*view*/, false /*interact*/, false /*moderate*/)

	canView, _ := svc.CanOnPost(context.Background(), alice, perm.ActionView, post)
	if !canView {
		t.Fatalf("expected view")
	}
	canContrib, _ := svc.CanOnPost(context.Background(), alice, perm.ActionContribute, post)
	if canContrib {
		t.Errorf("interact_role=false should block contribute even with contributor bundle")
	}

	// Flip interact_role on; contribute should now pass.
	if _, err := pool.Exec(context.Background(),
		`UPDATE post_tags SET interact_role = TRUE WHERE post_id = $1 AND tag_id = $2`,
		post, root); err != nil {
		t.Fatalf("flip role: %v", err)
	}
	// Fresh ctx so the cache doesn't pin the old answer.
	canContrib, _ = svc.CanOnPost(context.Background(), alice, perm.ActionContribute, post)
	if !canContrib {
		t.Errorf("after flipping interact_role, contribute should pass")
	}
}

func TestEffectiveOnPostMaxAcrossTags(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	rootA := mustCreateTagRoot(t, tags, "team-a")
	rootB := mustCreateTagRoot(t, tags, "team-b")

	// viewer on team-a, owner on team-b — multi-tagged post should give
	// alice owner-bundle effective.
	mustGrant(t, pool, rootA, alice, "viewer", true, nil)
	mustGrant(t, pool, rootB, alice, "owner", true, nil)

	post := mustCreatePost(t, pool, alice, "Bossy", "Body")
	mustAttachPostTag(t, pool, post, rootA, true, true, true)
	mustAttachPostTag(t, pool, post, rootB, true, true, true)

	bundle, _, err := svc.EffectiveOnPost(context.Background(), alice, post)
	if err != nil {
		t.Fatalf("EffectiveOnPost: %v", err)
	}
	if bundle != perm.BundleOwner {
		t.Errorf("expected owner, got %q", bundle)
	}
}

// --- helpers ---

func mustCreatePost(t *testing.T, pool *pgxpool.Pool, author int64, title, body string) int64 {
	t.Helper()
	var id int64
	err := pool.QueryRow(context.Background(), `
        INSERT INTO posts (title, body, author_id) VALUES ($1, $2, $3) RETURNING id
    `, title, body, author).Scan(&id)
	if err != nil {
		t.Fatalf("create post: %v", err)
	}
	return id
}

func mustAttachPostTag(t *testing.T, pool *pgxpool.Pool, post, tagID int64, viewRole, interactRole, moderateRole bool) {
	t.Helper()
	_, err := pool.Exec(context.Background(), `
        INSERT INTO post_tags (post_id, tag_id, view_role, interact_role, moderate_role)
        VALUES ($1, $2, $3, $4, $5)
    `, post, tagID, viewRole, interactRole, moderateRole)
	if err != nil {
		t.Fatalf("attach post_tag: %v", err)
	}
}
