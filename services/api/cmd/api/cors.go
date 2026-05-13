package main

import (
	"net/http"
	"os"
	"strings"
)

// originPolicy decides whether a given Origin may interact with the API.
// It is the single source of truth shared by corsMiddleware (HTTP) and the
// WebSocket upgrader's CheckOrigin.
type originPolicy struct {
	dev     bool
	allowed map[string]struct{}
}

// loadOriginPolicy reads the policy from env. APP_ENV=development reflects
// every origin (matches `flutter run -d chrome`'s ephemeral port and any
// local tooling). Outside dev, PULSE_CORS_ALLOWED_ORIGINS is a
// comma-separated allowlist of exact origin strings.
func loadOriginPolicy() originPolicy {
	p := originPolicy{dev: os.Getenv("APP_ENV") == "development"}
	if v := os.Getenv("PULSE_CORS_ALLOWED_ORIGINS"); v != "" {
		p.allowed = make(map[string]struct{})
		for _, o := range strings.Split(v, ",") {
			if o = strings.TrimSpace(o); o != "" {
				p.allowed[o] = struct{}{}
			}
		}
	}
	return p
}

// allows reports whether the given Origin should be permitted. An empty
// origin returns true — native clients (mobile, curl) don't send one, and
// the WebSocket upgrader needs them to pass; auth gates downstream.
func (p originPolicy) allows(origin string) bool {
	if origin == "" {
		return true
	}
	if p.dev {
		return true
	}
	_, ok := p.allowed[origin]
	return ok
}

// corsMiddleware adds Access-Control-* headers and handles preflight,
// using the supplied policy for the allowlist decision.
//
// Only origins with a non-empty Origin header receive CORS response
// headers — the empty-origin allowance in originPolicy.allows is a
// WS-handshake rule, not a CORS rule.
func corsMiddleware(policy originPolicy) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			origin := r.Header.Get("Origin")
			allow := origin != "" && policy.allows(origin)
			if allow {
				h := w.Header()
				h.Set("Access-Control-Allow-Origin", origin)
				h.Add("Vary", "Origin")
				h.Set("Access-Control-Allow-Credentials", "true")
			}
			if r.Method == http.MethodOptions && r.Header.Get("Access-Control-Request-Method") != "" {
				if allow {
					h := w.Header()
					if rh := r.Header.Get("Access-Control-Request-Headers"); rh != "" {
						h.Set("Access-Control-Allow-Headers", rh)
					}
					h.Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
					h.Set("Access-Control-Max-Age", "600")
				}
				w.WriteHeader(http.StatusNoContent)
				return
			}
			next.ServeHTTP(w, r)
		})
	}
}
