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
	"github.com/gorilla/websocket"
	"github.com/jackc/pgx/v5/pgxpool"

	awsconfig "github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/s3"

	pulseattachment "github.com/bcnelson/pulse/services/api/internal/attachment"
	pulseaudit "github.com/bcnelson/pulse/services/api/internal/audit"
	pulseauth "github.com/bcnelson/pulse/services/api/internal/auth"
	pulsechat "github.com/bcnelson/pulse/services/api/internal/chat"
	pulsecomment "github.com/bcnelson/pulse/services/api/internal/comment"
	pulsedb "github.com/bcnelson/pulse/services/api/internal/db"
	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
	pulseloaders "github.com/bcnelson/pulse/services/api/internal/graphql/loaders"
	pulseimpersonation "github.com/bcnelson/pulse/services/api/internal/impersonation"
	pulsejob "github.com/bcnelson/pulse/services/api/internal/job"
	pulsenotification "github.com/bcnelson/pulse/services/api/internal/notification"
	pulseobs "github.com/bcnelson/pulse/services/api/internal/observability"
	pulseperm "github.com/bcnelson/pulse/services/api/internal/perm"
	pulsepost "github.com/bcnelson/pulse/services/api/internal/post"
	pulsepush "github.com/bcnelson/pulse/services/api/internal/push"
	pulserealtime "github.com/bcnelson/pulse/services/api/internal/realtime"
	pulseretention "github.com/bcnelson/pulse/services/api/internal/retention"
	pulsesearch "github.com/bcnelson/pulse/services/api/internal/search"
	pulsetag "github.com/bcnelson/pulse/services/api/internal/tag"
	pulsetask "github.com/bcnelson/pulse/services/api/internal/task"
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

	// Job registry is shared by api+worker modes so producers and consumers
	// agree on kinds. Even in --mode=api the registry exists so future
	// in-process jobs (e.g. inline tests) can register, though only worker
	// mode polls.
	pushSvc := &pulsepush.Service{
		DB:       pool,
		Provider: buildPushProvider(ctx, logger.With("component", "push")),
		Logger:   logger.With("component", "push"),
	}
	notifSvc := &pulsenotification.Service{DB: pool, Push: pushSvc}
	retentionSvc := &pulseretention.Service{DB: pool, Logger: logger.With("component", "retention")}
	registry := pulsejob.NewRegistry()
	registry.Register("notification.fanout", notifSvc.Handler)
	registry.Register(pulseretention.JobKind, retentionSvc.Handler)

	if runAPI {
		go func() {
			errs <- runAPIServer(ctx, cfg, logger.With("component", "api"), pool, notifSvc, pushSvc)
		}()
	}
	if runWorker {
		worker := &pulsejob.Worker{
			DB:       pool,
			Logger:   logger.With("component", "worker"),
			Registry: registry,
		}
		go func() { errs <- worker.Run(ctx) }()
		// Periodic retention sweep: enqueue once an hour. Job-queue
		// dedupe is the retention service's responsibility (sweep is
		// idempotent — it only deletes rows past cutoff).
		go runRetentionScheduler(ctx, pool, logger.With("component", "retention-scheduler"))
	}

	select {
	case <-ctx.Done():
		return nil
	case err := <-errs:
		return err
	}
}

func runAPIServer(ctx context.Context, cfg appConfig, logger *slog.Logger, pool *pgxpool.Pool, notifSvc *pulsenotification.Service, pushSvc *pulsepush.Service) error {
	authSvc := &pulseauth.Service{DB: pool}
	postSvc := &pulsepost.Service{DB: pool}
	permSvc := &pulseperm.Service{DB: pool}
	auditSvc := &pulseaudit.Service{DB: pool}

	attachmentSvc, err := buildAttachmentService(ctx, pool, cfg)
	if err != nil {
		// Attachment uploads are optional in dev — log and continue with a
		// nil service so resolvers return errPermissionDenied on attempt.
		logger.Warn("attachments disabled", "err", err)
	}

	dispatcher, err := pulserealtime.New(ctx, cfg.databaseURL, logger.With("component", "realtime"))
	if err != nil {
		return fmt.Errorf("realtime: %w", err)
	}

	resolver := &pulsegraphql.Resolver{
		DB:            pool,
		Auth:          authSvc,
		Perm:          permSvc,
		Tags:          &pulsetag.Service{DB: pool},
		Audit:         auditSvc,
		Posts:         postSvc,
		Comments:      &pulsecomment.Service{DB: pool},
		Search:        &pulsesearch.Service{DB: pool},
		Chat:          &pulsechat.Service{DB: pool, Posts: postSvc},
		Tasks:         &pulsetask.Service{DB: pool},
		Notifications: notifSvc,
		Impersonation: &pulseimpersonation.Service{DB: pool, Perm: permSvc, Audit: auditSvc},
		Push:          pushSvc,
		Attachments:   attachmentSvc,
		Realtime:      dispatcher,
	}

	srv := handler.New(pulsegraphql.NewExecutableSchema(pulsegraphql.Config{
		Resolvers: resolver,
	}))
	srv.AddTransport(transport.POST{})
	srv.AddTransport(transport.Options{})
	srv.AddTransport(transport.GET{})
	// Subscriptions over WebSocket (graphql-transport-ws).
	//
	// CheckOrigin shares the CORS allowlist so cross-origin browser
	// clients (Flutter web on a separate port, prod web on a different
	// host than the API) aren't 403'd by gorilla's default same-origin
	// rule. InitFunc reads the bearer token from the connection_init
	// payload — browsers can't set Authorization on a WS handshake, so
	// the client sends it in the GraphQL init message instead.
	policy := loadOriginPolicy()
	srv.AddTransport(transport.Websocket{
		Upgrader: websocket.Upgrader{
			CheckOrigin: func(r *http.Request) bool {
				return policy.allows(r.Header.Get("Origin"))
			},
		},
		KeepAlivePingInterval: 30 * time.Second,
		// Close the connection if connection_init (where the auth payload
		// arrives) doesn't show up promptly. Prevents idle half-open
		// sockets from sitting on server resources.
		InitTimeout: 10 * time.Second,
		InitFunc: func(ctx context.Context, payload transport.InitPayload) (context.Context, *transport.InitPayload, error) {
			header := payload.Authorization()
			if header == "" {
				return ctx, nil, nil
			}
			id, sessionID, ok := authSvc.IdentityFromAuthHeader(ctx, header)
			if !ok {
				return ctx, nil, nil
			}
			ctx = pulseauth.WithIdentity(ctx, id)
			if sessionID != int64(0) {
				ctx = pulseauth.WithSessionID(ctx, sessionID)
			}
			return ctx, nil, nil
		},
	})
	srv.Use(extension.Introspection{})

	// Per-request loader + perm cache wrap every GraphQL operation; auth
	// middleware resolves bearer/cookie -> Identity before the resolver
	// runs. Loader middleware sits inside the perm cache so both share
	// the request lifetime.
	gql := pulseloaders.Middleware(pool,
		pulseperm.WithRequestCacheMiddleware(authSvc.HTTPMiddleware(srv)))

	metrics := pulseobs.New()

	r := chi.NewRouter()
	r.Use(middleware.RealIP)
	r.Use(middleware.RequestID)
	r.Use(middleware.Recoverer)
	r.Use(corsMiddleware(policy))
	r.Get("/healthz", healthHandler(pool))
	r.Handle("/graphql", gql)
	r.Get("/playground", playground.Handler("Pulse", "/graphql"))
	r.Handle("/metrics", metrics.Handler())
	// Single-origin prod: when PULSE_WEB_DIR points at the flutter build
	// output, serve the SPA from any unmatched path. Dev uses
	// `flutter run -d chrome` (separate origin) and relies on
	// corsMiddleware instead.
	if cfg.webDir != "" {
		r.NotFound(staticSPAHandler(cfg.webDir))
	}

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
	webDir        string

	s3Endpoint  string
	s3Region    string
	s3Bucket    string
	s3AccessKey string
	s3SecretKey string
	s3PathStyle bool
}

func configFromEnv() appConfig {
	return appConfig{
		apiAddr:       envOrDefault("API_ADDR", "127.0.0.1:8080"),
		databaseURL:   envOrDefault("DATABASE_URL", "postgres://pulse:pulse@127.0.0.1:5432/pulse?sslmode=disable"),
		migrationsDir: envOrDefault("GOOSE_MIGRATION_DIR", "db/migrations"),
		webDir:        os.Getenv("PULSE_WEB_DIR"),

		// S3-compatible config. Defaults target a local MinIO. Production
		// deployments override AWS_S3_* / S3_ENDPOINT / S3_BUCKET.
		s3Endpoint:  envOrDefault("S3_ENDPOINT", ""),
		s3Region:    envOrDefault("S3_REGION", "us-east-1"),
		s3Bucket:    envOrDefault("S3_BUCKET", ""),
		s3AccessKey: envOrDefault("S3_ACCESS_KEY", ""),
		s3SecretKey: envOrDefault("S3_SECRET_KEY", ""),
		s3PathStyle: envOrDefault("S3_PATH_STYLE", "true") == "true",
	}
}

// buildAttachmentService wires the attachment service against an
// S3-compatible bucket. Returns nil + a typed error when no bucket is
// configured so the caller can decide whether to fail the boot or
// degrade gracefully.
func buildAttachmentService(ctx context.Context, pool *pgxpool.Pool, cfg appConfig) (*pulseattachment.Service, error) {
	if cfg.s3Bucket == "" {
		return nil, fmt.Errorf("S3_BUCKET not set")
	}
	loadOpts := []func(*awsconfig.LoadOptions) error{
		awsconfig.WithRegion(cfg.s3Region),
	}
	if cfg.s3AccessKey != "" && cfg.s3SecretKey != "" {
		loadOpts = append(loadOpts, awsconfig.WithCredentialsProvider(
			credentials.NewStaticCredentialsProvider(cfg.s3AccessKey, cfg.s3SecretKey, ""),
		))
	}
	awsCfg, err := awsconfig.LoadDefaultConfig(ctx, loadOpts...)
	if err != nil {
		return nil, fmt.Errorf("aws config: %w", err)
	}
	s3Client := s3.NewFromConfig(awsCfg, func(o *s3.Options) {
		if cfg.s3Endpoint != "" {
			o.BaseEndpoint = &cfg.s3Endpoint
		}
		o.UsePathStyle = cfg.s3PathStyle
	})
	return &pulseattachment.Service{
		DB:       pool,
		Presign:  s3.NewPresignClient(s3Client),
		Bucket:   cfg.s3Bucket,
		S3Client: s3Client,
	}, nil
}

func envOrDefault(key, fallback string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return fallback
}

// buildPushProvider picks the active push provider based on env. With
// FCM and/or APNs creds set, returns a Selector wrapping the
// configured providers. With neither, falls back to LogProvider so
// dev runs don't fail and operators can wire up later.
func buildPushProvider(ctx context.Context, logger *slog.Logger) pulsepush.Provider {
	fcmCreds := os.Getenv("PULSE_FCM_CREDENTIALS_FILE")
	apnsTeam := os.Getenv("PULSE_APNS_TEAM_ID")

	var fcm *pulsepush.FCMProvider
	var apns *pulsepush.APNsProvider

	if fcmCreds != "" {
		p, err := pulsepush.NewFCMProvider(ctx, fcmCreds, os.Getenv("PULSE_FCM_PROJECT_ID"), logger)
		if err != nil {
			logger.Warn("fcm provider disabled", "err", err)
		} else {
			fcm = p
			logger.Info("push.fcm.configured")
		}
	}
	if apnsTeam != "" {
		p, err := pulsepush.NewAPNsProvider(pulsepush.APNsConfig{
			TeamID:  apnsTeam,
			KeyID:   os.Getenv("PULSE_APNS_KEY_ID"),
			KeyFile: os.Getenv("PULSE_APNS_KEY_FILE"),
			Topic:   os.Getenv("PULSE_APNS_TOPIC"),
			Host:    os.Getenv("PULSE_APNS_HOST"),
		})
		if err != nil {
			logger.Warn("apns provider disabled", "err", err)
		} else {
			apns = p
			logger.Info("push.apns.configured")
		}
	}

	if fcm == nil && apns == nil {
		logger.Info("push.stub.in_use")
		return &pulsepush.LogProvider{Logger: logger}
	}
	return &pulsepush.Selector{APNs: apns, FCM: fcm}
}

// runRetentionScheduler enqueues retention.sweep jobs on a fixed
// cadence. Single-instance deployments use this; multi-replica
// deployments should pin one replica as the scheduler (e.g. by
// running --mode=worker with PULSE_SCHEDULE=retention on exactly one
// pod).
func runRetentionScheduler(ctx context.Context, pool *pgxpool.Pool, logger *slog.Logger) {
	if os.Getenv("PULSE_DISABLE_RETENTION_SCHEDULE") == "true" {
		logger.Info("retention scheduler disabled by env")
		return
	}
	// Run an initial sweep at boot and then daily.
	tick := time.NewTicker(24 * time.Hour)
	defer tick.Stop()
	enqueue := func() {
		if err := pulsejob.Enqueue(ctx, pool, pulseretention.JobKind, map[string]any{}); err != nil {
			logger.Warn("retention enqueue failed", "err", err)
		}
	}
	enqueue()
	for {
		select {
		case <-ctx.Done():
			return
		case <-tick.C:
			enqueue()
		}
	}
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
