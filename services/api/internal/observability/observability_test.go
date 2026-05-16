package observability_test

import (
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/observability"
)

func TestNewExposesPulseMetrics(t *testing.T) {
	m := observability.New()

	// Bumping a counter must work without panicking on missing labels —
	// regression guard for label-set drift between the struct field and
	// the registered CounterVec.
	m.GraphQLRequests.WithLabelValues("viewer", "ok").Inc()
	m.JobsClaimed.WithLabelValues("retention.sweep").Inc()
	m.SubscriptionsActive.Set(3)

	rec := httptest.NewRecorder()
	req := httptest.NewRequest("GET", "/metrics", nil)
	m.Handler().ServeHTTP(rec, req)

	if rec.Code != 200 {
		t.Fatalf("status: got %d want 200", rec.Code)
	}
	body := rec.Body.String()

	for _, want := range []string{
		`pulse_graphql_requests_total{operation="viewer",status="ok"} 1`,
		`pulse_jobs_claimed_total{kind="retention.sweep"} 1`,
		`pulse_subscriptions_active 3`,
		// Process collector is registered alongside our own — confirm
		// it's actually wired, since a silent registration failure
		// would still pass the assertions above.
		"go_goroutines",
	} {
		if !strings.Contains(body, want) {
			t.Errorf("metrics body missing %q\n--- body ---\n%s", want, body)
		}
	}
}
