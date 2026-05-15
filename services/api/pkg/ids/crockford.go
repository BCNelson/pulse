package ids

import (
	"errors"
	"fmt"
)

// Crockford base32 alphabet — excludes I, L, O, U to avoid visual ambiguity.
const alphabet = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"

// decodeTable maps every accepted input byte to its 5-bit Crockford value,
// or -1 if the byte isn't a valid Crockford char. The decoder accepts upper
// and lower case plus the standard substitutions: I, L → 1 and O → 0.
var decodeTable = func() [256]int8 {
	var t [256]int8
	for i := range t {
		t[i] = -1
	}
	for i, c := range alphabet {
		t[c] = int8(i)
		// Lowercase variant.
		if c >= 'A' && c <= 'Z' {
			t[c+('a'-'A')] = int8(i)
		}
	}
	t['I'], t['i'] = 1, 1
	t['L'], t['l'] = 1, 1
	t['O'], t['o'] = 0, 0
	return t
}()

// max60 is the largest value that fits in 60 bits — the encoder rejects
// values above this and the decoder never produces a larger output.
const max60 = (int64(1) << 60) - 1

// ErrInvalidID is returned for any malformed encoded ID.
var ErrInvalidID = errors.New("ids: invalid id")

// Encode returns the 12-character Crockford-base32 wire form of n's bottom
// 60 bits, MSB-first. Panics if n is negative or exceeds the 60-bit range —
// callers should only pass values produced by Format or read from the
// database via a typed ID.
func Encode(n int64) string {
	if n < 0 || n > max60 {
		panic(fmt.Sprintf("ids.Encode: value %d out of 60-bit range", n))
	}
	var out [12]byte
	for i := 0; i < 12; i++ {
		shift := uint(5 * (11 - i))
		out[i] = alphabet[(n>>shift)&0x1F]
	}
	return string(out[:])
}

// Decode parses a 12-character Crockford wire form into its 60-bit int.
// Accepts upper/lowercase plus the standard substitutions; rejects any
// other input.
func Decode(s string) (int64, error) {
	if len(s) != 12 {
		return 0, fmt.Errorf("%w: expected 12 chars, got %d", ErrInvalidID, len(s))
	}
	var n int64
	for i := 0; i < 12; i++ {
		v := decodeTable[s[i]]
		if v < 0 {
			return 0, fmt.Errorf("%w: invalid char %q at position %d", ErrInvalidID, s[i], i)
		}
		n = (n << 5) | int64(v)
	}
	return n, nil
}
