package auth

import (
	"context"

	"github.com/google/uuid"
)

// Identity is the principal information resolved from a request. ActingID
// is who the API "blames" for an action (the human at the keyboard);
// EffectiveID is who the action runs as (== ActingID outside impersonation).
// M5 wires up the ActingID/EffectiveID split when impersonation lands;
// until then both fields hold the same value.
type Identity struct {
	ActingID    uuid.UUID
	EffectiveID uuid.UUID
}

// IsAnonymous reports whether the identity is empty (no authenticated
// principal).
func (i Identity) IsAnonymous() bool {
	return i.ActingID == uuid.Nil
}

type identityCtxKey struct{}

// WithIdentity attaches an authenticated identity to a context. Middleware
// calls this after Lookup; resolvers read it via FromContext.
func WithIdentity(ctx context.Context, id Identity) context.Context {
	return context.WithValue(ctx, identityCtxKey{}, id)
}

// FromContext returns the identity attached to ctx, or the zero value if
// none. Callers use IsAnonymous() to distinguish unauthenticated requests.
func FromContext(ctx context.Context) Identity {
	id, _ := ctx.Value(identityCtxKey{}).(Identity)
	return id
}
