package graphql_test

import (
	"context"
	"testing"
	"time"

	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/search"
	"github.com/bcnelson/pulse/services/api/internal/tag"

	"net/http/httptest"

	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
)

// TestM2EndToEnd exercises post + comment + search end-to-end. Mirrors
// the M1 test's structure: seed via SQL, run real GraphQL through an
// httptest server, assert on responses + DB-side side effects.
func TestM2EndToEnd(t *testing.T) {
	pool := pgtest.Pool(t)
	authSvc := &auth.Service{DB: pool}

	alice := mustSeedUser(t, pool, authSvc, "alice@example.com", "Alice", "alice-pw-123")
	bob := mustSeedUser(t, pool, authSvc, "bob@example.com", "Bob", "bob-pw-123")
	mustSeedUser(t, pool, authSvc, "charlie@example.com", "Charlie", "charlie-pw-123")

	tags := &tag.Service{DB: pool}
	rootID, err := tags.Create(context.Background(), tag.CreateInput{
		Slug: "org", DisplayName: "Org", RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root: %v", err)
	}
	mustGrant(t, pool, rootID, alice, "owner", true)
	mustGrant(t, pool, rootID, bob, "contributor", true)
	// charlie has no grant on root.

	// Build the in-process GraphQL server with all M2 services wired.
	resolver := &pulsegraphql.Resolver{
		DB:       pool,
		Auth:     authSvc,
		Perm:     &perm.Service{DB: pool},
		Tags:     tags,
		Audit:    &audit.Service{DB: pool},
		Posts:    &post.Service{DB: pool},
		Comments: &comment.Service{DB: pool},
		Search:   &search.Service{DB: pool},
	}
	ts := httptest.NewServer(buildM2Server(resolver, authSvc))
	t.Cleanup(ts.Close)

	aliceTok := loginAs(t, ts.URL, "alice@example.com", "alice-pw-123")
	bobTok := loginAs(t, ts.URL, "bob@example.com", "bob-pw-123")
	charlieTok := loginAs(t, ts.URL, "charlie@example.com", "charlie-pw-123")

	// alice creates a post @bob — mention parsing should resolve Bob.
	createResp := gqlPost(t, ts.URL, aliceTok, `
        mutation($t:ID!) {
          createPost(input:{
            title:"Quarterly elephant decisions",
            body:"@Bob can you review this elephant migration plan?",
            tags:[{tagId:$t}]
          }) { id title mentions { displayName } myPermissions { canView canModerate } }
        }`, map[string]any{"t": rootID.String()})
	assertNoErrors(t, createResp)
	postID := createResp.path("data", "createPost", "id").(string)
	if postID == "" {
		t.Fatal("no post id")
	}
	mentions := createResp.path("data", "createPost", "mentions").([]any)
	if len(mentions) != 1 {
		t.Errorf("expected one mention (Bob), got %d", len(mentions))
	}
	if got := createResp.path("data", "createPost", "myPermissions", "canModerate"); got != true {
		t.Errorf("alice should be able to moderate her own post on a tag she owns")
	}

	// bob queries the post; he can view because he's a contributor on the tag.
	postResp := gqlPost(t, ts.URL, bobTok, `query($id:ID!){ post(id:$id){ id title author{ displayName } } }`,
		map[string]any{"id": postID})
	assertNoErrors(t, postResp)
	if got := postResp.path("data", "post", "title"); got != "Quarterly elephant decisions" {
		t.Errorf("bob should see post: %v", got)
	}

	// charlie queries the post; he should not see it.
	charlieResp := gqlPost(t, ts.URL, charlieTok, `query($id:ID!){ post(id:$id){ id } }`,
		map[string]any{"id": postID})
	assertNoErrors(t, charlieResp)
	if got := charlieResp.path("data", "post"); got != nil {
		t.Errorf("charlie should not see the post; got %v", got)
	}

	// bob comments on the post.
	commentResp := gqlPost(t, ts.URL, bobTok, `
        mutation($p:ID!){
          createComment(input:{postId:$p, body:"sounds reasonable"}) { id depth body }
        }`, map[string]any{"p": postID})
	assertNoErrors(t, commentResp)
	if got := commentResp.path("data", "createComment", "depth"); got != float64(0) {
		t.Errorf("top-level comment depth: %v", got)
	}

	// bob reacts.
	reactResp := gqlPost(t, ts.URL, bobTok, `
        mutation($p:ID!){ reactToPost(postId:$p, emoji:"👍"){ reactions { emoji count byViewer } } }`,
		map[string]any{"p": postID})
	assertNoErrors(t, reactResp)

	// alice searches for "elephant" — finds the post.
	searchResp := gqlPost(t, ts.URL, aliceTok, `
        query { search(query:"elephant", first:5) { edges { node { __typename ... on Post { title } } } } }`, nil)
	assertNoErrors(t, searchResp)
	edges := searchResp.path("data", "search", "edges").([]any)
	if len(edges) == 0 {
		t.Fatalf("expected at least one search hit, got 0")
	}

	// charlie's search should return zero hits — he can't see the post.
	cSearchResp := gqlPost(t, ts.URL, charlieTok, `
        query { search(query:"elephant", first:5) { edges { node { __typename } } } }`, nil)
	assertNoErrors(t, cSearchResp)
	cEdges := cSearchResp.path("data", "search", "edges").([]any)
	if len(cEdges) != 0 {
		t.Errorf("charlie should see zero hits; got %d", len(cEdges))
	}

	// alice marks the post read at an explicit seenAt timestamp.
	seenAt := time.Now().UTC().Add(-1 * time.Hour).Format(time.RFC3339Nano)
	markResp := gqlPost(t, ts.URL, aliceTok, `mutation($p:ID!,$s:Time){ markPostRead(postId:$p, seenAt:$s){ lastReadAt } }`,
		map[string]any{"p": postID, "s": seenAt})
	assertNoErrors(t, markResp)
	gotMark, ok := markResp.path("data", "markPostRead", "lastReadAt").(string)
	if !ok || gotMark == "" {
		t.Fatalf("lastReadAt should be a non-empty string after markPostRead, got %v", markResp.path("data", "markPostRead", "lastReadAt"))
	}

	// A second mark with an *older* seenAt must not move last_read_at
	// backwards (GREATEST clamp). The returned lastReadAt should match
	// the first call's timestamp.
	olderSeenAt := time.Now().UTC().Add(-2 * time.Hour).Format(time.RFC3339Nano)
	markResp2 := gqlPost(t, ts.URL, aliceTok, `mutation($p:ID!,$s:Time){ markPostRead(postId:$p, seenAt:$s){ lastReadAt } }`,
		map[string]any{"p": postID, "s": olderSeenAt})
	assertNoErrors(t, markResp2)
	if got := markResp2.path("data", "markPostRead", "lastReadAt"); got != gotMark {
		t.Errorf("monotonic mark violated: got %v, want %v", got, gotMark)
	}

	// Omitting seenAt falls back to now() and must move the timestamp forward.
	markResp3 := gqlPost(t, ts.URL, aliceTok, `mutation($p:ID!){ markPostRead(postId:$p){ lastReadAt } }`,
		map[string]any{"p": postID})
	assertNoErrors(t, markResp3)
	gotMark3, _ := markResp3.path("data", "markPostRead", "lastReadAt").(string)
	if gotMark3 <= gotMark {
		t.Errorf("markPostRead without seenAt should advance lastReadAt; got %v after %v", gotMark3, gotMark)
	}

	// alice edits the post; edit-history row should land.
	editResp := gqlPost(t, ts.URL, aliceTok, `
        mutation($p:ID!){ editPost(input:{postId:$p, title:"Quarterly elephant migration", body:"updated"}) { editedAt } }`,
		map[string]any{"p": postID})
	assertNoErrors(t, editResp)
	if got := editResp.path("data", "editPost", "editedAt"); got == nil {
		t.Error("editedAt should be set after edit")
	}
	var editCount int
	if err := pool.QueryRow(context.Background(),
		`SELECT count(*) FROM post_edits WHERE post_id = $1`, uuid.MustParse(postID)).Scan(&editCount); err != nil {
		t.Fatalf("count post_edits: %v", err)
	}
	if editCount != 1 {
		t.Errorf("expected 1 post_edits row, got %d", editCount)
	}

	// alice deletes the post; bob can no longer see it.
	delResp := gqlPost(t, ts.URL, aliceTok, `mutation($p:ID!){ deletePost(postId:$p) }`,
		map[string]any{"p": postID})
	assertNoErrors(t, delResp)
	if got := delResp.path("data", "deletePost"); got != true {
		t.Errorf("deletePost return: %v", got)
	}
	postAfterDel := gqlPost(t, ts.URL, bobTok, `query($id:ID!){ post(id:$id){ id } }`,
		map[string]any{"id": postID})
	assertNoErrors(t, postAfterDel)
	if got := postAfterDel.path("data", "post"); got != nil {
		t.Errorf("deleted post should not be visible: %v", got)
	}
}

func loginAs(t *testing.T, url, email, pw string) string {
	t.Helper()
	resp := gqlPost(t, url, "", `
        mutation($e:String!,$p:String!){ login(email:$e, password:$p){ token } }`,
		map[string]any{"e": email, "p": pw})
	assertNoErrors(t, resp)
	return resp.path("data", "login", "token").(string)
}
