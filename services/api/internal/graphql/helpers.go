package graphql

import (
	"context"
	"encoding/base64"
	"encoding/json"
	"errors"
	"fmt"
	"time"

	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	graphqlModel "github.com/bcnelson/pulse/services/api/internal/graphql/model"
)

// errPermissionDenied is the typed error every mutation returns when the
// viewer's perm check fails. Callers receive a uniform "permission denied"
// message so the API doesn't leak per-resource existence.
var errPermissionDenied = errors.New("permission denied")

// requireIdentity asserts the request is authenticated. Returns the
// Identity attached by auth.HTTPMiddleware or a typed error for the
// caller to surface.
func requireIdentity(ctx context.Context) (auth.Identity, error) {
	id := auth.FromContext(ctx)
	if id.IsAnonymous() {
		return id, fmt.Errorf("authentication required")
	}
	return id, nil
}

// computePermissionDiff captures the (principal -> gained|lost) delta a
// tag move induces. M1 form: walks principals affected by either subtree
// and records their current bundle. M5 sharpens this into a precise
// before/after diff once the impersonation audit trail demands it.
func (r *Resolver) computePermissionDiff(ctx context.Context, src, dst uuid.UUID) ([]map[string]string, []map[string]string, error) {
	rows, err := r.DB.Query(ctx, `
        WITH affected_principals AS (
          SELECT DISTINCT g.principal_id
          FROM tag_grants g
          JOIN tag_closure c ON c.ancestor_id = g.tag_id
          WHERE c.descendant_id IN (SELECT descendant_id FROM tag_closure WHERE ancestor_id = $1)
             OR c.descendant_id = $2
             OR c.ancestor_id  IN (SELECT ancestor_id FROM tag_closure WHERE descendant_id = $2)
        )
        SELECT principal_id FROM affected_principals
    `, src, dst)
	if err != nil {
		return nil, nil, err
	}
	defer rows.Close()
	var principals []uuid.UUID
	for rows.Next() {
		var pid uuid.UUID
		if err := rows.Scan(&pid); err != nil {
			return nil, nil, err
		}
		principals = append(principals, pid)
	}
	gained := []map[string]string{}
	lost := []map[string]string{}
	for _, pid := range principals {
		bundle, _, err := r.Perm.EffectiveOnTag(ctx, pid, src)
		if err != nil {
			return nil, nil, err
		}
		entry := map[string]string{"principal_id": pid.String(), "bundle": string(bundle)}
		gained = append(gained, entry)
	}
	return gained, lost, nil
}

// tokenCtxKey marks the raw bearer/cookie token in context. Auth middleware
// stashes it so Logout can revoke server-side; M5 will also use it to scope
// impersonation tokens.
type tokenCtxKey struct{}

func tokenFromContext(ctx context.Context) (string, bool) {
	v, ok := ctx.Value(tokenCtxKey{}).(string)
	return v, ok
}

// WithToken stashes the raw bearer token alongside the resolved Identity.
// Callers should treat the token as opaque.
func WithToken(ctx context.Context, token string) context.Context {
	return context.WithValue(ctx, tokenCtxKey{}, token)
}

// --- cursor encoding ---
// Connection cursors are opaque; we encode (created_at, id) as JSON inside
// base64url so callers can't poke at internals. The decode side ships when
// after-cursor pagination is wired (M5) — encoding alone is enough for
// startCursor/endCursor exposure today.

type cursor struct {
	CreatedAt time.Time `json:"t"`
	ID        uuid.UUID `json:"i"`
}

func encodeCursor(c cursor) string {
	bs, _ := json.Marshal(c)
	return base64.RawURLEncoding.EncodeToString(bs)
}

// boolOrTrue returns *p when set; nil defaults to true. Used for GraphQL
// optional boolean inputs whose semantic default is "true".
func boolOrTrue(p *bool) bool {
	if p == nil {
		return true
	}
	return *p
}

// emptyPostConnection is the zero-value PostConnection callers return for
// "no rows" or anonymous viewers. Keeps the schema's non-null promise.
func emptyPostConnection() *graphqlModel.PostConnection {
	return &graphqlModel.PostConnection{
		Edges:    []*graphqlModel.PostEdge{},
		PageInfo: &graphqlModel.PageInfo{},
	}
}
