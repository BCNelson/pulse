package graphql_test

import (
	"net/http"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/handler/extension"
	"github.com/99designs/gqlgen/graphql/handler/transport"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
	"github.com/bcnelson/pulse/services/api/internal/perm"
)

// buildM2Server is a test helper that wires up a full GraphQL handler
// with all M2 services on a passed-in resolver. The M1 buildServer
// helper hard-coded the service set; this variant takes the resolver
// pre-built so the test can seed via the same services.
func buildM2Server(resolver *pulsegraphql.Resolver, authSvc *auth.Service) http.Handler {
	srv := handler.New(pulsegraphql.NewExecutableSchema(pulsegraphql.Config{Resolvers: resolver}))
	srv.AddTransport(transport.POST{})
	srv.AddTransport(transport.Options{})
	srv.AddTransport(transport.GET{})
	srv.Use(extension.Introspection{})
	return perm.WithRequestCacheMiddleware(authSvc.HTTPMiddleware(srv))
}
