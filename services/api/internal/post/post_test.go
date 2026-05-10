package post_test

import (
	"context"
	"testing"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/tag"
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

	if err := svc.Edit(context.Background(), id, alice, "v2", "b2"); err != nil {
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
	if err := svc.Edit(context.Background(), id, alice, "v2", "b2"); err != post.ErrAlreadyEdited {
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

func TestExtractMentionSlugs(t *testing.T) {
	tests := []struct {
		body string
		want []string
	}{
		{"hi @alice and @bob", []string{"alice", "bob"}},
		{"@alice @alice again", []string{"alice"}},
		{"path @engineering/backend matters", []string{"engineering/backend"}},
		{"email like a@b.com is not a mention", nil},
		{"start @alice", []string{"alice"}},
	}
	for _, tt := range tests {
		got := post.ExtractMentionSlugs(tt.body)
		if !slicesEqual(got, tt.want) {
			t.Errorf("ExtractMentionSlugs(%q): want %v got %v", tt.body, tt.want, got)
		}
	}
}

func slicesEqual(a, b []string) bool {
	if len(a) != len(b) {
		return false
	}
	for i := range a {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}

// --- helpers ---

func mustCreatePrincipal(t *testing.T, pool *pgxpool.Pool, name string) uuid.UUID {
	t.Helper()
	id := uuid.New()
	_, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name)
        VALUES ($1, 'user', 'active', $2, $3)
    `, id, "local://principals/"+id.String(), name)
	if err != nil {
		t.Fatalf("insert principal: %v", err)
	}
	return id
}

func mustCreateRoot(t *testing.T, svc *tag.Service, slug string) uuid.UUID {
	t.Helper()
	id, err := svc.Create(context.Background(), tag.CreateInput{
		Slug: slug, DisplayName: slug, RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root: %v", err)
	}
	return id
}
