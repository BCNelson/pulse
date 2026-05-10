package graphql_test

import (
	"context"
	"net/http/httptest"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/bootstrap"
	"github.com/bcnelson/pulse/services/api/internal/chat"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
	"github.com/bcnelson/pulse/services/api/internal/notification"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/search"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/internal/task"
)

// TestM4_5BootstrapToFeed exercises the full bootstrap → login → feed
// pipeline: the workspace is empty, run bootstrap, log in as the new
// principal, create five posts, and query Tag.posts. The loader
// middleware should make the per-post field resolution share a
// principal/tag/reaction batch under the hood — this test asserts the
// query *succeeds*; query-count assertions live in the loader unit
// tests.
func TestM4_5BootstrapToFeed(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	res, err := bootstrap.Run(ctx, pool, bootstrap.Input{
		Email:       "founder@example.com",
		DisplayName: "Founder",
		Password:    "founder-pw-123",
		OrgSlug:     "org",
		OrgName:     "Org",
	})
	if err != nil {
		t.Fatalf("bootstrap: %v", err)
	}
	if res.AlreadyDone {
		t.Fatal("expected fresh workspace")
	}

	authSvc := &auth.Service{DB: pool}
	tags := &tag.Service{DB: pool}
	postSvc := &post.Service{DB: pool}
	taskSvc := &task.Service{DB: pool}
	notifSvc := &notification.Service{DB: pool}

	resolver := &pulsegraphql.Resolver{
		DB:            pool,
		Auth:          authSvc,
		Perm:          &perm.Service{DB: pool},
		Tags:          tags,
		Audit:         &audit.Service{DB: pool},
		Posts:         postSvc,
		Comments:      &comment.Service{DB: pool},
		Search:        &search.Service{DB: pool},
		Chat:          &chat.Service{DB: pool, Posts: postSvc},
		Tasks:         taskSvc,
		Notifications: notifSvc,
	}
	ts := httptest.NewServer(buildM2Server(resolver, authSvc))
	t.Cleanup(ts.Close)

	tok := loginAs(t, ts.URL, "founder@example.com", "founder-pw-123")

	// Create five posts.
	for i := 0; i < 5; i++ {
		resp := gqlPost(t, ts.URL, tok, `
            mutation($t:ID!, $title:String!) {
              createPost(input:{ title:$title, body:"sample body", tags:[{tagId:$t}] }) { id }
            }`, map[string]any{"t": res.OrgTagID.String(), "title": "post-" + string(rune('A'+i))})
		assertNoErrors(t, resp)
	}

	// Fetch the feed.
	resp := gqlPost(t, ts.URL, tok, `
        query($t:ID!) {
          tag(id:$t) {
            posts(first:10) {
              edges { node { title author { displayName } reactions { emoji } tags { tag { slug } } } }
            }
          }
        }`, map[string]any{"t": res.OrgTagID.String()})
	assertNoErrors(t, resp)

	edges := resp.path("data", "tag", "posts", "edges").([]any)
	if len(edges) != 5 {
		t.Fatalf("expected 5 posts, got %d", len(edges))
	}
	// All five posts share the same author (the bootstrap user) — the
	// loader should serve the principal record from cache after one
	// initial batch fetch. We verify shape correctness here; the
	// query-batching invariant lives in loaders_test.
	for _, e := range edges {
		node := e.(map[string]any)["node"].(map[string]any)
		author := node["author"].(map[string]any)
		if author["displayName"] != "Founder" {
			t.Errorf("displayName: got %v want Founder", author["displayName"])
		}
	}
}
