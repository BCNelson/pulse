// Package ids carries the federation-shaped URI helpers. Every cross-
// instance reference uses a URI of the form `<instance>/<kind>/<uuid>`;
// v1 deployments are single-instance and emit `local://` URIs. When
// federation lands the instance prefix becomes a deployment-configured
// value and these helpers grow a parser; until then this package is the
// boundary that keeps "internal UUID" and "external reference" distinct.
package ids

import (
	"fmt"
	"strings"

	"github.com/google/uuid"
)

// LocalInstance is the URI scheme used when no federation instance is
// configured. Federated deployments will swap this for a deployment-
// configured instance identifier.
const LocalInstance = "local://"

// New mints a new random UUID. Provided here so callers don't need to
// import google/uuid directly and so we can swap to UUIDv7 (or another
// scheme) in one place if the choice ever needs revisiting.
func New() uuid.UUID {
	return uuid.New()
}

// URI builds a federation-shaped URI for an entity of the given kind. Kind
// is the plural form used in the public addressing scheme (`principals`,
// `tags`, `posts`, etc.), not the type name.
func URI(kind string, id uuid.UUID) string {
	return fmt.Sprintf("%s%s/%s", LocalInstance, kind, id)
}

// IsLocal reports whether uri points at this instance. Federation will
// replace this with an instance-comparison function.
func IsLocal(uri string) bool {
	return strings.HasPrefix(uri, LocalInstance)
}
