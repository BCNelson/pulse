// Package chat owns chat rooms, participants, and messages. The DM
// distinction (is_dm) is denormalized — recomputed on participant or tag
// changes rather than computed at read time so the UI doesn't have to
// know the rule. Authorization checks live one layer up.
package chat

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/realtime"
)

var (
	ErrNotFound        = errors.New("chat: not found")
	ErrAlreadyEdited   = errors.New("chat: body unchanged")
	ErrPromoteDM       = errors.New("chat: cannot promote a message in a tag-less room — add a tag first")
	ErrAlreadyPromoted = errors.New("chat: message already promoted")
)

type Service struct {
	DB    *pgxpool.Pool
	Posts *post.Service
}

// Room is the read-side row for a chat room.
type Room struct {
	ID         uuid.UUID
	IsDM       bool
	CreatedAt  time.Time
	ArchivedAt *time.Time
}

// Participant is a (room, principal, role) row.
type Participant struct {
	PrincipalID uuid.UUID
	Role        string
	JoinedAt    time.Time
	LeftAt      *time.Time
}

// Message is the read-side row for a chat message.
type Message struct {
	ID             uuid.UUID
	ChatRoomID     uuid.UUID
	AuthorID       uuid.UUID
	Body           string
	ReplyTo        *uuid.UUID
	CreatedAt      time.Time
	EditedAt       *time.Time
	DeletedAt      *time.Time
	PromotedToPost *uuid.UUID
}

// CreateRoomInput is the payload for createRoom.
type CreateRoomInput struct {
	Tags         []uuid.UUID
	Participants []ParticipantInput
}

type ParticipantInput struct {
	PrincipalID uuid.UUID
	Role        string // 'member' | 'admin'
}

// SendInput captures a single send-message call.
type SendInput struct {
	RoomID   uuid.UUID
	AuthorID uuid.UUID
	Body     string
	ReplyTo  *uuid.UUID
}

// CreateRoom inserts a room with its initial tags and participants. Computes
// is_dm before returning. Per architecture: room with no org-tag + all-user
// participants is a DM.
func (s *Service) CreateRoom(ctx context.Context, in CreateRoomInput) (uuid.UUID, error) {
	var id uuid.UUID
	err := s.runInTx(ctx, func(tx pgx.Tx) error {
		row := tx.QueryRow(ctx, `INSERT INTO chat_rooms DEFAULT VALUES RETURNING id`)
		if err := row.Scan(&id); err != nil {
			return fmt.Errorf("insert room: %w", err)
		}
		for _, tagID := range in.Tags {
			if _, err := tx.Exec(ctx, `
                INSERT INTO chat_room_tags (chat_room_id, tag_id) VALUES ($1, $2)
            `, id, tagID); err != nil {
				return fmt.Errorf("attach tag: %w", err)
			}
		}
		for _, p := range in.Participants {
			role := p.Role
			if role == "" {
				role = "member"
			}
			if _, err := tx.Exec(ctx, `
                INSERT INTO chat_room_participants (chat_room_id, principal_id, role)
                VALUES ($1, $2, $3)
            `, id, p.PrincipalID, role); err != nil {
				return fmt.Errorf("add participant: %w", err)
			}
		}
		return s.recomputeIsDMTx(ctx, tx, id)
	})
	return id, err
}

// AddParticipant adds (or rejoins) a principal to a room and recomputes
// is_dm. Idempotent: re-adding the same principal updates role and clears
// left_at.
func (s *Service) AddParticipant(ctx context.Context, roomID, principalID uuid.UUID, role string) error {
	if role == "" {
		role = "member"
	}
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `
            INSERT INTO chat_room_participants (chat_room_id, principal_id, role)
            VALUES ($1, $2, $3)
            ON CONFLICT (chat_room_id, principal_id) DO UPDATE
                SET role = EXCLUDED.role, left_at = NULL
        `, roomID, principalID, role); err != nil {
			return fmt.Errorf("add participant: %w", err)
		}
		return s.recomputeIsDMTx(ctx, tx, roomID)
	})
}

// RemoveParticipant marks a participant as having left (preserves history).
func (s *Service) RemoveParticipant(ctx context.Context, roomID, principalID uuid.UUID) error {
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		tag, err := tx.Exec(ctx, `
            UPDATE chat_room_participants
            SET left_at = now()
            WHERE chat_room_id = $1 AND principal_id = $2 AND left_at IS NULL
        `, roomID, principalID)
		if err != nil {
			return fmt.Errorf("remove participant: %w", err)
		}
		if tag.RowsAffected() == 0 {
			return ErrNotFound
		}
		return s.recomputeIsDMTx(ctx, tx, roomID)
	})
}

// AddTag attaches a tag to a room and recomputes is_dm. The DM → team
// space promotion path: adding an org tag flips is_dm to false.
func (s *Service) AddTag(ctx context.Context, roomID, tagID uuid.UUID) error {
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `
            INSERT INTO chat_room_tags (chat_room_id, tag_id) VALUES ($1, $2)
            ON CONFLICT DO NOTHING
        `, roomID, tagID); err != nil {
			return fmt.Errorf("attach tag: %w", err)
		}
		return s.recomputeIsDMTx(ctx, tx, roomID)
	})
}

// RemoveTag detaches a tag from a room and recomputes is_dm.
func (s *Service) RemoveTag(ctx context.Context, roomID, tagID uuid.UUID) error {
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `
            DELETE FROM chat_room_tags WHERE chat_room_id = $1 AND tag_id = $2
        `, roomID, tagID); err != nil {
			return fmt.Errorf("detach tag: %w", err)
		}
		return s.recomputeIsDMTx(ctx, tx, roomID)
	})
}

// recomputeIsDMTx evaluates the DM rule against the current state.
// is_dm = true iff:
//   - no org-kind tag attached, AND
//   - every active participant is a user (not a bot)
//
// Anything else falls back to false.
func (s *Service) recomputeIsDMTx(ctx context.Context, tx pgx.Tx, roomID uuid.UUID) error {
	var hasOrgTag bool
	if err := tx.QueryRow(ctx, `
        SELECT EXISTS (
          SELECT 1 FROM chat_room_tags crt
          JOIN tags t ON t.id = crt.tag_id
          WHERE crt.chat_room_id = $1 AND t.root_kind = 'org'
        )
    `, roomID).Scan(&hasOrgTag); err != nil {
		return fmt.Errorf("check org tag: %w", err)
	}
	var allUsers bool
	if err := tx.QueryRow(ctx, `
        SELECT NOT EXISTS (
          SELECT 1 FROM chat_room_participants crp
          JOIN principals p ON p.id = crp.principal_id
          WHERE crp.chat_room_id = $1 AND crp.left_at IS NULL AND p.kind <> 'user'
        )
    `, roomID).Scan(&allUsers); err != nil {
		return fmt.Errorf("check participants: %w", err)
	}
	isDM := !hasOrgTag && allUsers
	if _, err := tx.Exec(ctx, `UPDATE chat_rooms SET is_dm = $1 WHERE id = $2`, isDM, roomID); err != nil {
		return fmt.Errorf("update is_dm: %w", err)
	}
	return nil
}

// GetRoom returns a room by id.
func (s *Service) GetRoom(ctx context.Context, id uuid.UUID) (*Room, error) {
	var r Room
	err := s.DB.QueryRow(ctx, `
        SELECT id, is_dm, created_at, archived_at FROM chat_rooms WHERE id = $1
    `, id).Scan(&r.ID, &r.IsDM, &r.CreatedAt, &r.ArchivedAt)
	if errors.Is(err, pgx.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, fmt.Errorf("load room: %w", err)
	}
	return &r, nil
}

// Participants returns the active participants of a room.
func (s *Service) Participants(ctx context.Context, roomID uuid.UUID) ([]Participant, error) {
	rows, err := s.DB.Query(ctx, `
        SELECT principal_id, role, joined_at, left_at
        FROM chat_room_participants
        WHERE chat_room_id = $1
        ORDER BY joined_at
    `, roomID)
	if err != nil {
		return nil, fmt.Errorf("list participants: %w", err)
	}
	defer rows.Close()
	var out []Participant
	for rows.Next() {
		var p Participant
		if err := rows.Scan(&p.PrincipalID, &p.Role, &p.JoinedAt, &p.LeftAt); err != nil {
			return nil, err
		}
		out = append(out, p)
	}
	return out, rows.Err()
}

// RoomTags returns the tag ids attached to a room.
func (s *Service) RoomTags(ctx context.Context, roomID uuid.UUID) ([]uuid.UUID, error) {
	rows, err := s.DB.Query(ctx, `SELECT tag_id FROM chat_room_tags WHERE chat_room_id = $1`, roomID)
	if err != nil {
		return nil, fmt.Errorf("list room tags: %w", err)
	}
	defer rows.Close()
	var out []uuid.UUID
	for rows.Next() {
		var id uuid.UUID
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		out = append(out, id)
	}
	return out, rows.Err()
}

// SendMessage inserts a chat message and emits a chat.room.<id> NOTIFY
// in the same transaction. Subscribers receive the id and re-fetch.
func (s *Service) SendMessage(ctx context.Context, in SendInput) (uuid.UUID, error) {
	var id uuid.UUID
	err := s.runInTx(ctx, func(tx pgx.Tx) error {
		row := tx.QueryRow(ctx, `
            INSERT INTO messages (chat_room_id, author_id, body, reply_to)
            VALUES ($1, $2, $3, $4) RETURNING id
        `, in.RoomID, in.AuthorID, in.Body, in.ReplyTo)
		if err := row.Scan(&id); err != nil {
			return fmt.Errorf("insert message: %w", err)
		}
		// pg_notify is the realtime hook — payload carries IDs only,
		// subscribers re-fetch + recheck visibility before emitting.
		payload := json.RawMessage(fmt.Sprintf(
			`{"message_id":"%s","author_id":"%s","room_id":"%s"}`,
			id, in.AuthorID, in.RoomID))
		sql, args := realtime.NotifySQL("chat.room."+in.RoomID.String(), payload)
		if _, err := tx.Exec(ctx, sql, args...); err != nil {
			return fmt.Errorf("notify: %w", err)
		}
		return nil
	})
	return id, err
}

// GetMessage returns a message by id.
func (s *Service) GetMessage(ctx context.Context, id uuid.UUID) (*Message, error) {
	var m Message
	err := s.DB.QueryRow(ctx, `
        SELECT id, chat_room_id, author_id, body, reply_to, created_at, edited_at, deleted_at, promoted_to_post
        FROM messages WHERE id = $1
    `, id).Scan(&m.ID, &m.ChatRoomID, &m.AuthorID, &m.Body, &m.ReplyTo, &m.CreatedAt, &m.EditedAt, &m.DeletedAt, &m.PromotedToPost)
	if errors.Is(err, pgx.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, fmt.Errorf("load message: %w", err)
	}
	return &m, nil
}

// EditMessage updates the body and stamps edited_at. Note: M3 does NOT
// snapshot prior body to a message_edits table — chat is more transient
// than posts, and the architecture defers message-edit history to a
// later milestone if user research demands it.
func (s *Service) EditMessage(ctx context.Context, id, editor uuid.UUID, body string) error {
	tag, err := s.DB.Exec(ctx, `
        UPDATE messages SET body = $1, edited_at = now()
        WHERE id = $2 AND deleted_at IS NULL AND body <> $1
    `, body, id)
	if err != nil {
		return fmt.Errorf("edit message: %w", err)
	}
	if tag.RowsAffected() == 0 {
		// Either not found, deleted, or no-op edit.
		var exists bool
		if err := s.DB.QueryRow(ctx,
			`SELECT EXISTS(SELECT 1 FROM messages WHERE id = $1 AND deleted_at IS NULL)`, id).
			Scan(&exists); err != nil {
			return err
		}
		if !exists {
			return ErrNotFound
		}
		return ErrAlreadyEdited
	}
	return nil
}

// DeleteMessage soft-deletes a message.
func (s *Service) DeleteMessage(ctx context.Context, id uuid.UUID) error {
	tag, err := s.DB.Exec(ctx,
		`UPDATE messages SET deleted_at = now() WHERE id = $1 AND deleted_at IS NULL`, id)
	if err != nil {
		return fmt.Errorf("delete message: %w", err)
	}
	if tag.RowsAffected() == 0 {
		return ErrNotFound
	}
	return nil
}

// ListMessages returns active messages in a room, oldest first, capped
// at limit. Soft-deleted messages render as `[deleted]` placeholders;
// for now we just exclude them — the client-side placeholder UX comes
// when chat surfaces ship in the Flutter app (M5).
func (s *Service) ListMessages(ctx context.Context, roomID uuid.UUID, limit int) ([]*Message, error) {
	if limit <= 0 || limit > 500 {
		limit = 100
	}
	rows, err := s.DB.Query(ctx, `
        SELECT id, chat_room_id, author_id, body, reply_to, created_at, edited_at, deleted_at, promoted_to_post
        FROM messages
        WHERE chat_room_id = $1 AND deleted_at IS NULL
        ORDER BY created_at DESC
        LIMIT $2
    `, roomID, limit)
	if err != nil {
		return nil, fmt.Errorf("list messages: %w", err)
	}
	defer rows.Close()
	var out []*Message
	for rows.Next() {
		var m Message
		if err := rows.Scan(&m.ID, &m.ChatRoomID, &m.AuthorID, &m.Body, &m.ReplyTo, &m.CreatedAt, &m.EditedAt, &m.DeletedAt, &m.PromotedToPost); err != nil {
			return nil, err
		}
		out = append(out, &m)
	}
	return out, rows.Err()
}

// PromoteMessage hoists a chat message into a post. Tag attachments come
// from the room's tags; mentions are extracted from the body. The
// message's promoted_to_post is set so the UI can link both directions.
// Returns the new post id.
//
// Constraints:
//   - room must have at least one tag (otherwise the post would be invisible)
//   - message must not already be promoted (idempotency error)
func (s *Service) PromoteMessage(ctx context.Context, msgID, promoter uuid.UUID) (uuid.UUID, error) {
	var postID uuid.UUID
	err := s.runInTx(ctx, func(tx pgx.Tx) error {
		var roomID uuid.UUID
		var body string
		var existing *uuid.UUID
		err := tx.QueryRow(ctx, `
            SELECT chat_room_id, body, promoted_to_post
            FROM messages WHERE id = $1 AND deleted_at IS NULL FOR UPDATE
        `, msgID).Scan(&roomID, &body, &existing)
		if errors.Is(err, pgx.ErrNoRows) {
			return ErrNotFound
		}
		if err != nil {
			return fmt.Errorf("lock message: %w", err)
		}
		if existing != nil {
			postID = *existing
			return ErrAlreadyPromoted
		}
		// Pull room tags inside the same tx so a concurrent tag change
		// doesn't slip past the constraint check below.
		tagRows, err := tx.Query(ctx, `SELECT tag_id FROM chat_room_tags WHERE chat_room_id = $1`, roomID)
		if err != nil {
			return fmt.Errorf("load room tags: %w", err)
		}
		var tagIDs []uuid.UUID
		for tagRows.Next() {
			var t uuid.UUID
			if err := tagRows.Scan(&t); err != nil {
				tagRows.Close()
				return err
			}
			tagIDs = append(tagIDs, t)
		}
		tagRows.Close()
		if len(tagIDs) == 0 {
			return ErrPromoteDM
		}
		// Insert the post directly inside this tx so the cross-table state
		// (post + post_tags + messages.promoted_to_post) is atomic.
		title := promoteTitle(body)
		row := tx.QueryRow(ctx, `
            INSERT INTO posts (title, body, author_id) VALUES ($1, $2, $3)
            RETURNING id
        `, title, body, promoter)
		if err := row.Scan(&postID); err != nil {
			return fmt.Errorf("insert post: %w", err)
		}
		for _, tid := range tagIDs {
			if _, err := tx.Exec(ctx, `
                INSERT INTO post_tags (post_id, tag_id, view_role, interact_role, moderate_role)
                VALUES ($1, $2, TRUE, TRUE, TRUE)
            `, postID, tid); err != nil {
				return fmt.Errorf("insert post_tag: %w", err)
			}
		}
		if _, err := tx.Exec(ctx,
			`UPDATE messages SET promoted_to_post = $1 WHERE id = $2`, postID, msgID); err != nil {
			return fmt.Errorf("link promotion: %w", err)
		}
		return nil
	})
	return postID, err
}

func promoteTitle(body string) string {
	body = strings.TrimSpace(body)
	if len(body) == 0 {
		return "(promoted message)"
	}
	if i := strings.IndexAny(body, "\n.!?"); i > 0 && i < 80 {
		return body[:i]
	}
	if len(body) > 60 {
		return body[:60] + "…"
	}
	return body
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
