// Package realtime owns the LISTEN connection and the in-process topic
// broadcaster that fans pg_notify events into GraphQL subscriptions.
//
// Design choice (M3): every notify writer publishes to a single Postgres
// channel ("pulse_events") with a JSON envelope `{topic, data}`. The
// dispatcher LISTENs on that channel at boot and routes by topic in-
// process. This sidesteps the dynamic-LISTEN dance that per-topic
// channels would require, at the cost of every API instance receiving
// every workspace event. v1 is single-tenant; total event rate is small.
//
// Scale boundary (per architecture): comfortable in the low thousands of
// concurrent subscribers per database. Tens of thousands triggers a
// move to logical replication into a dedicated fan-out service — that's
// the v2 escape hatch.
package realtime

import (
	"context"
	"encoding/json"
	"fmt"
	"log/slog"
	"sync"
	"time"

	"github.com/jackc/pgx/v5"
)

// Channel is the single Postgres channel everyone publishes to. Topics
// are an in-band string ("chat.room.<id>", "tag.<id>.structure", ...).
const Channel = "pulse_events"

// Event is what a subscriber receives. Topic identifies the source;
// Payload is opaque JSON the publisher chose.
type Event struct {
	Topic   string          `json:"topic"`
	Payload json.RawMessage `json:"data"`
}

// Subscription is a per-subscriber inbox. The Ch channel is buffered;
// slow consumers see drops. Always call Close to release resources.
type Subscription struct {
	Ch     <-chan Event
	cancel func()
}

// Close detaches the subscription from the dispatcher.
func (s *Subscription) Close() { s.cancel() }

// Dispatcher owns the LISTEN connection and routes events to in-process
// subscribers. One per API instance.
type Dispatcher struct {
	conn   *pgx.Conn
	logger *slog.Logger

	mu        sync.Mutex
	subs      map[string]map[int64]chan<- Event // topic → id → inbox
	nextSubID int64
}

// New opens a fresh pgx connection (separate from the request pool —
// LISTEN holds a connection for the connection's lifetime), runs LISTEN
// pulse_events, and starts the dispatch goroutine. Cancel ctx to stop.
func New(ctx context.Context, dsn string, logger *slog.Logger) (*Dispatcher, error) {
	conn, err := pgx.Connect(ctx, dsn)
	if err != nil {
		return nil, fmt.Errorf("realtime connect: %w", err)
	}
	if _, err := conn.Exec(ctx, `LISTEN `+Channel); err != nil {
		_ = conn.Close(ctx)
		return nil, fmt.Errorf("realtime LISTEN: %w", err)
	}
	d := &Dispatcher{
		conn:   conn,
		logger: logger,
		subs:   map[string]map[int64]chan<- Event{},
	}
	go d.run(ctx)
	return d, nil
}

// Subscribe registers an inbox for the given topic. Returns a
// Subscription whose Ch channel receives matching events. Close the
// subscription to free server-side state.
func (d *Dispatcher) Subscribe(topic string) *Subscription {
	d.mu.Lock()
	defer d.mu.Unlock()

	id := d.nextSubID
	d.nextSubID++
	inbox := make(chan Event, 16)
	if d.subs[topic] == nil {
		d.subs[topic] = map[int64]chan<- Event{}
	}
	d.subs[topic][id] = inbox

	sub := &Subscription{
		Ch: inbox,
		cancel: func() {
			d.mu.Lock()
			defer d.mu.Unlock()
			if m, ok := d.subs[topic]; ok {
				delete(m, id)
				if len(m) == 0 {
					delete(d.subs, topic)
				}
			}
			close(inbox)
		},
	}
	return sub
}

// Publish lets in-process tests inject an event without going through
// Postgres. Production code should always go through pg_notify so events
// flow across instances.
func (d *Dispatcher) Publish(ev Event) {
	d.fanout(ev)
}

// run is the dispatch loop. Reads notifications, parses the envelope,
// and fans out by topic.
func (d *Dispatcher) run(ctx context.Context) {
	for {
		notif, err := d.conn.WaitForNotification(ctx)
		if err != nil {
			if ctx.Err() != nil {
				_ = d.conn.Close(context.Background())
				return
			}
			d.logger.Error("realtime: wait for notification", "err", err)
			// Brief backoff so a flapping network doesn't spin.
			time.Sleep(time.Second)
			continue
		}
		if notif.Channel != Channel {
			continue
		}
		var ev Event
		if err := json.Unmarshal([]byte(notif.Payload), &ev); err != nil {
			d.logger.Warn("realtime: malformed payload", "payload", notif.Payload, "err", err)
			continue
		}
		d.fanout(ev)
	}
}

func (d *Dispatcher) fanout(ev Event) {
	d.mu.Lock()
	inboxes := make([]chan<- Event, 0, len(d.subs[ev.Topic]))
	for _, c := range d.subs[ev.Topic] {
		inboxes = append(inboxes, c)
	}
	d.mu.Unlock()

	for _, c := range inboxes {
		select {
		case c <- ev:
		default:
			// Drop on slow consumer rather than blocking the dispatch
			// loop. The architecture flags this as acceptable; clients
			// resync on reconnect.
			d.logger.Debug("realtime: drop on slow subscriber", "topic", ev.Topic)
		}
	}
}

// PublishSQL is the SQL writers should call to emit an event. Returns the
// SQL fragment plus the (channel, payload) args; embed in transactions
// alongside the underlying write so events are atomic with state.
//
// Example use inside a chat.SendMessage transaction:
//
//	sql, args := realtime.NotifySQL("chat.room."+roomID, payload)
//	tx.Exec(ctx, sql, args...)
//
// Producing a SQL helper (rather than calling pg_notify with multiple
// arguments) keeps every publisher consistent.
func NotifySQL(topic string, payload json.RawMessage) (string, []any) {
	envelope := Event{Topic: topic, Payload: payload}
	bs, _ := json.Marshal(envelope)
	return `SELECT pg_notify($1, $2)`, []any{Channel, string(bs)}
}
