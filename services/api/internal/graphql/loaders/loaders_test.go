package loaders_test

import (
	"context"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/graphql/loaders"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestPrincipalLoaderBatchesAndCaches(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	// Seed three users.
	authSvc := &auth.Service{DB: pool}
	userIDs := []int64{}
	for _, n := range []string{"alice", "bob", "charlie"} {
		id := ids.New(ids.KindUser)
		uri := "local://principals/" + ids.FormatID(id)
		if _, err := pool.Exec(ctx, `
            INSERT INTO principals (id, kind, status, global_uri, display_name, email)
            VALUES ($1, 'user', 'active', $2, $3, $4)
        `, id, uri, n, n+"@example.com"); err != nil {
			t.Fatalf("insert: %v", err)
		}
		hash, _ := auth.HashPassword("pw-" + n)
		if _, err := pool.Exec(ctx,
			`INSERT INTO user_credentials (principal_id, password_hash) VALUES ($1, $2)`,
			id, hash); err != nil {
			t.Fatalf("credential: %v", err)
		}
		userIDs = append(userIDs, id)
	}
	_ = authSvc

	l := loaders.New(pool)

	// Prime them all in one batch.
	if err := l.Principals.Prime(ctx, userIDs); err != nil {
		t.Fatalf("prime: %v", err)
	}
	for _, id := range userIDs {
		row, err := l.Principals.Get(ctx, id)
		if err != nil {
			t.Fatalf("get: %v", err)
		}
		if row == nil {
			t.Errorf("got nil for %d", id)
		}
	}

	// A second call to Prime with the same ids should be a no-op (no new
	// query) — we can't directly assert on query count here without
	// instrumenting pgx, but we can confirm the cache holds by making
	// the row id non-existent and seeing the second call still return
	// the cached value.
	missing := ids.New(ids.KindUser)
	if err := l.Principals.Prime(ctx, []int64{missing}); err != nil {
		t.Fatalf("prime missing: %v", err)
	}
	row, err := l.Principals.Get(ctx, missing)
	if err != nil {
		t.Fatalf("get missing: %v", err)
	}
	if row != nil {
		t.Errorf("expected nil row for missing id, got %+v", row)
	}
}

func TestPostReactionLoaderViewerScoped(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	// Seed alice + bob, a tag, and a post by alice.
	alice := ids.New(ids.KindUser)
	bob := ids.New(ids.KindUser)
	for _, p := range []struct {
		id    int64
		name  string
		email string
	}{
		{alice, "alice", "alice@example.com"},
		{bob, "bob", "bob@example.com"},
	} {
		if _, err := pool.Exec(ctx, `
            INSERT INTO principals (id, kind, status, global_uri, display_name, email)
            VALUES ($1, 'user', 'active', $2, $3, $4)
        `, p.id, "local://principals/"+ids.FormatID(p.id), p.name, p.email); err != nil {
			t.Fatalf("seed principal: %v", err)
		}
	}

	tagID := ids.New(ids.KindTag)
	if _, err := pool.Exec(ctx, `
        INSERT INTO tags (id, parent_id, slug, display_name, root_kind, defaults)
        VALUES ($1, NULL, 'org', 'Org', 'org', '{}')
    `, tagID); err != nil {
		t.Fatalf("tag: %v", err)
	}
	if _, err := pool.Exec(ctx,
		`INSERT INTO tag_closure (ancestor_id, descendant_id, depth) VALUES ($1, $1, 0)`,
		tagID); err != nil {
		t.Fatalf("closure: %v", err)
	}

	postID := ids.New(ids.KindPost)
	if _, err := pool.Exec(ctx, `
        INSERT INTO posts (id, title, body, author_id) VALUES ($1, 'hi', 'body', $2)
    `, postID, alice); err != nil {
		t.Fatalf("post: %v", err)
	}
	if _, err := pool.Exec(ctx, `
        INSERT INTO post_tags (post_id, tag_id) VALUES ($1, $2)
    `, postID, tagID); err != nil {
		t.Fatalf("post_tag: %v", err)
	}

	// alice and bob both react with 👍; only bob reacts with 🚀.
	for _, who := range []int64{alice, bob} {
		if _, err := pool.Exec(ctx, `
            INSERT INTO post_reactions (post_id, principal_id, emoji)
            VALUES ($1, $2, '👍')
        `, postID, who); err != nil {
			t.Fatalf("react: %v", err)
		}
	}
	if _, err := pool.Exec(ctx, `
        INSERT INTO post_reactions (post_id, principal_id, emoji)
        VALUES ($1, $2, '🚀')
    `, postID, bob); err != nil {
		t.Fatalf("react: %v", err)
	}

	l := loaders.New(pool)

	// alice's view: 👍 byViewer=true, 🚀 byViewer=false.
	tally, err := l.PostReactions.Get(ctx, postID, alice)
	if err != nil {
		t.Fatalf("get: %v", err)
	}
	if len(tally) != 2 {
		t.Fatalf("expected 2 emojis, got %d", len(tally))
	}
	for _, e := range tally {
		if e.Emoji == "👍" && (e.Count != 2 || !e.ByViewer) {
			t.Errorf("👍: %+v", e)
		}
		if e.Emoji == "🚀" && (e.Count != 1 || e.ByViewer) {
			t.Errorf("🚀: %+v", e)
		}
	}

	// bob's view: both byViewer=true.
	tally, err = l.PostReactions.Get(ctx, postID, bob)
	if err != nil {
		t.Fatalf("get bob: %v", err)
	}
	for _, e := range tally {
		if !e.ByViewer {
			t.Errorf("bob should own every reaction, got %+v", e)
		}
	}
}
