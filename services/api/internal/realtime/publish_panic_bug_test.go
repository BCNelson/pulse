package realtime

import (
	"encoding/json"
	"io"
	"log/slog"
	"sync"
	"testing"
)

// TestPublishOnClosedSubscriberDoesNotPanic documents a bug in Dispatcher.fanout:
// a `select { case c <- ev: default: }` send on a closed channel panics, even
// though the default branch makes the send non-blocking. (default fires only
// when the send would block — closed channels make the send "succeed" with a
// runtime panic instead.)
//
// In production the bug surfaces as a race window between fanout and
// Subscription.Close:
//
//  1. Goroutine A enters fanout, takes the lock, snapshots `inboxes`, and
//     releases the lock.
//  2. Goroutine B calls sub.Close, takes the lock, removes the subscriber
//     from d.subs, then `close(inbox)` while still holding the lock.
//  3. Goroutine A iterates the local `inboxes` snapshot — which still
//     references the now-closed channel — and the `case c <- ev:` panics.
//
// This test reproduces the same end state deterministically by injecting a
// closed channel directly into d.subs (bypassing the Subscription API but
// exercising the same fanout code path). With the current implementation
// the goroutine panics with "send on closed channel".
//
// Expected fix: in fanout, recover from the panic per subscriber, or hold
// the lock during send (with non-blocking semantics preserved another way),
// or never close the inbox in cancel — let the GC collect once it's
// removed from the map and any in-flight sends drop on `default`.
func TestPublishOnClosedSubscriberDoesNotPanic(t *testing.T) {
	d := &Dispatcher{
		logger: slog.New(slog.NewTextHandler(io.Discard, nil)),
		subs:   map[string]map[int64]chan<- Event{},
	}
	inbox := make(chan Event, 1)
	d.subs["topic"] = map[int64]chan<- Event{0: inbox}
	close(inbox)

	defer func() {
		if r := recover(); r != nil {
			t.Errorf("Publish panicked on closed subscriber channel: %v", r)
		}
	}()
	d.Publish(Event{Topic: "topic", Payload: json.RawMessage(`{}`)})
}

// TestPublishCloseRaceDoesNotPanic stress-tests the documented race between
// fanout (Publish) and Subscription.Close. The first test above bypasses
// the API to make the failure deterministic; this one exercises the real
// API and is expected to flake/fail under enough iterations or with
// `-race` enabled.
//
// If a future fix lands but the deterministic test stays green only
// because the timing changed, this stress test should still catch
// regressions when run with `go test -race`.
func TestPublishCloseRaceDoesNotPanic(t *testing.T) {
	d := &Dispatcher{
		logger: slog.New(slog.NewTextHandler(io.Discard, nil)),
		subs:   map[string]map[int64]chan<- Event{},
	}
	const iters = 200
	var panics sync.Map

	for i := 0; i < iters; i++ {
		sub := d.Subscribe("topic")
		var wg sync.WaitGroup
		wg.Add(2)
		go func(idx int) {
			defer wg.Done()
			defer func() {
				if r := recover(); r != nil {
					panics.Store(idx, r)
				}
			}()
			d.Publish(Event{Topic: "topic"})
		}(i)
		go func() {
			defer wg.Done()
			sub.Close()
		}()
		wg.Wait()
	}

	count := 0
	panics.Range(func(_, _ any) bool { count++; return true })
	if count > 0 {
		t.Errorf("Publish panicked %d/%d iterations during concurrent Close", count, iters)
	}
}
