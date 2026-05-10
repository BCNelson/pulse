package graphql

import (
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/chat"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/realtime"
	"github.com/bcnelson/pulse/services/api/internal/search"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

// Resolver carries the per-process services every GraphQL resolver leans on.
// gqlgen expects type-named methods (Post(), Tag(), ...) to return field
// resolver implementations, so service fields use plural names to avoid
// the collision.
type Resolver struct {
	DB       *pgxpool.Pool
	Auth     *auth.Service
	Perm     *perm.Service
	Tags     *tag.Service
	Audit    *audit.Service
	Posts    *post.Service
	Comments *comment.Service
	Search   *search.Service
	Chat     *chat.Service
	Realtime *realtime.Dispatcher
}
