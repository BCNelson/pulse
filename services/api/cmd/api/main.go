package main

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/handler/extension"
	"github.com/99designs/gqlgen/graphql/handler/transport"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/jackc/pgx/v5/pgxpool"

	pulseaudit "github.com/bcnelson/pulse/services/api/internal/audit"
	pulseauth "github.com/bcnelson/pulse/services/api/internal/auth"
	pulsedb "github.com/bcnelson/pulse/services/api/internal/db"
	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
	pulsejob "github.com/bcnelson/pulse/services/api/internal/job"
	pulseperm "github.com/bcnelson/pulse/services/api/internal/perm"
	pulsetag "github.com/bcnelson/pulse/services/api/internal/tag"
)

const (
	modeAPI    = "api"
	modeWorker = "worker"
	modeBoth   = "both"
)

func main() {
	mode := flag.String("mode", envOrDefault("PULSE_MODE", modeBoth), "process mode: api | worker | both")
	flag.Parse()

	cfg := configFromEnv()
	logger := slog.New(slog.NewJSONHandler(os.Stderr, nil))

	rootCtx, cancel := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer cancel()

	if err := pulsedb.Migrate(rootCtx, cfg.databaseURL, cfg.migrationsDir); err != nil {
		logger.Error("apply migrations", "err", err)
		os.Exit(1)
	}

	pool, err := pulsedb.NewPool(rootCtx, cfg.databaseURL)
	if err != nil {
		logger.Error("connect database", "err", err)
		os.Exit(1)
	}
	defer pool.Close()

	if err := run(rootCtx, *mode, cfg, logger, pool); err != nil {
		logger.Error("server exited with error", "err", err)
		os.Exit(1)
	}
}

func run(ctx context.Context, mode string, cfg appConfig, logger *slog.Logger, pool *pgxpool.Pool) error {
	runAPI := mode == modeAPI || mode == modeBoth
	runWorker := mode == modeWorker || mode == modeBoth
	if !runAPI && !runWorker {
		return fmt.Errorf("invalid mode %q (use api|worker|both)", mode)
	}

	errs := make(chan error, 2)

	if runAPI {
		go func() { errs <- runAPIServer(ctx, cfg, logger.With("component", "api"), pool) }()
	}
	if runWorker {
		worker := &pulsejob.Worker{DB: pool, Logger: logger.With("component", "worker")}
		go func() { errs <- worker.Run(ctx) }()
	}

	select {
	case <-ctx.Done():
		return nil
	case err := <-errs:
		return err
	}
}

func runAPIServer(ctx context.Context, cfg appConfig, logger *slog.Logger, pool *pgxpool.Pool) error {
	authSvc := &pulseauth.Service{DB: pool}
	resolver := &pulsegraphql.Resolver{
		DB:    pool,
		Auth:  authSvc,
		Perm:  &pulseperm.Service{DB: pool},
		Tag:   &pulsetag.Service{DB: pool},
		Audit: &pulseaudit.Service{DB: pool},
	}

	srv := handler.New(pulsegraphql.NewExecutableSchema(pulsegraphql.Config{
		Resolvers: resolver,
	}))
	srv.AddTransport(transport.POST{})
	srv.AddTransport(transport.Options{})
	srv.AddTransport(transport.GET{})
	srv.Use(extension.Introspection{})

	// Per-request perm cache wraps every GraphQL operation; auth middleware
	// resolves bearer/cookie -> Identity before the resolver runs.
	gql := pulseperm.WithRequestCacheMiddleware(authSvc.HTTPMiddleware(srv))

	r := chi.NewRouter()
	r.Use(middleware.RealIP)
	r.Use(middleware.RequestID)
	r.Use(middleware.Recoverer)
	r.Get("/healthz", healthHandler(pool))
	r.Handle("/graphql", gql)
	r.Get("/playground", playground.Handler("Pulse", "/graphql"))

	server := &http.Server{
		Addr:              cfg.apiAddr,
		Handler:           r,
		ReadHeaderTimeout: 5 * time.Second,
	}

	go func() {
		<-ctx.Done()
		shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		_ = server.Shutdown(shutdownCtx)
	}()

	logger.Info("listening", "addr", cfg.apiAddr)
	if err := server.ListenAndServe(); !errors.Is(err, http.ErrServerClosed) {
		return fmt.Errorf("listen: %w", err)
	}
	return nil
}

type appConfig struct {
	apiAddr       string
	databaseURL   string
	migrationsDir string
}

func configFromEnv() appConfig {
	return appConfig{
		apiAddr:       envOrDefault("API_ADDR", "127.0.0.1:8080"),
		databaseURL:   envOrDefault("DATABASE_URL", "postgres://pulse:pulse@127.0.0.1:5432/pulse?sslmode=disable"),
		migrationsDir: envOrDefault("GOOSE_MIGRATION_DIR", "db/migrations"),
	}
}

func envOrDefault(key, fallback string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return fallback
}

func healthHandler(pool *pgxpool.Pool) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if err := pool.Ping(r.Context()); err != nil {
			http.Error(w, "database unavailable", http.StatusServiceUnavailable)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		_, _ = w.Write([]byte(`{"status":"ok"}`))
	}
}
