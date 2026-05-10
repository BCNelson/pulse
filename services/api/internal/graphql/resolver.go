package graphql

import (
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

// Resolver carries the per-process services every GraphQL resolver leans on.
// gqlgen passes this into each resolver invocation; field resolvers may also
// reach into it for cross-domain calls (e.g. Tag's myPermissions field
// dispatches to Perm).
type Resolver struct {
	DB    *pgxpool.Pool
	Auth  *auth.Service
	Perm  *perm.Service
	Tag   *tag.Service
	Audit *audit.Service
}
