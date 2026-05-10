package realtime_test

import (
	"context"
	"encoding/json"
	"log/slog"
	"os"
	"testing"
	"time"

	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/realtime"
)

func newDispatcher(t *testing.T) (*realtime.Dispatcher, string, context.CancelFunc) {
	t.Helper()
	dsn := pgtest.DSN(t)
	ctx, cancel := context.WithCancel(context.Background())
	logger := slog.New(slog.NewTextHandler(os.Stderr, nil))
	d, err := realtime.New(ctx, dsn, logger)
	if err != nil {
		cancel()
		t.Fatalf("realtime.New: %v", err)
	}
	t.Cleanup(cancel)
	return d, dsn, cancel
}

func TestSubscribeReceivesPublish(t *testing.T) {
	d, _, _ := newDispatcher(t)

	sub := d.Subscribe("test.topic")
	defer sub.Close()

	d.Publish(realtime.Event{
		Topic:   "test.topic",
		Payload: json.RawMessage(`{"hello":"world"}`),
	})

	select {
	case ev := <-sub.Ch:
		if ev.Topic != "test.topic" {
			t.Errorf("topic: got %q", ev.Topic)
		}
	case <-time.After(2 * time.Second):
		t.Fatal("did not receive event in time")
	}
}

func TestUnsubscribedTopicNotDelivered(t *testing.T) {
	d, _, _ := newDispatcher(t)

	sub := d.Subscribe("test.topic.a")
	defer sub.Close()

	// Publish on a different topic — sub should not see it.
	d.Publish(realtime.Event{Topic: "test.topic.b", Payload: json.RawMessage(`{}`)})

	select {
	case ev := <-sub.Ch:
		t.Errorf("received unexpected event: %+v", ev)
	case <-time.After(100 * time.Millisecond):
		// Good — no event arrived.
	}
}

func TestNotifyRoundTripThroughPostgres(t *testing.T) {
	d, dsn, _ := newDispatcher(t)

	sub := d.Subscribe("rt.smoke")
	defer sub.Close()

	// Publish via Postgres — exercises the full LISTEN/NOTIFY path.
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	sql, args := realtime.NotifySQL("rt.smoke", json.RawMessage(`{"x":42}`))

	// Open a separate connection for the NOTIFY since the dispatcher owns
	// the LISTEN side.
	publishConn := mustOpenConn(t, ctx, dsn)
	defer func() { _ = publishConn.Close(ctx) }()
	if _, err := publishConn.Exec(ctx, sql, args...); err != nil {
		t.Fatalf("publish: %v", err)
	}

	select {
	case ev := <-sub.Ch:
		if ev.Topic != "rt.smoke" {
			t.Errorf("topic: %q", ev.Topic)
		}
		var got struct{ X int }
		if err := json.Unmarshal(ev.Payload, &got); err != nil {
			t.Fatalf("unmarshal: %v", err)
		}
		if got.X != 42 {
			t.Errorf("payload x: %d", got.X)
		}
	case <-time.After(3 * time.Second):
		t.Fatal("did not receive NOTIFY-driven event")
	}
}
