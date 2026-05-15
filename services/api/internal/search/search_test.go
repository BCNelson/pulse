package search_test

import (
	"context"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/search"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestSearchFiltersByVisibility(t *testing.T) {
	pool := pgtest.Pool(t)
	srch := &search.Service{DB: pool}
	posts := &post.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	bob := mustCreatePrincipal(t, pool, "bob")
	tagA := mustCreateRoot(t, tags, "tag-a")
	tagB := mustCreateRoot(t, tags, "tag-b")

	// Both alice and bob create posts containing "elephant".
	mustGrant(t, pool, tagA, alice, "viewer", true)
	mustGrant(t, pool, tagB, bob, "viewer", true)

	mustCreatePost(t, posts, alice, "On elephants", "elephants are large", tagA)
	mustCreatePost(t, posts, bob, "More elephants", "elephants are gentle", tagB)

	// alice searches: only sees the tag-a post (she has no grant on tag-b).
	hits, err := srch.Search(context.Background(), alice, "elephant", nil, 10)
	if err != nil {
		t.Fatalf("Search: %v", err)
	}
	if len(hits) != 1 {
		t.Fatalf("expected 1 hit, got %d", len(hits))
	}
	if hits[0].Title != "On elephants" {
		t.Errorf("alice should see her own post, got %q", hits[0].Title)
	}

	// bob searches: sees only his post.
	hits, _ = srch.Search(context.Background(), bob, "elephant", nil, 10)
	if len(hits) != 1 {
		t.Fatalf("expected 1 hit for bob, got %d", len(hits))
	}
	if hits[0].Title != "More elephants" {
		t.Errorf("bob should see his own post, got %q", hits[0].Title)
	}
}

func TestSearchEmptyQueryRejected(t *testing.T) {
	pool := pgtest.Pool(t)
	srch := &search.Service{DB: pool}

	if _, err := srch.Search(context.Background(), ids.New(ids.KindUser), "", nil, 10); err != search.ErrEmptyQuery {
		t.Errorf("expected ErrEmptyQuery, got %v", err)
	}
}

func TestSearchTagsFuzzyMatch(t *testing.T) {
	pool := pgtest.Pool(t)
	srch := &search.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateRoot(t, tags, "engineering")
	mustGrant(t, pool, root, alice, "viewer", true)

	// Trigram should match "enginer" → "engineering".
	hits, err := srch.SearchTags(context.Background(), alice, "enginer", 5)
	if err != nil {
		t.Fatalf("SearchTags: %v", err)
	}
	if len(hits) != 1 || hits[0].Slug != "engineering" {
		t.Errorf("unexpected: %+v", hits)
	}
}

// --- helpers ---

func mustCreatePrincipal(t *testing.T, pool *pgxpool.Pool, name string) int64 {
	t.Helper()
	id := ids.New(ids.KindUser)
	_, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name)
        VALUES ($1, 'user', 'active', $2, $3)
    `, id, "local://principals/"+ids.FormatID(id), name)
	if err != nil {
		t.Fatalf("insert principal: %v", err)
	}
	return id
}

func mustCreateRoot(t *testing.T, svc *tag.Service, slug string) int64 {
	t.Helper()
	id, err := svc.Create(context.Background(), tag.CreateInput{
		Slug: slug, DisplayName: slug, RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root: %v", err)
	}
	return id
}

func mustGrant(t *testing.T, pool *pgxpool.Pool, tagID, principalID int64, bundle string, cascade bool) {
	t.Helper()
	_, err := pool.Exec(context.Background(), `
        INSERT INTO tag_grants (tag_id, principal_id, bundle, cascade)
        VALUES ($1, $2, $3, $4)
    `, tagID, principalID, bundle, cascade)
	if err != nil {
		t.Fatalf("grant: %v", err)
	}
}

func mustCreatePost(t *testing.T, svc *post.Service, author int64, title, body string, tagID int64) int64 {
	t.Helper()
	id, err := svc.Create(context.Background(), post.CreateInput{
		AuthorID: author, Title: title, Body: body,
		Tags: []post.TagAttachment{{TagID: tagID, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	if err != nil {
		t.Fatalf("create post: %v", err)
	}
	return id
}
