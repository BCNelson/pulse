package ids_test

import (
	"encoding/json"
	"errors"
	"os"
	"path/filepath"
	"strings"
	"testing"

	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

type vectorFile struct {
	Kinds      map[string]int `json:"kinds"`
	RoundTrips []struct {
		Kind int    `json:"kind"`
		Body int64  `json:"body"`
		Int  int64  `json:"int"`
		Str  string `json:"str"`
	} `json:"roundTrips"`
	LowercaseEquivalents []struct {
		Canonical string `json:"canonical"`
		Variant   string `json:"variant"`
	} `json:"lowercaseEquivalents"`
	Substitutions []struct {
		Canonical string   `json:"canonical"`
		Variants  []string `json:"variants"`
	} `json:"substitutions"`
	Rejections []struct {
		Input  string `json:"input"`
		Reason string `json:"reason"`
	} `json:"rejections"`
	UnregisteredKinds []struct {
		Input string `json:"input"`
	} `json:"unregisteredKinds"`
}

func loadVectors(t *testing.T) vectorFile {
	t.Helper()
	data, err := os.ReadFile(filepath.Join("testdata", "crockford_vectors.json"))
	if err != nil {
		t.Fatalf("read vectors: %v", err)
	}
	var v vectorFile
	if err := json.Unmarshal(data, &v); err != nil {
		t.Fatalf("parse vectors: %v", err)
	}
	return v
}

func TestRoundTripVectors(t *testing.T) {
	v := loadVectors(t)
	for _, rt := range v.RoundTrips {
		got := ids.Format(ids.Kind(rt.Kind), rt.Body)
		if got != rt.Str {
			t.Errorf("Format(%d, %d) = %q, want %q", rt.Kind, rt.Body, got, rt.Str)
		}
		k, body, err := ids.Parse(rt.Str)
		if err != nil {
			t.Errorf("Parse(%q): %v", rt.Str, err)
			continue
		}
		if int(k) != rt.Kind || body != rt.Body {
			t.Errorf("Parse(%q) = (%d, %d), want (%d, %d)", rt.Str, k, body, rt.Kind, rt.Body)
		}
		if got := ids.FormatID(rt.Int); got != rt.Str {
			t.Errorf("FormatID(%d) = %q, want %q", rt.Int, got, rt.Str)
		}
	}
}

func TestLowercaseAccepted(t *testing.T) {
	v := loadVectors(t)
	for _, eq := range v.LowercaseEquivalents {
		c, _, err := ids.Parse(eq.Canonical)
		if err != nil {
			t.Fatalf("Parse(%q): %v", eq.Canonical, err)
		}
		l, _, err := ids.Parse(eq.Variant)
		if err != nil {
			t.Fatalf("Parse(%q): %v", eq.Variant, err)
		}
		if c != l {
			t.Errorf("Parse(%q) != Parse(%q)", eq.Canonical, eq.Variant)
		}
	}
}

func TestCrockfordSubstitutions(t *testing.T) {
	v := loadVectors(t)
	for _, sub := range v.Substitutions {
		canonN, err := ids.Decode(sub.Canonical)
		if err != nil {
			t.Fatalf("Decode(%q): %v", sub.Canonical, err)
		}
		for _, variant := range sub.Variants {
			got, err := ids.Decode(variant)
			if err != nil {
				t.Errorf("Decode(%q): %v", variant, err)
				continue
			}
			if got != canonN {
				t.Errorf("Decode(%q) = %d, want %d (matches %q)", variant, got, canonN, sub.Canonical)
			}
		}
	}
}

func TestRejections(t *testing.T) {
	v := loadVectors(t)
	for _, r := range v.Rejections {
		_, _, err := ids.Parse(r.Input)
		if err == nil {
			t.Errorf("Parse(%q) should have failed (%s)", r.Input, r.Reason)
			continue
		}
		if !errors.Is(err, ids.ErrInvalidID) {
			t.Errorf("Parse(%q) returned %v, want ErrInvalidID", r.Input, err)
		}
	}
}

func TestUnregisteredKindRejected(t *testing.T) {
	v := loadVectors(t)
	for _, u := range v.UnregisteredKinds {
		_, _, err := ids.Parse(u.Input)
		if err == nil {
			t.Errorf("Parse(%q) should have failed for unregistered kind", u.Input)
		}
	}
}

func TestParseAsKindMismatch(t *testing.T) {
	postWire := ids.Format(ids.KindPost, 42)
	_, err := ids.ParseAs(ids.KindComment, postWire)
	if err == nil {
		t.Fatal("ParseAs accepted a post id as a comment")
	}
	if !errors.Is(err, ids.ErrInvalidID) {
		t.Errorf("got %v, want ErrInvalidID", err)
	}
	// Sanity: ParseAs with the right kind succeeds.
	got, err := ids.ParseAs(ids.KindPost, postWire)
	if err != nil {
		t.Fatalf("ParseAs(KindPost): %v", err)
	}
	if ids.PackedKind(got) != ids.KindPost {
		t.Errorf("PackedKind = %v, want KindPost", ids.PackedKind(got))
	}
}

func TestURI(t *testing.T) {
	body := int64(0xDEADBEEF)
	n, err := ids.ParseAs(ids.KindPost, ids.Format(ids.KindPost, body))
	if err != nil {
		t.Fatalf("ParseAs: %v", err)
	}
	uri := ids.URI(ids.KindPost, n)
	if !strings.HasPrefix(uri, "local://posts/") {
		t.Errorf("unexpected URI prefix: %q", uri)
	}
	if !strings.HasSuffix(uri, ids.FormatID(n)) {
		t.Errorf("URI tail mismatch: %q", uri)
	}
	if !ids.IsLocal(uri) {
		t.Errorf("IsLocal(%q) = false", uri)
	}
	if ids.IsLocal("https://other.example.com/posts/PABCDEFGHJKM") {
		t.Errorf("remote URI mis-classified as local")
	}
}

func TestKindLettersAreDistinct(t *testing.T) {
	seen := map[byte]ids.Kind{}
	registered := []ids.Kind{
		ids.KindAttachment, ids.KindComment, ids.KindDevice, ids.KindJob,
		ids.KindTask, ids.KindImpersonation, ids.KindNotification, ids.KindPost,
		ids.KindRoom, ids.KindSession, ids.KindTag, ids.KindUser, ids.KindWorkspace,
	}
	for _, k := range registered {
		l := k.Letter()
		if prev, ok := seen[l]; ok {
			t.Errorf("kinds %v and %v share letter %c", prev, k, l)
		}
		seen[l] = k
	}
}

func TestTypedIDJSONRoundTrip(t *testing.T) {
	type envelope struct {
		PostID    ids.PostID    `json:"post"`
		CommentID ids.CommentID `json:"comment"`
	}
	post := ids.PostID(int64(ids.KindPost)<<55 | 12345)
	comment := ids.CommentID(int64(ids.KindComment)<<55 | 67890)
	src := envelope{PostID: post, CommentID: comment}
	encoded, err := json.Marshal(src)
	if err != nil {
		t.Fatalf("marshal: %v", err)
	}
	if !strings.Contains(string(encoded), `"`+post.String()+`"`) {
		t.Errorf("encoded JSON missing post wire form: %s", encoded)
	}
	var got envelope
	if err := json.Unmarshal(encoded, &got); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	if got.PostID != post || got.CommentID != comment {
		t.Errorf("round-trip mismatch: %+v vs %+v", got, src)
	}
}

func TestTypedIDJSONRejectsWrongKind(t *testing.T) {
	postWire, _ := json.Marshal(ids.PostID(int64(ids.KindPost)<<55 | 7))
	var c ids.CommentID
	if err := json.Unmarshal(postWire, &c); err == nil {
		t.Fatal("expected unmarshal to reject post id into CommentID")
	}
}
