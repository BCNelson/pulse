package auth

import (
	"net/http"
	"strings"
)

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
		id, ok := s.identityFromRequest(r)
		if ok {
			ctx = WithIdentity(ctx, id)
		}
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}

func (s *Service) identityFromRequest(r *http.Request) (Identity, bool) {
	if header := r.Header.Get("Authorization"); header != "" {
		if strings.HasPrefix(header, bearerKind) {
			token := strings.TrimPrefix(header, bearerKind)
			if pid, err := s.Lookup(r.Context(), token); err == nil {
				return Identity{ActingID: pid, EffectiveID: pid}, true
			}
		}
		if strings.HasPrefix(header, botKind) {
			key := strings.TrimPrefix(header, botKind)
			if pid, err := s.AuthenticateBotKey(r.Context(), key); err == nil {
				return Identity{ActingID: pid, EffectiveID: pid}, true
			}
		}
	}
	if c, err := r.Cookie(cookieName); err == nil {
		if pid, err := s.Lookup(r.Context(), c.Value); err == nil {
			return Identity{ActingID: pid, EffectiveID: pid}, true
		}
	}
	return Identity{}, false
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
