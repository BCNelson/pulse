package graphql

import "github.com/jackc/pgx/v5/pgxpool"

// Resolver carries dependencies for every GraphQL resolver. Domain services
// (auth, tag, post, ...) get added here as later milestones land.
type Resolver struct {
	DB *pgxpool.Pool
}
