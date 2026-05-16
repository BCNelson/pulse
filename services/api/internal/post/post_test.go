package post_test

import (
	"context"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestCreateRequiresAtLeastOneTag(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &post.Service{DB: pool}
	alice := mustCreatePrincipal(t, pool, "Alice")
	if _, err := svc.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "x", Body: "y",
	}); err != post.ErrNoTags {
		t.Fatalf("expected ErrNoTags, got %v", err)
	}
}

func TestCreateAndGet(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &post.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "Alice")
	root := mustCreateRoot(t, tags, "org")

	id, err := svc.Create(context.Background(), post.CreateInput{
		AuthorID: alice,
		Title:    "Hello",
		Body:     "World",
		Tags: []post.TagAttachment{
			{TagID: root, ViewRole: true, InteractRole: true, ModerateRole: true},
		},
	})
	if err != nil {
		t.Fatalf("create: %v", err)
	}
	got, err := svc.Get(context.Background(), id)
	if err != nil {
		t.Fatalf("get: %v", err)
	}
	if got.Title != "Hello" || got.Body != "World" || got.AuthorID != alice {
		t.Errorf("unexpected post: %+v", got)
	}

	// post_tags row written.
	tagRows, err := svc.TagAttachments(context.Background(), id)
	if err != nil {
		t.Fatalf("tag attachments: %v", err)
	}
	if len(tagRows) != 1 || tagRows[0].TagID != root {
		t.Errorf("post_tags: %+v", tagRows)
	}
}

func TestEditWritesHistoryRow(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &post.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "Alice")
	root := mustCreateRoot(t, tags, "org")
	id, err := svc.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "v1", Body: "b1",
		Tags: []post.TagAttachment{{TagID: root, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	if err != nil {
		t.Fatalf("create: %v", err)
	}

	if err := svc.Edit(context.Background(), id, alice, "v2", "b2", nil, nil); err != nil {
		t.Fatalf("edit: %v", err)
	}

	var n int
	if err := pool.QueryRow(context.Background(),
		`SELECT count(*) FROM post_edits WHERE post_id = $1`, id).Scan(&n); err != nil {
		t.Fatalf("count edits: %v", err)
	}
	if n != 1 {
		t.Errorf("expected 1 history row, got %d", n)
	}

	// no-op edit returns ErrAlreadyEdited.
	if err := svc.Edit(context.Background(), id, alice, "v2", "b2", nil, nil); err != post.ErrAlreadyEdited {
		t.Errorf("expected ErrAlreadyEdited, got %v", err)
	}
}

func TestReactTallyAndIdempotency(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &post.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "Alice")
	bob := mustCreatePrincipal(t, pool, "Bob")
	root := mustCreateRoot(t, tags, "org")
	id, _ := svc.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "T", Body: "B",
		Tags: []post.TagAttachment{{TagID: root, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})

	// alice reacts twice with the same emoji — idempotent.
	if err := svc.React(context.Background(), id, alice, "👍"); err != nil {
		t.Fatalf("react: %v", err)
	}
	if err := svc.React(context.Background(), id, alice, "👍"); err != nil {
		t.Fatalf("react idempotent: %v", err)
	}
	if err := svc.React(context.Background(), id, bob, "👍"); err != nil {
		t.Fatalf("react bob: %v", err)
	}

	tally, err := svc.ReactionTally(context.Background(), id, alice)
	if err != nil {
		t.Fatalf("tally: %v", err)
	}
	if len(tally) != 1 || tally[0].Emoji != "👍" || tally[0].Count != 2 || !tally[0].ByViewer {
		t.Errorf("tally: %+v", tally)
	}

	// alice unreacts; count drops, ByViewer false.
	if err := svc.Unreact(context.Background(), id, alice, "👍"); err != nil {
		t.Fatalf("unreact: %v", err)
	}
	tally, _ = svc.ReactionTally(context.Background(), id, alice)
	if tally[0].Count != 1 || tally[0].ByViewer {
		t.Errorf("post-unreact tally: %+v", tally)
	}
}

func TestListByTagIncludeDescendants(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &post.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "Alice")
	root := mustCreateRoot(t, tags, "org")
	childA, err := tags.Create(context.Background(), tag.CreateInput{
		ParentID: &root, Slug: "a", DisplayName: "A", RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create childA: %v", err)
	}
	childB, err := tags.Create(context.Background(), tag.CreateInput{
		ParentID: &root, Slug: "b", DisplayName: "B", RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create childB: %v", err)
	}

	pRoot, err := svc.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "root", Body: "r",
		Tags: []post.TagAttachment{{TagID: root, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	if err != nil {
		t.Fatalf("create root post: %v", err)
	}
	pA, err := svc.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "a", Body: "a",
		Tags: []post.TagAttachment{{TagID: childA, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	if err != nil {
		t.Fatalf("create child A post: %v", err)
	}
	pB, err := svc.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "b", Body: "b",
		Tags: []post.TagAttachment{{TagID: childB, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	if err != nil {
		t.Fatalf("create child B post: %v", err)
	}

	// Default: root tag returns only the root-attached post.
	posts, err := svc.ListByTag(context.Background(), root, false, 50)
	if err != nil {
		t.Fatalf("list shallow: %v", err)
	}
	if len(posts) != 1 || posts[0].ID != pRoot {
		t.Errorf("shallow list mismatch: got %+v want only [%d]", postIDs(posts), pRoot)
	}

	// With includeDescendants: covers the closure subtree.
	posts, err = svc.ListByTag(context.Background(), root, true, 50)
	if err != nil {
		t.Fatalf("list deep: %v", err)
	}
	got := postIDs(posts)
	want := map[int64]bool{pRoot: true, pA: true, pB: true}
	if len(got) != 3 {
		t.Fatalf("deep list size: got %v want 3", got)
	}
	for _, id := range got {
		if !want[id] {
			t.Errorf("unexpected post id %d in deep list", id)
		}
	}
}

func postIDs(posts []*post.Post) []int64 {
	out := make([]int64, 0, len(posts))
	for _, p := range posts {
		out = append(out, p.ID)
	}
	return out
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
