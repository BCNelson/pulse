package push_test

import (
	"context"
	"sync"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/push"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// recordingProvider captures every Send call so tests can assert.
type recordingProvider struct {
	mu   sync.Mutex
	sent []push.Message
}

func (p *recordingProvider) Send(_ context.Context, msg push.Message) error {
	p.mu.Lock()
	defer p.mu.Unlock()
	p.sent = append(p.sent, msg)
	return nil
}

func (p *recordingProvider) Count() int {
	p.mu.Lock()
	defer p.mu.Unlock()
	return len(p.sent)
}

func TestRegisterAndDispatch(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	// Seed a principal.
	principalID := ids.New(ids.KindUser)
	if _, err := pool.Exec(ctx, `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, 'Alice', 'a@example.com')
    `, principalID, "local://principals/"+ids.FormatID(principalID)); err != nil {
		t.Fatalf("seed: %v", err)
	}

	prov := &recordingProvider{}
	svc := &push.Service{DB: pool, Provider: prov}

	// Register two devices, then dispatch to a fake notification.
	if err := svc.Register(ctx, principalID, "tok-ios-1", "ios"); err != nil {
		t.Fatalf("register ios: %v", err)
	}
	if err := svc.Register(ctx, principalID, "tok-and-1", "android"); err != nil {
		t.Fatalf("register android: %v", err)
	}

	// Insert a notification row to dispatch against.
	notifID := ids.New(ids.KindUser)
	if _, err := pool.Exec(ctx, `
        INSERT INTO notifications (id, recipient_id, reason, urgency, source_type, source_id)
        VALUES ($1, $2, 'mention', 'high', 'post', $3)
    `, notifID, principalID, ids.New(ids.KindUser)); err != nil {
		t.Fatalf("insert notif: %v", err)
	}
	if err := svc.Dispatch(ctx, notifID, "Title", "Body"); err != nil {
		t.Fatalf("dispatch: %v", err)
	}
	if prov.Count() != 2 {
		t.Errorf("expected 2 sends, got %d", prov.Count())
	}

	// Re-register the ios token (idempotent — no new row).
	if err := svc.Register(ctx, principalID, "tok-ios-1", "ios"); err != nil {
		t.Fatalf("re-register: %v", err)
	}
	var count int
	if err := pool.QueryRow(ctx,
		`SELECT count(*) FROM device_tokens WHERE principal_id = $1`, principalID).
		Scan(&count); err != nil {
		t.Fatalf("count: %v", err)
	}
	if count != 2 {
		t.Errorf("re-register should be idempotent, got %d rows", count)
	}

	// Unregister.
	if err := svc.Unregister(ctx, principalID, "tok-ios-1"); err != nil {
		t.Fatalf("unregister: %v", err)
	}
	if err := pool.QueryRow(ctx,
		`SELECT count(*) FROM device_tokens WHERE principal_id = $1`, principalID).
		Scan(&count); err != nil {
		t.Fatalf("count2: %v", err)
	}
	if count != 1 {
		t.Errorf("after unregister: got %d rows want 1", count)
	}
}

func TestRegisterRejectsBadPlatform(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &push.Service{DB: pool}
	if err := svc.Register(context.Background(), ids.New(ids.KindUser), "tok", "windows"); err == nil {
		t.Error("expected platform error")
	}
}
