package notification_test

import (
	"context"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/notification"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestInboxAndMarkReadRoundTrip(t *testing.T) {
	ctx := context.Background()
	pool := pgtest.Pool(t)

	recipient := seedPrincipal(t, pool, "recipient@example.com", "R")
	source := seedPrincipal(t, pool, "source@example.com", "S")

	// Insert two notifications directly against the schema — the fan-out
	// handler is exercised elsewhere; here we're testing Inbox/MarkRead
	// behavior in isolation.
	id1 := insertNotif(t, pool, recipient, "post", source, notification.ReasonMention, notification.UrgencyHigh)
	id2 := insertNotif(t, pool, recipient, "post", source, notification.ReasonTagSubscription, notification.UrgencyNormal)

	svc := &notification.Service{DB: pool}

	all, err := svc.Inbox(ctx, recipient, false, 50)
	if err != nil {
		t.Fatalf("inbox all: %v", err)
	}
	if len(all) != 2 {
		t.Fatalf("inbox all: got %d, want 2", len(all))
	}

	unread, err := svc.Inbox(ctx, recipient, true, 50)
	if err != nil {
		t.Fatalf("inbox unread: %v", err)
	}
	if len(unread) != 2 {
		t.Fatalf("inbox unread before MarkRead: got %d, want 2", len(unread))
	}

	if err := svc.MarkRead(ctx, recipient, []int64{id1}); err != nil {
		t.Fatalf("mark read: %v", err)
	}

	unread, err = svc.Inbox(ctx, recipient, true, 50)
	if err != nil {
		t.Fatalf("inbox unread after MarkRead: %v", err)
	}
	if len(unread) != 1 {
		t.Fatalf("inbox unread after MarkRead: got %d, want 1", len(unread))
	}
	if unread[0].ID != id2 {
		t.Errorf("remaining unread id: got %d, want %d", unread[0].ID, id2)
	}

	if err := svc.MarkAllRead(ctx, recipient); err != nil {
		t.Fatalf("mark all read: %v", err)
	}
	unread, err = svc.Inbox(ctx, recipient, true, 50)
	if err != nil {
		t.Fatalf("inbox unread after MarkAllRead: %v", err)
	}
	if len(unread) != 0 {
		t.Errorf("inbox unread after MarkAllRead: got %d, want 0", len(unread))
	}
}

func TestGetReturnsNotFoundForMissingID(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &notification.Service{DB: pool}

	_, err := svc.Get(context.Background(), 999999)
	if err == nil {
		t.Fatal("expected ErrNotFound, got nil")
	}
	if err != notification.ErrNotFound {
		t.Errorf("err: got %v, want %v", err, notification.ErrNotFound)
	}
}

func seedPrincipal(t *testing.T, pool *pgxpool.Pool, email, name string) int64 {
	t.Helper()
	id := ids.New(ids.KindUser)
	if _, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, $3, $4)
    `, id, "local://principals/"+ids.FormatID(id), name, email); err != nil {
		t.Fatalf("seed principal: %v", err)
	}
	return id
}

func insertNotif(t *testing.T, pool *pgxpool.Pool, recipient int64, sourceType string, sourceID int64, reason, urgency string) int64 {
	t.Helper()
	var id int64
	if err := pool.QueryRow(context.Background(), `
        INSERT INTO notifications (recipient_id, reason, urgency, source_type, source_id)
        VALUES ($1, $2, $3, $4, $5)
        RETURNING id
    `, recipient, reason, urgency, sourceType, sourceID).Scan(&id); err != nil {
		t.Fatalf("insert notification: %v", err)
	}
	return id
}
