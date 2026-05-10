// Package observability bundles the metrics surface and exposes a
// /metrics handler. v1 ships a small, stable set of counters/gauges
// and lets the Prometheus default collectors handle Go runtime
// metrics. OTEL traces are wired separately at the gqlgen layer.
//
// Choosing client_golang over a custom collector keeps the door open
// for the alerts/dashboards every Postgres+Go shop already has.
package observability

import (
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/collectors"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// Metrics is the registry-bound set we publish. Construct once at
// boot, share via context if resolvers want to bump counters.
type Metrics struct {
	registry *prometheus.Registry

	// GraphQLRequests counts every operation by name + status. Status
	// is "ok" or "error"; cardinality is the operation set, which is
	// finite by design.
	GraphQLRequests *prometheus.CounterVec
	// GraphQLDuration histograms operation latency for the same labels.
	GraphQLDuration *prometheus.HistogramVec
	// JobsClaimed/Completed/Failed track the worker pipeline.
	JobsClaimed   *prometheus.CounterVec
	JobsCompleted *prometheus.CounterVec
	JobsFailed    *prometheus.CounterVec
	// SubscriptionsActive is a gauge of in-process subscribers.
	SubscriptionsActive prometheus.Gauge
	// NotifyDropped counts events the realtime dispatcher dropped on a
	// slow consumer — early warning of the LISTEN/NOTIFY ceiling.
	NotifyDropped *prometheus.CounterVec
}

// New builds a fresh Metrics with all collectors registered. Tests can
// pass the returned registry to a promhttp handler in isolation.
func New() *Metrics {
	r := prometheus.NewRegistry()
	r.MustRegister(collectors.NewGoCollector())
	r.MustRegister(collectors.NewProcessCollector(collectors.ProcessCollectorOpts{}))

	m := &Metrics{
		registry: r,
		GraphQLRequests: prometheus.NewCounterVec(
			prometheus.CounterOpts{
				Name: "pulse_graphql_requests_total",
				Help: "GraphQL operations by name and status.",
			},
			[]string{"operation", "status"},
		),
		GraphQLDuration: prometheus.NewHistogramVec(
			prometheus.HistogramOpts{
				Name:    "pulse_graphql_duration_seconds",
				Help:    "GraphQL operation latency.",
				Buckets: prometheus.DefBuckets,
			},
			[]string{"operation"},
		),
		JobsClaimed: prometheus.NewCounterVec(
			prometheus.CounterOpts{Name: "pulse_jobs_claimed_total", Help: "Worker jobs claimed."},
			[]string{"kind"},
		),
		JobsCompleted: prometheus.NewCounterVec(
			prometheus.CounterOpts{Name: "pulse_jobs_completed_total", Help: "Worker jobs completed."},
			[]string{"kind"},
		),
		JobsFailed: prometheus.NewCounterVec(
			prometheus.CounterOpts{Name: "pulse_jobs_failed_total", Help: "Worker jobs that exhausted retries."},
			[]string{"kind"},
		),
		SubscriptionsActive: prometheus.NewGauge(
			prometheus.GaugeOpts{Name: "pulse_subscriptions_active", Help: "In-process GraphQL subscribers."},
		),
		NotifyDropped: prometheus.NewCounterVec(
			prometheus.CounterOpts{
				Name: "pulse_realtime_dropped_total",
				Help: "pg_notify events dropped on slow subscribers.",
			},
			[]string{"topic_prefix"},
		),
	}
	r.MustRegister(
		m.GraphQLRequests,
		m.GraphQLDuration,
		m.JobsClaimed,
		m.JobsCompleted,
		m.JobsFailed,
		m.SubscriptionsActive,
		m.NotifyDropped,
	)
	return m
}

// Handler returns the Prometheus HTTP handler bound to this registry.
// Mount on /metrics. v1 leaves authentication to the deployment
// (private network, basic auth proxy, etc.).
func (m *Metrics) Handler() http.Handler {
	return promhttp.HandlerFor(m.registry, promhttp.HandlerOpts{
		Registry:          m.registry,
		EnableOpenMetrics: true,
	})
}
