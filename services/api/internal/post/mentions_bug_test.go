package post_test

import (
	"reflect"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/post"
)

// TestExtractMentionSlugsAdjacent documents a bug in the mentionPattern
// regex: `(?:^|[^\w])@([a-zA-Z0-9_~/-]+)`.
//
// The boundary clause `[^\w]` is a *consuming* match, not a true word
// boundary. After matching `@alice`, the regex cursor sits on the next
// `@` — but to match `@bob` the engine needs another non-word char to
// consume *before* the `@`. There isn't one, so `@bob` is silently
// dropped.
//
// The package's docstring promises mentions "at word boundaries"; the
// natural reading is that `@a@b` produces two slugs. Whether or not we
// want to support that is a product call, but the current behavior is
// unintentional — it falls out of using `[^\w]` instead of a real word
// boundary `\b` (Go's regexp supports `\b`).
//
// Concrete case where this bites: when notifications.fanout uses these
// slugs to resolve mentions, `@bob` in `"@alice@bob"` is silently
// dropped from the recipient list.
func TestExtractMentionSlugsAdjacent(t *testing.T) {
	got := post.ExtractMentionSlugs("@alice@bob")
	want := []string{"alice", "bob"}
	if !reflect.DeepEqual(got, want) {
		t.Errorf("ExtractMentionSlugs(%q): want %v, got %v", "@alice@bob", want, got)
	}
}
