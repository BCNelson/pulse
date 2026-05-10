package perm

import "net/http"

// WithRequestCacheMiddleware attaches a fresh permission cache to every
// inbound request's context. Wraps the GraphQL handler so descendants of
// resolvers share lookups within one operation.
func WithRequestCacheMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := WithRequestCache(r.Context())
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}
