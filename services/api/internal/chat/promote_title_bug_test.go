package chat

import (
	"strings"
	"testing"
	"unicode/utf8"
)

// TestPromoteTitleProducesValidUTF8 documents a bug in promoteTitle: when the
// body is longer than 60 bytes and the 60th byte falls in the middle of a
// multi-byte UTF-8 sequence, the byte-slice truncation `body[:60]` cuts the
// rune in half, leaving an invalid UTF-8 string in the post title.
//
// Repro: a 1-byte ASCII prefix followed by 3-byte CJK runes pushes the 60th
// byte into the second/third byte of a rune. The current implementation
// returns invalid UTF-8 that may render as a replacement character, fail
// downstream validation, or produce a corrupt string in the database.
//
// Expected fix: truncate by runes (e.g. iterate runes and stop at the 60th)
// rather than by bytes, or use utf8.RuneStart to back off to the previous
// rune boundary.
func TestPromoteTitleProducesValidUTF8(t *testing.T) {
	// "a" (1 byte) + 50 × "中" (3 bytes each) = 1 + 150 = 151 bytes.
	// All runes are valid UTF-8 individually. Byte 60 lands inside the
	// 20th 中 (bytes 58, 59, 60 are its three bytes), so body[:60] cuts
	// after the second byte of that rune.
	body := "a" + strings.Repeat("中", 50)
	if len(body) <= 60 {
		t.Fatalf("test setup wrong: body len %d should exceed 60", len(body))
	}

	got := promoteTitle(body)

	// Bug surfaces here: the byte-truncated prefix is not valid UTF-8.
	if !utf8.ValidString(got) {
		t.Errorf("promoteTitle returned invalid UTF-8: %q (bytes: % x)", got, []byte(got))
	}
}
