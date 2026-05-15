// Package ids implements the typed Crockford-base32 ID scheme used across
// the Pulse backend.
//
// Every entity (post, comment, tag, room, …) carries a 63-bit positive
// bigint primary key with a structured layout:
//
//	bit 63       sign (always 0)
//	bits 62..60  padding (always 0)
//	bits 59..55  kind index (5 bits, see kinds.go)
//	bits 54..0   random body (55 bits)
//
// On the wire — URLs, GraphQL ID values, federation URIs, logs — IDs
// render as a 12-character Crockford-base32 string. The first character
// is the kind letter; the remaining 11 chars encode the body. The full
// 12-char string is exactly the bottom 60 bits of the int, Crockford-
// encoded MSB-first, so the codec is a single tight loop with no shifts.
//
// Federation: globalUri values are `local://<kind-name>/<typed-id>`, where
// kind-name is the plural URI segment (`posts`, `tags`, …). When real
// federation lands the `local://` prefix becomes a deployment-configured
// instance identifier; the rest of the URI shape is forward-compatible.
package ids

import (
	"fmt"
	"strings"
)

// LocalInstance is the URI scheme used for entity references on this
// instance. Federated deployments will swap this for a configured
// instance identifier; the rest of the URI shape stays the same.
const LocalInstance = "local://"

// URI builds the federation-shaped URI for a typed ID. id is the packed
// int64 form (output of Format/gen_id); kind names the entity's plural
// URI segment, which must match id's embedded kind. Panics on mismatch
// so a typo at the call site fails loudly rather than silently emitting
// an invalid URI.
func URI(kind Kind, id int64) string {
	if PackedKind(id) != kind {
		panic(fmt.Sprintf("ids.URI: kind %s does not match packed id (kind=%c)",
			kind.Name(), PackedKind(id).Letter()))
	}
	return LocalInstance + kind.Name() + "/" + FormatID(id)
}

// IsLocal reports whether uri points at this instance. Federation will
// replace this with an instance-comparison function.
func IsLocal(uri string) bool {
	return strings.HasPrefix(uri, LocalInstance)
}
