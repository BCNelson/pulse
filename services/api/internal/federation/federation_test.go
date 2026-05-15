package federation_test

import (
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/federation"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestParseLocal(t *testing.T) {
	id := ids.New(ids.KindUser)
	ref, err := federation.Parse("local://posts/" + ids.FormatID(id))
	if err != nil {
		t.Fatalf("parse: %v", err)
	}
	if !ref.IsLocal {
		t.Errorf("expected local")
	}
	if ref.Kind != "posts" {
		t.Errorf("kind: %q", ref.Kind)
	}
	if ref.ID != id {
		t.Errorf("id: got %d want %d", ref.ID, id)
	}
}

func TestParseRemote(t *testing.T) {
	id := ids.New(ids.KindUser)
	ref, err := federation.Parse("pulse.example.com://principals/" + ids.FormatID(id))
	if err != nil {
		t.Fatalf("parse: %v", err)
	}
	if ref.IsLocal {
		t.Errorf("expected remote")
	}
	if ref.Instance != "pulse.example.com" {
		t.Errorf("instance: %q", ref.Instance)
	}
}

func TestParseRejectsGarbage(t *testing.T) {
	for _, bad := range []string{
		"",
		"not a uri",
		"local://posts/",
		"local://posts/not-a-uuid",
		"local://",
		"://posts/" + ids.FormatID(ids.New(ids.KindUser)),
	} {
		if _, err := federation.Parse(bad); err == nil {
			t.Errorf("expected error for %q", bad)
		}
	}
}

func TestFormatRoundTrip(t *testing.T) {
	id := ids.New(ids.KindUser)
	uri := federation.Format(federation.LocalScheme, "tags", id)
	ref, err := federation.Parse(uri)
	if err != nil {
		t.Fatalf("parse: %v", err)
	}
	if ref.Kind != "tags" || ref.ID != id || !ref.IsLocal {
		t.Errorf("round-trip: %+v", ref)
	}
}

func TestLocalOnlyResolverAlwaysLocal(t *testing.T) {
	r := federation.LocalOnlyResolver{}
	id := ids.New(ids.KindUser)
	ref, _ := federation.Parse("pulse.example.com://posts/" + ids.FormatID(id))
	if got := r.Resolve(ref); got != federation.LocalAuthority {
		t.Errorf("v1 resolver should always return Local, got %v", got)
	}
}
