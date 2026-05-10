// Package notification owns the inbox table, the fan-out worker, and the
// tag-typed-field registry that decides who hears about which event.
//
// Architecture: every relevant write (post create, comment create, task
// create/assign, message create) enqueues a `notification.fanout` job in
// the same transaction. This package's worker handler resolves recipients
// — by tag-typed-field rules, tag subscriptions, per-tag urgency overrides
// — writes notifications rows, and emits `notif.<principal_id>` NOTIFY
// envelopes that the realtime dispatcher fans out to subscribed clients.
//
// Decoupling enqueue from delivery means a hot post in a widely-subscribed
// tag doesn't block the request path on N inserts; the worker can also be
// scaled horizontally if v1 grows past one instance.
package notification

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"time"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/realtime"
)

// Reason values match the CHECK constraint on notifications.reason.
const (
	ReasonAssignment      = "assignment"
	ReasonMention         = "mention"
	ReasonWatcher         = "watcher"
	ReasonTagSubscription = "tag_subscription"
	ReasonDM              = "dm"
)

// Urgency values match the CHECK constraint on notifications.urgency.
const (
	UrgencyHigh   = "high"
	UrgencyNormal = "normal"
	UrgencyLow    = "low"
)

// FanoutPayload is the JSON encoded into jobs.payload for a fan-out job.
// Producers fill it in inside the same transaction as the source write.
type FanoutPayload struct {
	SourceType  string  `json:"source_type"`            // 'post','comment','task','message'
	SourceID    string  `json:"source_id"`              // uuid of the source
	ActorID     string  `json:"actor_id"`               // principal who triggered the event
	Event       string  `json:"event"`                  // 'created','assigned','mentioned','sent', etc.
	RecipientID *string `json:"recipient_id,omitempty"` // optional: pre-resolved single recipient
}

// Querier matches *pgxpool.Pool and pgx.Tx.
type Querier interface {
	Exec(ctx context.Context, sql string, args ...any) (pgconn.CommandTag, error)
}

type Service struct {
	DB *pgxpool.Pool
}

// Recipient is the resolved target of a notification — recipient,
// reason, urgency, and the originating tag for context.
type Recipient struct {
	PrincipalID uuid.UUID
	Reason      string
	Urgency     string
	SourceTagID *uuid.UUID
}

// Inbox returns the recipient's notifications, newest first. unreadOnly
// constrains to read_at IS NULL; limit caps the page.
type Notification struct {
	ID          uuid.UUID
	RecipientID uuid.UUID
	Reason      string
	Urgency     string
	SourceType  string
	SourceID    uuid.UUID
	SourceTagID *uuid.UUID
	ReadAt      *time.Time
	CreatedAt   time.Time
}

func (s *Service) Inbox(ctx context.Context, recipient uuid.UUID, unreadOnly bool, limit int) ([]*Notification, error) {
	if limit <= 0 || limit > 200 {
		limit = 50
	}
	rows, err := s.DB.Query(ctx, `
        SELECT id, recipient_id, reason, urgency, source_type, source_id,
               source_tag_id, read_at, created_at
        FROM notifications
        WHERE recipient_id = $1
          AND ($2::BOOLEAN IS FALSE OR read_at IS NULL)
        ORDER BY created_at DESC
        LIMIT $3
    `, recipient, unreadOnly, limit)
	if err != nil {
		return nil, fmt.Errorf("inbox: %w", err)
	}
	defer rows.Close()
	out := []*Notification{}
	for rows.Next() {
		var n Notification
		if err := rows.Scan(&n.ID, &n.RecipientID, &n.Reason, &n.Urgency,
			&n.SourceType, &n.SourceID, &n.SourceTagID, &n.ReadAt, &n.CreatedAt); err != nil {
			return nil, err
		}
		out = append(out, &n)
	}
	return out, rows.Err()
}

// MarkRead sets read_at on the named notifications belonging to recipient.
func (s *Service) MarkRead(ctx context.Context, recipient uuid.UUID, ids []uuid.UUID) error {
	if len(ids) == 0 {
		return nil
	}
	_, err := s.DB.Exec(ctx, `
        UPDATE notifications
           SET read_at = now()
         WHERE recipient_id = $1
           AND id = ANY($2::UUID[])
           AND read_at IS NULL
    `, recipient, ids)
	return err
}

// MarkAllRead marks every unread notification as read for the recipient.
func (s *Service) MarkAllRead(ctx context.Context, recipient uuid.UUID) error {
	_, err := s.DB.Exec(ctx, `
        UPDATE notifications SET read_at = now()
         WHERE recipient_id = $1 AND read_at IS NULL
    `, recipient)
	return err
}

// Get returns one notification or ErrNotFound. Used by the realtime
// dispatcher to load a row before forwarding to a subscription.
func (s *Service) Get(ctx context.Context, id uuid.UUID) (*Notification, error) {
	var n Notification
	row := s.DB.QueryRow(ctx, `
        SELECT id, recipient_id, reason, urgency, source_type, source_id,
               source_tag_id, read_at, created_at
        FROM notifications WHERE id = $1
    `, id)
	if err := row.Scan(&n.ID, &n.RecipientID, &n.Reason, &n.Urgency,
		&n.SourceType, &n.SourceID, &n.SourceTagID, &n.ReadAt, &n.CreatedAt); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, ErrNotFound
		}
		return nil, err
	}
	return &n, nil
}

var ErrNotFound = errors.New("notification: not found")

// Handler is the registered worker handler for "notification.fanout"
// jobs. Wire it into the Registry at startup:
//
//	registry.Register("notification.fanout", svc.Handler)
func (s *Service) Handler(ctx context.Context, raw json.RawMessage) error {
	var p FanoutPayload
	if err := json.Unmarshal(raw, &p); err != nil {
		return fmt.Errorf("unmarshal fanout payload: %w", err)
	}
	srcID, err := uuid.Parse(p.SourceID)
	if err != nil {
		return fmt.Errorf("source_id: %w", err)
	}
	actorID, err := uuid.Parse(p.ActorID)
	if err != nil {
		return fmt.Errorf("actor_id: %w", err)
	}

	recipients, err := s.resolveRecipients(ctx, p, srcID, actorID)
	if err != nil {
		return fmt.Errorf("resolve recipients: %w", err)
	}

	return s.writeAndNotify(ctx, p.SourceType, srcID, recipients)
}

// resolveRecipients dispatches to the source-type-specific resolver. Add
// new sources here; the rest of the fan-out is generic.
func (s *Service) resolveRecipients(ctx context.Context, p FanoutPayload, srcID, actorID uuid.UUID) ([]Recipient, error) {
	switch p.SourceType {
	case "task":
		return s.taskRecipients(ctx, p, srcID, actorID)
	case "post":
		return s.postRecipients(ctx, srcID, actorID)
	case "comment":
		return s.commentRecipients(ctx, srcID, actorID)
	case "message":
		return s.messageRecipients(ctx, srcID, actorID)
	default:
		return nil, fmt.Errorf("unknown source_type %q", p.SourceType)
	}
}

// taskRecipients enumerates assignees + watchers + tag subscribers for a
// task. If RecipientID is set on an "assigned" event, only that principal
// is notified (the assigned-to person, with reason=assignment).
func (s *Service) taskRecipients(ctx context.Context, p FanoutPayload, taskID, actorID uuid.UUID) ([]Recipient, error) {
	if p.Event == "assigned" && p.RecipientID != nil {
		recID, err := uuid.Parse(*p.RecipientID)
		if err != nil {
			return nil, fmt.Errorf("recipient_id: %w", err)
		}
		if recID == actorID {
			return nil, nil
		}
		urgency, tagID := s.subscriptionDecision(ctx, recID, "task", taskID, ReasonAssignment)
		if urgency == "" {
			urgency = UrgencyHigh // assignments default to high
		}
		return []Recipient{{
			PrincipalID: recID, Reason: ReasonAssignment, Urgency: urgency, SourceTagID: tagID,
		}}, nil
	}

	// Created or otherwise: notify all assignees (reason=assignment), watchers
	// (reason=watcher), and tag subscribers (reason=tag_subscription).
	assignees, err := s.principalsFromJoin(ctx, "task_assignees", "task_id", "principal_id", taskID)
	if err != nil {
		return nil, err
	}
	watchers, err := s.principalsFromJoin(ctx, "task_watchers", "task_id", "principal_id", taskID)
	if err != nil {
		return nil, err
	}
	subscribers, err := s.tagSubscribersForTaskOrPost(ctx, "task_tags", "task_id", taskID)
	if err != nil {
		return nil, err
	}

	out := []Recipient{}
	seen := map[uuid.UUID]struct{}{actorID: {}}
	add := func(p uuid.UUID, reason string, defaultUrgency string) {
		if _, dup := seen[p]; dup {
			return
		}
		urgency, tagID := s.subscriptionDecision(ctx, p, "task", taskID, reason)
		if urgency == "" {
			urgency = defaultUrgency
		}
		out = append(out, Recipient{PrincipalID: p, Reason: reason, Urgency: urgency, SourceTagID: tagID})
		seen[p] = struct{}{}
	}
	for _, p := range assignees {
		add(p, ReasonAssignment, UrgencyHigh)
	}
	for _, p := range watchers {
		add(p, ReasonWatcher, UrgencyNormal)
	}
	for _, ts := range subscribers {
		if _, dup := seen[ts.PrincipalID]; dup {
			continue
		}
		if ts.Urgency == "mute" {
			seen[ts.PrincipalID] = struct{}{}
			continue
		}
		out = append(out, Recipient{
			PrincipalID: ts.PrincipalID,
			Reason:      ReasonTagSubscription,
			Urgency:     ts.Urgency,
			SourceTagID: &ts.TagID,
		})
		seen[ts.PrincipalID] = struct{}{}
	}
	return out, nil
}

// postRecipients = mentions + tag subscribers.
func (s *Service) postRecipients(ctx context.Context, postID, actorID uuid.UUID) ([]Recipient, error) {
	mentions, err := s.principalsFromJoin(ctx, "post_mentions", "post_id", "principal_id", postID)
	if err != nil {
		return nil, err
	}
	subscribers, err := s.tagSubscribersForTaskOrPost(ctx, "post_tags", "post_id", postID)
	if err != nil {
		return nil, err
	}

	out := []Recipient{}
	seen := map[uuid.UUID]struct{}{actorID: {}}
	for _, p := range mentions {
		if _, dup := seen[p]; dup {
			continue
		}
		urgency, tagID := s.subscriptionDecision(ctx, p, "post", postID, ReasonMention)
		if urgency == "" {
			urgency = UrgencyHigh
		}
		out = append(out, Recipient{PrincipalID: p, Reason: ReasonMention, Urgency: urgency, SourceTagID: tagID})
		seen[p] = struct{}{}
	}
	for _, ts := range subscribers {
		if _, dup := seen[ts.PrincipalID]; dup {
			continue
		}
		if ts.Urgency == "mute" {
			seen[ts.PrincipalID] = struct{}{}
			continue
		}
		out = append(out, Recipient{
			PrincipalID: ts.PrincipalID,
			Reason:      ReasonTagSubscription,
			Urgency:     ts.Urgency,
			SourceTagID: &ts.TagID,
		})
		seen[ts.PrincipalID] = struct{}{}
	}
	return out, nil
}

// commentRecipients = comment mentions + parent post tag subscribers.
func (s *Service) commentRecipients(ctx context.Context, commentID, actorID uuid.UUID) ([]Recipient, error) {
	var postID uuid.UUID
	if err := s.DB.QueryRow(ctx,
		`SELECT post_id FROM comments WHERE id = $1`, commentID).Scan(&postID); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, nil
		}
		return nil, err
	}
	mentions, err := s.principalsFromJoin(ctx, "comment_mentions", "comment_id", "principal_id", commentID)
	if err != nil {
		return nil, err
	}
	subscribers, err := s.tagSubscribersForTaskOrPost(ctx, "post_tags", "post_id", postID)
	if err != nil {
		return nil, err
	}

	out := []Recipient{}
	seen := map[uuid.UUID]struct{}{actorID: {}}
	for _, p := range mentions {
		if _, dup := seen[p]; dup {
			continue
		}
		urgency, _ := s.subscriptionDecision(ctx, p, "comment", commentID, ReasonMention)
		if urgency == "" {
			urgency = UrgencyHigh
		}
		out = append(out, Recipient{PrincipalID: p, Reason: ReasonMention, Urgency: urgency})
		seen[p] = struct{}{}
	}
	for _, ts := range subscribers {
		if _, dup := seen[ts.PrincipalID]; dup {
			continue
		}
		if ts.Urgency == "mute" {
			seen[ts.PrincipalID] = struct{}{}
			continue
		}
		out = append(out, Recipient{
			PrincipalID: ts.PrincipalID,
			Reason:      ReasonTagSubscription,
			Urgency:     ts.Urgency,
			SourceTagID: &ts.TagID,
		})
		seen[ts.PrincipalID] = struct{}{}
	}
	return out, nil
}

// messageRecipients = DM participants (reason=dm) for a DM room, or tag
// subscribers (reason=tag_subscription) for a team room.
func (s *Service) messageRecipients(ctx context.Context, messageID, actorID uuid.UUID) ([]Recipient, error) {
	var roomID uuid.UUID
	var isDM bool
	if err := s.DB.QueryRow(ctx, `
        SELECT cr.id, cr.is_dm
        FROM messages m JOIN chat_rooms cr ON cr.id = m.chat_room_id
        WHERE m.id = $1
    `, messageID).Scan(&roomID, &isDM); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, nil
		}
		return nil, err
	}

	if isDM {
		rows, err := s.DB.Query(ctx, `
            SELECT principal_id FROM chat_room_participants
            WHERE chat_room_id = $1 AND principal_id <> $2 AND left_at IS NULL
        `, roomID, actorID)
		if err != nil {
			return nil, err
		}
		defer rows.Close()
		out := []Recipient{}
		for rows.Next() {
			var p uuid.UUID
			if err := rows.Scan(&p); err != nil {
				return nil, err
			}
			out = append(out, Recipient{PrincipalID: p, Reason: ReasonDM, Urgency: UrgencyHigh})
		}
		return out, rows.Err()
	}

	subscribers, err := s.tagSubscribersForTaskOrPost(ctx, "chat_room_tags", "chat_room_id", roomID)
	if err != nil {
		return nil, err
	}
	out := []Recipient{}
	seen := map[uuid.UUID]struct{}{actorID: {}}
	for _, ts := range subscribers {
		if _, dup := seen[ts.PrincipalID]; dup {
			continue
		}
		if ts.Urgency == "mute" {
			seen[ts.PrincipalID] = struct{}{}
			continue
		}
		out = append(out, Recipient{
			PrincipalID: ts.PrincipalID,
			Reason:      ReasonTagSubscription,
			Urgency:     ts.Urgency,
			SourceTagID: &ts.TagID,
		})
		seen[ts.PrincipalID] = struct{}{}
	}
	return out, nil
}

// principalsFromJoin reads principal ids from a join table (assignees,
// watchers, mentions, etc.). Generic over the join schema as long as the
// columns are named.
func (s *Service) principalsFromJoin(ctx context.Context, table, sourceCol, principalCol string, sourceID uuid.UUID) ([]uuid.UUID, error) {
	// Table/column names are constants in this package — never user input.
	// Direct interpolation is intentional and safe here.
	q := fmt.Sprintf(`SELECT %s FROM %s WHERE %s = $1`, principalCol, table, sourceCol)
	rows, err := s.DB.Query(ctx, q, sourceID)
	if err != nil {
		return nil, fmt.Errorf("query %s: %w", table, err)
	}
	defer rows.Close()
	out := []uuid.UUID{}
	for rows.Next() {
		var p uuid.UUID
		if err := rows.Scan(&p); err != nil {
			return nil, err
		}
		out = append(out, p)
	}
	return out, rows.Err()
}

type tagSubscriber struct {
	PrincipalID uuid.UUID
	TagID       uuid.UUID
	Urgency     string
	ReasonOK    bool
}

// tagSubscribersForTaskOrPost finds tag subscribers (cascading) of any tag
// attached to the source. Returns one row per (principal, source-tag); the
// caller dedupes.
func (s *Service) tagSubscribersForTaskOrPost(ctx context.Context, tagJoinTable, sourceCol string, sourceID uuid.UUID) ([]tagSubscriber, error) {
	q := fmt.Sprintf(`
        SELECT DISTINCT ON (s.principal_id)
               s.principal_id, j.tag_id, s.urgency, s.reason_filter
        FROM %s j
        JOIN tag_closure c ON c.descendant_id = j.tag_id
        JOIN subscriptions s ON s.tag_id = c.ancestor_id
        WHERE j.%s = $1
          AND (c.depth = 0 OR s.cascade = TRUE)
        ORDER BY s.principal_id, c.depth ASC
    `, tagJoinTable, sourceCol)
	rows, err := s.DB.Query(ctx, q, sourceID)
	if err != nil {
		return nil, fmt.Errorf("query subscribers: %w", err)
	}
	defer rows.Close()
	out := []tagSubscriber{}
	for rows.Next() {
		var ts tagSubscriber
		var filters []string
		if err := rows.Scan(&ts.PrincipalID, &ts.TagID, &ts.Urgency, &filters); err != nil {
			return nil, err
		}
		// reason_filter empty = all reasons; else must contain
		// 'tag_subscription'. We're routing tag subscribers, so that's
		// the relevant reason.
		ts.ReasonOK = len(filters) == 0 || contains(filters, ReasonTagSubscription)
		if !ts.ReasonOK {
			continue
		}
		out = append(out, ts)
	}
	return out, rows.Err()
}

// subscriptionDecision looks up the recipient's strongest applicable
// subscription urgency for the source's tags, and returns ("", nil) if
// they have no subscription that affects this notification (caller
// applies its own default urgency).
//
// The reason argument is checked against reason_filter; an empty filter
// matches all reasons.
func (s *Service) subscriptionDecision(ctx context.Context, principal uuid.UUID, sourceType string, sourceID uuid.UUID, reason string) (string, *uuid.UUID) {
	var joinTable, sourceCol string
	switch sourceType {
	case "task":
		joinTable, sourceCol = "task_tags", "task_id"
	case "post":
		joinTable, sourceCol = "post_tags", "post_id"
	case "comment":
		// Comments inherit from parent post.
		var postID uuid.UUID
		if err := s.DB.QueryRow(ctx,
			`SELECT post_id FROM comments WHERE id = $1`, sourceID).Scan(&postID); err != nil {
			return "", nil
		}
		return s.subscriptionDecision(ctx, principal, "post", postID, reason)
	case "message":
		joinTable, sourceCol = "chat_room_tags", "chat_room_id"
	default:
		return "", nil
	}

	q := fmt.Sprintf(`
        SELECT s.urgency, s.reason_filter, j.tag_id
        FROM %s j
        JOIN tag_closure c ON c.descendant_id = j.tag_id
        JOIN subscriptions s ON s.tag_id = c.ancestor_id
        WHERE j.%s = $1
          AND s.principal_id = $2
          AND (c.depth = 0 OR s.cascade = TRUE)
        ORDER BY c.depth ASC
        LIMIT 1
    `, joinTable, sourceCol)

	var urgency string
	var filters []string
	var tagID uuid.UUID
	if err := s.DB.QueryRow(ctx, q, sourceID, principal).Scan(&urgency, &filters, &tagID); err != nil {
		return "", nil
	}
	if len(filters) > 0 && !contains(filters, reason) {
		return "", nil
	}
	return urgency, &tagID
}

// writeAndNotify inserts notifications rows and emits one
// notif.<principal_id> NOTIFY per recipient. Insert and NOTIFY happen in
// the same transaction so a recipient that observes the NOTIFY can read
// the row.
func (s *Service) writeAndNotify(ctx context.Context, sourceType string, sourceID uuid.UUID, recipients []Recipient) error {
	if len(recipients) == 0 {
		return nil
	}
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		for _, r := range recipients {
			var notifID uuid.UUID
			if err := tx.QueryRow(ctx, `
                INSERT INTO notifications (recipient_id, reason, urgency, source_type, source_id, source_tag_id)
                VALUES ($1, $2, $3, $4, $5, $6)
                RETURNING id
            `, r.PrincipalID, r.Reason, r.Urgency, sourceType, sourceID, r.SourceTagID).Scan(&notifID); err != nil {
				return fmt.Errorf("insert notification: %w", err)
			}
			payload, _ := json.Marshal(map[string]any{
				"notification_id": notifID.String(),
				"reason":          r.Reason,
				"urgency":         r.Urgency,
				"source_type":     sourceType,
				"source_id":       sourceID.String(),
			})
			topic := "notif." + r.PrincipalID.String()
			notifySQL, args := realtime.NotifySQL(topic, payload)
			if _, err := tx.Exec(ctx, notifySQL, args...); err != nil {
				return fmt.Errorf("pg_notify: %w", err)
			}
		}
		return nil
	})
}

func (s *Service) runInTx(ctx context.Context, fn func(pgx.Tx) error) error {
	tx, err := s.DB.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return fmt.Errorf("begin: %w", err)
	}
	defer func() { _ = tx.Rollback(ctx) }()
	if err := fn(tx); err != nil {
		return err
	}
	return tx.Commit(ctx)
}

func contains(haystack []string, needle string) bool {
	for _, h := range haystack {
		if h == needle {
			return true
		}
	}
	return false
}
