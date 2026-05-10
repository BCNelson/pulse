package auth

import (
	"context"
	"net/http"
	"strings"

	"github.com/google/uuid"
)

type sessionIDCtxKey struct{}

// WithSessionID stashes the resolved session id on the context. The
// impersonation resolvers read it back to identify which session row to
// update — they don't get the bearer token directly.
func WithSessionID(ctx context.Context, id uuid.UUID) context.Context {
	return context.WithValue(ctx, sessionIDCtxKey{}, id)
}

// SessionIDFromContext returns the resolved session id, if any.
func SessionIDFromContext(ctx context.Context) (uuid.UUID, bool) {
	v, ok := ctx.Value(sessionIDCtxKey{}).(uuid.UUID)
	return v, ok
}

const (
	cookieName = "pulse_session"
	bearerKind = "Bearer "
	botKind    = "Bot "
)

// HTTPMiddleware reads the bearer token (or session cookie) off the request,
// resolves it to a principal, and attaches an Identity to the request context.
// Anonymous requests (no token, or invalid) get an empty Identity — downstream
// resolvers gate on IsAnonymous() rather than the middleware refusing the
// request, since GraphQL responses prefer typed errors over 401s.
func (s *Service) HTTPMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := r.Context()
		id, sessionID, ok := s.identityFromRequest(r)
		if ok {
			ctx = WithIdentity(ctx, id)
			if sessionID != uuid.Nil {
				ctx = WithSessionID(ctx, sessionID)
			}
		}
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}

func (s *Service) identityFromRequest(r *http.Request) (Identity, uuid.UUID, bool) {
	if header := r.Header.Get("Authorization"); header != "" {
		if strings.HasPrefix(header, bearerKind) {
			token := strings.TrimPrefix(header, bearerKind)
			if sess, err := s.LookupSession(r.Context(), token); err == nil {
				return Identity{ActingID: sess.ActingID, EffectiveID: sess.EffectiveID}, sess.SessionID, true
			}
		}
		if strings.HasPrefix(header, botKind) {
			key := strings.TrimPrefix(header, botKind)
			if pid, err := s.AuthenticateBotKey(r.Context(), key); err == nil {
				return Identity{ActingID: pid, EffectiveID: pid}, uuid.Nil, true
			}
		}
	}
	if c, err := r.Cookie(cookieName); err == nil {
		if sess, err := s.LookupSession(r.Context(), c.Value); err == nil {
			return Identity{ActingID: sess.ActingID, EffectiveID: sess.EffectiveID}, sess.SessionID, true
		}
	}
	return Identity{}, uuid.Nil, false
}

// SetSessionCookie writes a session cookie for browser clients. Native
// clients should hold the bearer token directly instead.
func SetSessionCookie(w http.ResponseWriter, token string, secure bool) {
	http.SetCookie(w, &http.Cookie{
		Name:     cookieName,
		Value:    token,
		Path:     "/",
		HttpOnly: true,
		Secure:   secure,
		SameSite: http.SameSiteStrictMode,
	})
}

// ClearSessionCookie unsets the session cookie on logout.
func ClearSessionCookie(w http.ResponseWriter, secure bool) {
	http.SetCookie(w, &http.Cookie{
		Name:     cookieName,
		Value:    "",
		Path:     "/",
		MaxAge:   -1,
		HttpOnly: true,
		Secure:   secure,
		SameSite: http.SameSiteStrictMode,
	})
}
