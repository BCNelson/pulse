package graphql_test

import (
	"context"
	"net/http/httptest"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/search"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// TestTagFeedSettingsAndDescendantPosts covers:
//   - Tag.posts(includeDescendants: ...) returns subtree posts when true,
//     direct-only when false (or null).
//   - setTagFeedSettings round-trips and deletes the row when collapsed
//     back to defaults (sparse-table invariant).
func TestTagFeedSettingsAndDescendantPosts(t *testing.T) {
	pool := pgtest.Pool(t)
	authSvc := &auth.Service{DB: pool}

	alice := mustSeedUser(t, pool, authSvc, "alice@example.com", "Alice", "alice-pw-123")

	tags := &tag.Service{DB: pool}
	rootID, err := tags.Create(context.Background(), tag.CreateInput{
		Slug: "org", DisplayName: "Org", RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root: %v", err)
	}
	mustGrant(t, pool, rootID, alice, "owner", true)

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

	// Create a child tag under root.
	childResp := gqlPost(t, ts.URL, aliceTok, `
        mutation($p:ID!){
          createTag(input:{ parentId:$p, slug:"team-a", displayName:"Team A" }) { id }
        }`, map[string]any{"p": ids.FormatID(rootID)})
	assertNoErrors(t, childResp)
	childID := childResp.path("data", "createTag", "id").(string)

	// Post on the child tag only.
	createResp := gqlPost(t, ts.URL, aliceTok, `
        mutation($t:ID!){
          createPost(input:{ title:"child only", body:"hi", tags:[{tagId:$t}] }) { id }
        }`, map[string]any{"t": childID})
	assertNoErrors(t, createResp)

	// Tag.posts on root without the flag: should be empty.
	postsResp := gqlPost(t, ts.URL, aliceTok, `
        query($t:ID!){ tag(id:$t){ posts{ edges{ node{ title } } } } }`,
		map[string]any{"t": ids.FormatID(rootID)})
	assertNoErrors(t, postsResp)
	if edges, _ := postsResp.path("data", "tag", "posts", "edges").([]any); len(edges) != 0 {
		t.Errorf("root posts (shallow) should be empty, got %d", len(edges))
	}

	// Tag.posts on root with includeDescendants: true → finds the child post.
	deepResp := gqlPost(t, ts.URL, aliceTok, `
        query($t:ID!){ tag(id:$t){ posts(includeDescendants:true){ edges{ node{ title } } } } }`,
		map[string]any{"t": ids.FormatID(rootID)})
	assertNoErrors(t, deepResp)
	edges, _ := deepResp.path("data", "tag", "posts", "edges").([]any)
	if len(edges) != 1 {
		t.Fatalf("root posts (deep) should have 1, got %d", len(edges))
	}

	// Default myFeedSettings is false (no row in tag_view_prefs).
	settingsResp := gqlPost(t, ts.URL, aliceTok, `
        query($t:ID!){ tag(id:$t){ myFeedSettings{ includeDescendants } } }`,
		map[string]any{"t": ids.FormatID(rootID)})
	assertNoErrors(t, settingsResp)
	if got := settingsResp.path("data", "tag", "myFeedSettings", "includeDescendants"); got != false {
		t.Errorf("default include_descendants: got %v want false", got)
	}

	// Set to true, verify, then row exists.
	setResp := gqlPost(t, ts.URL, aliceTok, `
        mutation($t:ID!){
          setTagFeedSettings(input:{ tagId:$t, includeDescendants:true }) { includeDescendants }
        }`, map[string]any{"t": ids.FormatID(rootID)})
	assertNoErrors(t, setResp)
	if got := setResp.path("data", "setTagFeedSettings", "includeDescendants"); got != true {
		t.Errorf("set true: %v", got)
	}
	var rowCount int
	if err := pool.QueryRow(context.Background(),
		`SELECT count(*) FROM tag_view_prefs WHERE principal_id = $1 AND tag_id = $2`,
		alice, rootID).Scan(&rowCount); err != nil {
		t.Fatalf("count after set true: %v", err)
	}
	if rowCount != 1 {
		t.Errorf("expected 1 row after set true, got %d", rowCount)
	}
	// myFeedSettings now reflects the saved value.
	again := gqlPost(t, ts.URL, aliceTok, `
        query($t:ID!){ tag(id:$t){ myFeedSettings{ includeDescendants } } }`,
		map[string]any{"t": ids.FormatID(rootID)})
	assertNoErrors(t, again)
	if got := again.path("data", "tag", "myFeedSettings", "includeDescendants"); got != true {
		t.Errorf("after set: %v", got)
	}

	// Collapse back to default → row deleted.
	offResp := gqlPost(t, ts.URL, aliceTok, `
        mutation($t:ID!){
          setTagFeedSettings(input:{ tagId:$t, includeDescendants:false }) { includeDescendants }
        }`, map[string]any{"t": ids.FormatID(rootID)})
	assertNoErrors(t, offResp)
	if got := offResp.path("data", "setTagFeedSettings", "includeDescendants"); got != false {
		t.Errorf("set false: %v", got)
	}
	if err := pool.QueryRow(context.Background(),
		`SELECT count(*) FROM tag_view_prefs WHERE principal_id = $1 AND tag_id = $2`,
		alice, rootID).Scan(&rowCount); err != nil {
		t.Fatalf("count after collapse: %v", err)
	}
	if rowCount != 0 {
		t.Errorf("row should be deleted when settings collapse to defaults, got %d rows", rowCount)
	}
}
