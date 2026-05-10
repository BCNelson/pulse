package federation_test

import (
	"testing"

	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/internal/federation"
)

func TestParseLocal(t *testing.T) {
	id := uuid.New()
	ref, err := federation.Parse("local://posts/" + id.String())
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
		t.Errorf("id: got %s want %s", ref.ID, id)
	}
}

func TestParseRemote(t *testing.T) {
	id := uuid.New()
	ref, err := federation.Parse("pulse.example.com://principals/" + id.String())
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
		"://posts/" + uuid.New().String(),
	} {
		if _, err := federation.Parse(bad); err == nil {
			t.Errorf("expected error for %q", bad)
		}
	}
}

func TestFormatRoundTrip(t *testing.T) {
	id := uuid.New()
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
	id := uuid.New()
	ref, _ := federation.Parse("pulse.example.com://posts/" + id.String())
	if got := r.Resolve(ref); got != federation.LocalAuthority {
		t.Errorf("v1 resolver should always return Local, got %v", got)
	}
}
