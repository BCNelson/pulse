package ids

import "fmt"

const (
	// kindShift is how far the 5-bit kind sits from the bottom of the int.
	kindShift = 55
	// bodyMask isolates the 55 random body bits.
	bodyMask = (int64(1) << 55) - 1
)

// Format packs a kind+body into the 60-bit ID layout and returns its wire
// form. Panics if body exceeds 55 bits or kind isn't a registered Kind.
func Format(kind Kind, body int64) string {
	if !kind.IsRegistered() {
		panic(fmt.Sprintf("ids.Format: unregistered kind %d", kind))
	}
	if body < 0 || body > bodyMask {
		panic(fmt.Sprintf("ids.Format: body %d out of 55-bit range", body))
	}
	return Encode(int64(kind)<<kindShift | body)
}

// FormatID is like Format but takes the packed int64 directly — useful at
// the database boundary where rows already hold the packed form.
func FormatID(n int64) string {
	return Encode(n)
}

// Parse decodes a 12-character wire-form ID into its kind and body. Returns
// ErrInvalidID for malformed input or an unregistered kind letter.
func Parse(s string) (Kind, int64, error) {
	n, err := Decode(s)
	if err != nil {
		return 0, 0, err
	}
	k := Kind((n >> kindShift) & 0x1F)
	if !k.IsRegistered() {
		return 0, 0, fmt.Errorf("%w: kind letter %q is not registered", ErrInvalidID, s[0])
	}
	return k, n & bodyMask, nil
}

// ParseAs decodes s and asserts the kind matches expected. Returns the
// packed int64 form (suitable for indexing into a typed-ID column) on
// success; returns ErrInvalidID with context on mismatch or malformed input.
//
// Use ParseAs at resolver entry points so a caller handing a `C…` value
// where a `P…` is expected gets a clear error before any DB lookup runs.
func ParseAs(expected Kind, s string) (int64, error) {
	k, body, err := Parse(s)
	if err != nil {
		return 0, err
	}
	if k != expected {
		return 0, fmt.Errorf("%w: expected kind %s (%c), got %s (%c)",
			ErrInvalidID, expected.Name(), expected.Letter(), k.Name(), k.Letter())
	}
	return int64(k)<<kindShift | body, nil
}

// PackedKind extracts the kind index from a stored int64 ID without going
// through the codec. Useful inside DB-layer code that already has the int.
func PackedKind(n int64) Kind {
	return Kind((n >> kindShift) & 0x1F)
}

// ParseAny decodes a wire-form ID and returns its packed int64 plus the
// detected kind. Validates that the kind letter is registered but doesn't
// pin the kind to any particular value. Use this for polymorphic ID slots
// (audit_events.target_id, notifications.source_id) where the kind comes
// from a companion column rather than a fixed call site.
func ParseAny(s string) (int64, Kind, error) {
	k, body, err := Parse(s)
	if err != nil {
		return 0, 0, err
	}
	return int64(k)<<kindShift | body, k, nil
}
