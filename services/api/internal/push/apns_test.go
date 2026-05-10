package push_test

import (
	"context"
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/rand"
	"crypto/x509"
	"encoding/pem"
	"net/http"
	"net/http/httptest"
	"os"
	"path/filepath"
	"strings"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/push"
)

// genTestKey writes a fresh ECDSA P-256 .p8 key to a tempdir so tests
// don't have to ship a real one in-tree. Returns the path.
func genTestKey(t *testing.T) string {
	t.Helper()
	key, err := ecdsa.GenerateKey(elliptic.P256(), rand.Reader)
	if err != nil {
		t.Fatalf("genkey: %v", err)
	}
	bs, err := x509.MarshalPKCS8PrivateKey(key)
	if err != nil {
		t.Fatalf("marshal: %v", err)
	}
	pemBytes := pem.EncodeToMemory(&pem.Block{Type: "PRIVATE KEY", Bytes: bs})
	dir := t.TempDir()
	path := filepath.Join(dir, "test.p8")
	if err := os.WriteFile(path, pemBytes, 0600); err != nil {
		t.Fatalf("write: %v", err)
	}
	return path
}

func TestAPNsSendOK(t *testing.T) {
	keyPath := genTestKey(t)

	var gotURL, gotAuth, gotTopic string
	srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		gotURL = r.URL.Path
		gotAuth = r.Header.Get("authorization")
		gotTopic = r.Header.Get("apns-topic")
		w.WriteHeader(http.StatusOK)
	}))
	defer srv.Close()

	p, err := push.NewAPNsProvider(push.APNsConfig{
		TeamID: "TEAMID12345", KeyID: "KEYID56789",
		KeyFile: keyPath, Topic: "com.example.pulse",
		Host: srv.URL,
	})
	if err != nil {
		t.Fatalf("provider: %v", err)
	}
	if err := p.Send(context.Background(), push.Message{
		Token: "device-tok", Platform: "ios", Title: "Hi", Body: "test",
	}); err != nil {
		t.Fatalf("send: %v", err)
	}
	if !strings.Contains(gotURL, "/3/device/device-tok") {
		t.Errorf("url: %s", gotURL)
	}
	if !strings.HasPrefix(gotAuth, "bearer ") {
		t.Errorf("auth: %s", gotAuth)
	}
	if gotTopic != "com.example.pulse" {
		t.Errorf("topic: %s", gotTopic)
	}
}

func TestAPNsTokenInvalidOnGone(t *testing.T) {
	keyPath := genTestKey(t)
	srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusGone)
		_, _ = w.Write([]byte(`{"reason":"Unregistered"}`))
	}))
	defer srv.Close()
	p, err := push.NewAPNsProvider(push.APNsConfig{
		TeamID: "T", KeyID: "K", KeyFile: keyPath, Topic: "x", Host: srv.URL,
	})
	if err != nil {
		t.Fatalf("provider: %v", err)
	}
	err = p.Send(context.Background(), push.Message{Token: "dead", Platform: "ios"})
	if err == nil {
		t.Fatal("expected error on 410")
	}
	if !p.IsTokenInvalid(err) {
		t.Errorf("IsTokenInvalid should be true for 410, got %v", err)
	}
}

func TestSelectorRoutesByPlatform(t *testing.T) {
	keyPath := genTestKey(t)
	apnsCalled := false
	srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		apnsCalled = true
		w.WriteHeader(http.StatusOK)
	}))
	defer srv.Close()
	apns, _ := push.NewAPNsProvider(push.APNsConfig{
		TeamID: "T", KeyID: "K", KeyFile: keyPath, Topic: "x", Host: srv.URL,
	})
	sel := &push.Selector{APNs: apns}

	// iOS routes through APNs (works).
	if err := sel.Send(context.Background(), push.Message{Token: "t", Platform: "ios"}); err != nil {
		t.Fatalf("ios: %v", err)
	}
	if !apnsCalled {
		t.Error("apns should have been called for ios")
	}

	// Android with FCM nil errors.
	if err := sel.Send(context.Background(), push.Message{Token: "t", Platform: "android"}); err == nil {
		t.Error("android with FCM unset should error")
	}
}
