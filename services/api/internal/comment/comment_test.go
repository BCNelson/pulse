package comment_test

import (
	"context"
	"strings"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/comment"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestCreateTopLevelAndChild(t *testing.T) {
	pool := pgtest.Pool(t)
	cmt := &comment.Service{DB: pool}
	posts := &post.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "Alice")
	root := mustCreateRoot(t, tags, "org")
	postID, _ := posts.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "T", Body: "B",
		Tags: []post.TagAttachment{{TagID: root, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})

	topID, err := cmt.Create(context.Background(), comment.CreateInput{
		PostID: postID, AuthorID: alice, Body: "hi",
	})
	if err != nil {
		t.Fatalf("create top-level: %v", err)
	}
	top, _ := cmt.Get(context.Background(), topID)
	if comment.Depth(top.Path) != 0 {
		t.Errorf("top-level depth: %d (path=%q)", comment.Depth(top.Path), top.Path)
	}

	// Child comment under top.
	childID, err := cmt.Create(context.Background(), comment.CreateInput{
		PostID: postID, ParentID: &topID, AuthorID: alice, Body: "child",
	})
	if err != nil {
		t.Fatalf("create child: %v", err)
	}
	child, _ := cmt.Get(context.Background(), childID)
	if comment.Depth(child.Path) != 1 {
		t.Errorf("child depth: %d (path=%q)", comment.Depth(child.Path), child.Path)
	}
	if !strings.HasPrefix(child.Path, top.Path+".") {
		t.Errorf("child path %q should be rooted at parent path %q", child.Path, top.Path)
	}
}

func TestCreateRejectsCrossPostParent(t *testing.T) {
	pool := pgtest.Pool(t)
	cmt := &comment.Service{DB: pool}
	posts := &post.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "Alice")
	root := mustCreateRoot(t, tags, "org")
	postA, _ := posts.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "A", Body: "B",
		Tags: []post.TagAttachment{{TagID: root, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	postB, _ := posts.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "C", Body: "D",
		Tags: []post.TagAttachment{{TagID: root, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	parent, _ := cmt.Create(context.Background(), comment.CreateInput{
		PostID: postA, AuthorID: alice, Body: "parent",
	})
	if _, err := cmt.Create(context.Background(), comment.CreateInput{
		PostID: postB, ParentID: &parent, AuthorID: alice, Body: "x",
	}); err != comment.ErrParentMismatch {
		t.Fatalf("expected ErrParentMismatch, got %v", err)
	}
}

func TestEditWritesHistory(t *testing.T) {
	pool := pgtest.Pool(t)
	cmt := &comment.Service{DB: pool}
	posts := &post.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "Alice")
	root := mustCreateRoot(t, tags, "org")
	postID, _ := posts.Create(context.Background(), post.CreateInput{
		AuthorID: alice, Title: "T", Body: "B",
		Tags: []post.TagAttachment{{TagID: root, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	id, _ := cmt.Create(context.Background(), comment.CreateInput{
		PostID: postID, AuthorID: alice, Body: "v1",
	})
	if err := cmt.Edit(context.Background(), id, alice, "v2"); err != nil {
		t.Fatalf("edit: %v", err)
	}
	var n int
	if err := pool.QueryRow(context.Background(),
		`SELECT count(*) FROM comment_edits WHERE comment_id = $1`, id).Scan(&n); err != nil {
		t.Fatalf("count: %v", err)
	}
	if n != 1 {
		t.Errorf("expected 1 history row, got %d", n)
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
