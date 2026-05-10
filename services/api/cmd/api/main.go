package main

import (
	"context"
	"encoding/json"
	"errors"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/graphql-go/graphql"
	"github.com/jackc/pgx/v5/pgxpool"
)

type graphQLRequest struct {
	Query         string                 `json:"query"`
	OperationName string                 `json:"operationName"`
	Variables     map[string]interface{} `json:"variables"`
}

func main() {
	ctx := context.Background()

	cfg := configFromEnv()
	db, err := pgxpool.New(ctx, cfg.databaseURL)
	if err != nil {
		log.Fatalf("connect database: %v", err)
	}
	defer db.Close()

	if err := db.Ping(ctx); err != nil {
		log.Fatalf("ping database: %v", err)
	}

	schema, err := newSchema(db)
	if err != nil {
		log.Fatalf("create graphql schema: %v", err)
	}

	mux := http.NewServeMux()
	mux.HandleFunc("/healthz", healthHandler(db))
	mux.HandleFunc("/graphql", graphQLHandler(schema))

	server := &http.Server{
		Addr:              cfg.apiAddr,
		Handler:           mux,
		ReadHeaderTimeout: 5 * time.Second,
	}

	log.Printf("listening on http://%s/graphql", cfg.apiAddr)
	if err := server.ListenAndServe(); !errors.Is(err, http.ErrServerClosed) {
		log.Fatalf("serve api: %v", err)
	}
}

type appConfig struct {
	apiAddr     string
	databaseURL string
}

func configFromEnv() appConfig {
	return appConfig{
		apiAddr:     envOrDefault("API_ADDR", "127.0.0.1:8080"),
		databaseURL: envOrDefault("DATABASE_URL", "postgres://pulse:pulse@127.0.0.1:5432/pulse?sslmode=disable"),
	}
}

func envOrDefault(key, fallback string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return fallback
}

func healthHandler(db *pgxpool.Pool) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			w.WriteHeader(http.StatusMethodNotAllowed)
			return
		}

		if err := db.Ping(r.Context()); err != nil {
			http.Error(w, "database unavailable", http.StatusServiceUnavailable)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		_ = json.NewEncoder(w).Encode(map[string]string{"status": "ok"})
	}
}

func graphQLHandler(schema graphql.Schema) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			w.WriteHeader(http.StatusMethodNotAllowed)
			return
		}

		var req graphQLRequest
		if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
			http.Error(w, "invalid graphql request", http.StatusBadRequest)
			return
		}

		result := graphql.Do(graphql.Params{
			Schema:         schema,
			RequestString:  req.Query,
			OperationName:  req.OperationName,
			VariableValues: req.Variables,
			Context:        r.Context(),
		})

		status := http.StatusOK
		if len(result.Errors) > 0 {
			status = http.StatusBadRequest
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(status)
		_ = json.NewEncoder(w).Encode(result)
	}
}

func newSchema(db *pgxpool.Pool) (graphql.Schema, error) {
	query := graphql.NewObject(graphql.ObjectConfig{
		Name: "Query",
		Fields: graphql.Fields{
			"health": &graphql.Field{
				Type: graphql.NewNonNull(graphql.String),
				Resolve: func(params graphql.ResolveParams) (interface{}, error) {
					if err := db.Ping(params.Context); err != nil {
						return nil, err
					}
					return "ok", nil
				},
			},
			"serverTime": &graphql.Field{
				Type: graphql.NewNonNull(graphql.String),
				Resolve: func(params graphql.ResolveParams) (interface{}, error) {
					var value time.Time
					if err := db.QueryRow(params.Context, "SELECT now()").Scan(&value); err != nil {
						return nil, err
					}
					return value.Format(time.RFC3339), nil
				},
			},
		},
	})

	return graphql.NewSchema(graphql.SchemaConfig{Query: query})
}
