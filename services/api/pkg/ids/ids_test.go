package ids_test

import (
	"strings"
	"testing"

	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestNewProducesUniqueIDs(t *testing.T) {
	a := ids.New()
	b := ids.New()
	if a == b {
		t.Fatal("expected distinct UUIDs")
	}
	if a == uuid.Nil {
		t.Fatal("expected non-nil UUID")
	}
}

func TestURIShape(t *testing.T) {
	id := ids.New()
	uri := ids.URI("principals", id)
	if !strings.HasPrefix(uri, "local://principals/") {
		t.Errorf("unexpected prefix: %q", uri)
	}
	if !strings.HasSuffix(uri, id.String()) {
		t.Errorf("URI did not end with id: %q", uri)
	}
}

func TestIsLocal(t *testing.T) {
	if !ids.IsLocal("local://tags/" + ids.New().String()) {
		t.Error("local URI should be recognized")
	}
	if ids.IsLocal("https://other.example.com/tags/" + ids.New().String()) {
		t.Error("remote URI should not be recognized as local")
	}
}
