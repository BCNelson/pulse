package graphql

import "time"

// anyTimeImpl is the concrete time type used in scanned tag rows. Aliased
// in tag_resolvers.go via `anyTime = anyTimeImpl` so callers can swap to a
// custom timestamp wrapper later without edits at every reference.
type anyTimeImpl = time.Time
