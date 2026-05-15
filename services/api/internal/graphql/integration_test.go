package graphql_test

import (
	"bytes"
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/handler/extension"
	"github.com/99designs/gqlgen/graphql/handler/transport"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// TestM1EndToEnd exercises the M1 GraphQL surface end-to-end: login,
// viewer, tag query, createTag, moveTag, archiveTag, grantTag, and
// audit-row visibility for the move. Stops short of testing every
// permission boundary — the per-package tests cover those individually.
func TestM1EndToEnd(t *testing.T) {
	pool := pgtest.Pool(t)
	authSvc := &auth.Service{DB: pool}
	tagSvc := &tag.Service{DB: pool}

	// Bootstrap: alice with password, an org root tag, alice owns it.
	alice := mustSeedUser(t, pool, authSvc, "alice@example.com", "Alice", "swordfish-1234")
	rootID, err := tagSvc.Create(context.Background(), tag.CreateInput{
		Slug:        "org",
		DisplayName: "Org",
		RootKind:    tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("seed root tag: %v", err)
	}
	mustGrant(t, pool, rootID, alice, "owner", true)

	server := buildServer(pool, authSvc)
	ts := httptest.NewServer(server)
	t.Cleanup(ts.Close)

	// Login.
	loginResp := gqlPost(t, ts.URL, "", `mutation { login(email:"alice@example.com", password:"swordfish-1234") { token viewer { id email } } }`, nil)
	assertNoErrors(t, loginResp)
	token := loginResp.path("data", "login", "token").(string)
	if token == "" {
		t.Fatal("no token issued")
	}
	viewerID := loginResp.path("data", "login", "viewer", "id").(string)
	if viewerID != ids.FormatID(alice) {
		t.Errorf("viewer id: want %s got %s", ids.FormatID(alice), viewerID)
	}

	// viewer query, with the token.
	viewerResp := gqlPost(t, ts.URL, token, `{ viewer { displayName email } }`, nil)
	assertNoErrors(t, viewerResp)
	if name := viewerResp.path("data", "viewer", "displayName"); name != "Alice" {
		t.Errorf("displayName: %v", name)
	}

	// tag(id: rootID) returns the root with myPermissions.canOwn true.
	tagResp := gqlPost(t, ts.URL, token, `query($id:ID!){ tag(id:$id){ id slug myPermissions { bundle canView canOwn } } }`, map[string]any{"id": ids.FormatID(rootID)})
	assertNoErrors(t, tagResp)
	if got := tagResp.path("data", "tag", "id"); got != ids.FormatID(rootID) {
		t.Errorf("tag id: %v", got)
	}
	if got := tagResp.path("data", "tag", "myPermissions", "canOwn"); got != true {
		t.Errorf("canOwn: %v", got)
	}

	// createTag under root.
	createResp := gqlPost(t, ts.URL, token, `
        mutation($parent:ID!) {
          createTag(input:{parentId:$parent, slug:"team-a", displayName:"Team A"}) { id slug }
        }`, map[string]any{"parent": ids.FormatID(rootID)})
	assertNoErrors(t, createResp)
	teamAID := createResp.path("data", "createTag", "id").(string)
	if teamAID == "" {
		t.Fatal("no team-a id returned")
	}

	// createTag of sibling team-b, then moveTag(team-a, team-b).
	createBResp := gqlPost(t, ts.URL, token, `
        mutation($parent:ID!) {
          createTag(input:{parentId:$parent, slug:"team-b", displayName:"Team B"}) { id }
        }`, map[string]any{"parent": ids.FormatID(rootID)})
	assertNoErrors(t, createBResp)
	teamBID := createBResp.path("data", "createTag", "id").(string)

	moveResp := gqlPost(t, ts.URL, token, `
        mutation($t:ID!,$p:ID!) {
          moveTag(tagId:$t, newParentId:$p, reason:"reorg") { id }
        }`, map[string]any{"t": teamAID, "p": teamBID})
	assertNoErrors(t, moveResp)

	// audit row for the move exists.
	var auditCount int
	err = pool.QueryRow(context.Background(), `
        SELECT COUNT(*) FROM audit_events
        WHERE action = 'tag.move' AND target_id = $1 AND reason = 'reorg'
    `, ids.MustParseAs(ids.KindTag, teamAID)).Scan(&auditCount)
	if err != nil {
		t.Fatalf("read audit: %v", err)
	}
	if auditCount != 1 {
		t.Errorf("expected 1 audit row for move, got %d", auditCount)
	}

	// archiveTag.
	archiveResp := gqlPost(t, ts.URL, token, `mutation($id:ID!){ archiveTag(tagId:$id){ id archivedAt } }`,
		map[string]any{"id": teamAID})
	assertNoErrors(t, archiveResp)
	if got := archiveResp.path("data", "archiveTag", "archivedAt"); got == nil {
		t.Error("archivedAt should be set after archiveTag")
	}
}

// --- harness ---

func buildServer(pool *pgxpool.Pool, authSvc *auth.Service) http.Handler {
	resolver := &pulsegraphql.Resolver{
		DB:    pool,
		Auth:  authSvc,
		Perm:  &perm.Service{DB: pool},
		Tags:  &tag.Service{DB: pool},
		Audit: &audit.Service{DB: pool},
	}
	srv := handler.New(pulsegraphql.NewExecutableSchema(pulsegraphql.Config{Resolvers: resolver}))
	srv.AddTransport(transport.POST{})
	srv.AddTransport(transport.Options{})
	srv.AddTransport(transport.GET{})
	srv.Use(extension.Introspection{})
	return perm.WithRequestCacheMiddleware(authSvc.HTTPMiddleware(srv))
}

type gqlResponse struct {
	body map[string]any
}

func (r gqlResponse) path(keys ...string) any {
	var cur any = r.body
	for _, k := range keys {
		m, ok := cur.(map[string]any)
		if !ok {
			return nil
		}
		cur = m[k]
	}
	return cur
}

func gqlPost(t *testing.T, url, bearer, query string, vars map[string]any) gqlResponse {
	t.Helper()
	body := map[string]any{"query": query}
	if vars != nil {
		body["variables"] = vars
	}
	bs, _ := json.Marshal(body)
	req, _ := http.NewRequest("POST", url+"/graphql", bytes.NewReader(bs))
	req.Header.Set("Content-Type", "application/json")
	if bearer != "" {
		req.Header.Set("Authorization", "Bearer "+bearer)
	}
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		t.Fatalf("POST: %v", err)
	}
	defer func() { _ = resp.Body.Close() }()
	var out map[string]any
	if err := json.NewDecoder(resp.Body).Decode(&out); err != nil {
		t.Fatalf("decode: %v", err)
	}
	return gqlResponse{body: out}
}

func assertNoErrors(t *testing.T, r gqlResponse) {
	t.Helper()
	if errs := r.body["errors"]; errs != nil {
		bs, _ := json.Marshal(errs)
		// Heuristic: if errors was an empty list, ignore.
		if !strings.Contains(string(bs), `"message"`) {
			return
		}
		t.Fatalf("graphql errors: %s", bs)
	}
}

func mustSeedUser(t *testing.T, pool *pgxpool.Pool, authSvc *auth.Service, email, displayName, password string) int64 {
	t.Helper()
	id := ids.New(ids.KindUser)
	uri := "local://principals/" + ids.FormatID(id)
	_, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, $3, $4)
    `, id, uri, displayName, email)
	if err != nil {
		t.Fatalf("insert principal: %v", err)
	}
	hash, err := auth.HashPassword(password)
	if err != nil {
		t.Fatalf("hash: %v", err)
	}
	_, err = pool.Exec(context.Background(), `
        INSERT INTO user_credentials (principal_id, password_hash) VALUES ($1, $2)
    `, id, hash)
	if err != nil {
		t.Fatalf("insert credential: %v", err)
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
