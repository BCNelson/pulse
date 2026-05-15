package ids

import (
	"crypto/rand"
	"encoding/binary"
	"fmt"
)

// Helpers shipped alongside the typed-ID system so callers don't repeat
// the same boilerplate at every parse/format site.

// MustParseAs is the panicking variant of ParseAs — useful in tests, in
// migration code, and at any site where a malformed input is a programmer
// error rather than a runtime condition.
func MustParseAs(expected Kind, s string) int64 {
	n, err := ParseAs(expected, s)
	if err != nil {
		panic(err)
	}
	return n
}

// IsNil reports whether n is the zero value (the sentinel for "no ID set").
// Since the gen_id Postgres function never produces 0 (it loops if the
// random body happens to be zero), 0 is a safe sentinel.
func IsNil(n int64) bool { return n == 0 }

// New mints a fresh typed ID for the given kind. The body is drawn from
// crypto/rand and the kind is packed into the high bits — matching the
// Postgres gen_id() function bit-for-bit. Primarily for tests, seed code,
// and any Go-side path that needs an ID before the DB INSERT runs (most
// production paths let Postgres generate via gen_id_<kind>() DEFAULT).
func New(kind Kind) int64 {
	if !kind.IsRegistered() {
		panic(fmt.Sprintf("ids.New: unregistered kind %d", kind))
	}
	for {
		var b [7]byte
		if _, err := rand.Read(b[:]); err != nil {
			panic("ids.New: crypto/rand failure: " + err.Error())
		}
		// 7 bytes = 56 bits; mask the top bit of byte 0 to clamp at 55.
		b[0] &= 0x7F
		var body int64
		// Build the 55-bit body MSB-first.
		var buf [8]byte
		copy(buf[1:], b[:])
		body = int64(binary.BigEndian.Uint64(buf[:]))
		if body == 0 {
			continue
		}
		return (int64(kind) << kindShift) | body
	}
}

// NewN mints n fresh typed IDs in one call.
func NewN(kind Kind, n int) []int64 {
	out := make([]int64, n)
	for i := range out {
		out[i] = New(kind)
	}
	return out
}
