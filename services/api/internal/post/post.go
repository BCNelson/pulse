// Package post owns posts, post_tags, post_mentions, edit history, and
// reactions on posts. Authorization checks live one layer up — this
// package is the data-shape and tag-attachment guardian.
package post

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"time"

	"github.com/bcnelson/pulse/services/api/internal/realtime"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

var (
	ErrNotFound      = errors.New("post: not found")
	ErrNoTags        = errors.New("post: at least one tag required")
	ErrAlreadyEdited = errors.New("post: title or body unchanged")
)

type Service struct {
	DB *pgxpool.Pool
}

// TagAttachment captures the per-post role-flag overrides on a tag. All
// flags default to true at insertion if omitted.
type TagAttachment struct {
	TagID        int64
	ViewRole     bool
	InteractRole bool
	ModerateRole bool
}

// CreateInput is the payload for createPost. AuthorID is the principal
// the post will be attributed to — typically the viewer's effective id.
type CreateInput struct {
	AuthorID int64
	Title    string
	Body     string
	Tags     []TagAttachment
	Mentions []int64
	TagRefs  []int64 // tag ids referenced inline in the body
	Decision *string // 'decision' | 'answer' | nil
	DenyFlag bool
}

// Post is the read-side row used by the GraphQL resolvers. Field set
// matches what's needed without round-tripping; tag attachments and
// mentions are loaded separately so callers don't pay for them when not
// requested.
type Post struct {
	ID             int64
	Title          string
	Body           string
	AuthorID       int64
	DecisionStatus *string
	DenyFlag       bool
	CreatedAt      anyTime
	EditedAt       *anyTime
	DeletedAt      *anyTime
}

type anyTime = anyTimeImpl

// Create inserts a post with its tags and mentions in a single transaction.
// At least one tag is required — a post with no tags would be invisible.
func (s *Service) Create(ctx context.Context, in CreateInput) (int64, error) {
	if len(in.Tags) == 0 {
		return int64(0), ErrNoTags
	}
	var id int64
	err := s.runInTx(ctx, func(tx pgx.Tx) error {
		row := tx.QueryRow(ctx, `
            INSERT INTO posts (title, body, author_id, decision_status, deny_flag)
            VALUES ($1, $2, $3, $4, $5)
            RETURNING id
        `, in.Title, in.Body, in.AuthorID, in.Decision, in.DenyFlag)
		if err := row.Scan(&id); err != nil {
			return fmt.Errorf("insert post: %w", err)
		}
		for _, t := range in.Tags {
			if _, err := tx.Exec(ctx, `
                INSERT INTO post_tags (post_id, tag_id, view_role, interact_role, moderate_role)
                VALUES ($1, $2, $3, $4, $5)
            `, id, t.TagID, t.ViewRole, t.InteractRole, t.ModerateRole); err != nil {
				return fmt.Errorf("insert post_tag: %w", err)
			}
		}
		for _, p := range in.Mentions {
			if _, err := tx.Exec(ctx, `
                INSERT INTO post_mentions (post_id, principal_id) VALUES ($1, $2)
                ON CONFLICT DO NOTHING
            `, id, p); err != nil {
				return fmt.Errorf("insert mention: %w", err)
			}
		}
		for _, t := range in.TagRefs {
			if _, err := tx.Exec(ctx, `
                INSERT INTO post_tag_refs (post_id, tag_id) VALUES ($1, $2)
                ON CONFLICT DO NOTHING
            `, id, t); err != nil {
				return fmt.Errorf("insert tag ref: %w", err)
			}
		}
		tagIDs := make([]int64, 0, len(in.Tags))
		for _, t := range in.Tags {
			tagIDs = append(tagIDs, t.TagID)
		}
		if err := notifyPostChanged(ctx, tx, id, tagIDs); err != nil {
			return err
		}
		return nil
	})
	return id, err
}

// notifyPostChanged emits posts.tag.<id> NOTIFY for each attached tag so
// subscribers to PostChanged refetch. Payload carries only the post id —
// subscribers re-check visibility and load the row themselves. Called
// inside the same transaction as the write so events are atomic with
// state.
func notifyPostChanged(ctx context.Context, tx pgx.Tx, postID int64, tagIDs []int64) error {
	if len(tagIDs) == 0 {
		return nil
	}
	payload := json.RawMessage(fmt.Sprintf(`{"post_id":"%s"}`, ids.FormatID(postID)))
	for _, tid := range tagIDs {
		sql, args := realtime.NotifySQL("posts.tag."+ids.FormatID(tid), payload)
		if _, err := tx.Exec(ctx, sql, args...); err != nil {
			return fmt.Errorf("notify post changed: %w", err)
		}
	}
	return nil
}

// Get returns the post by id, or ErrNotFound. Soft-deleted posts are
// returned with DeletedAt set; callers decide whether to surface them.
func (s *Service) Get(ctx context.Context, id int64) (*Post, error) {
	row := s.DB.QueryRow(ctx, `
        SELECT id, title, body, author_id, decision_status, deny_flag, created_at, edited_at, deleted_at
        FROM posts WHERE id = $1
    `, id)
	var p Post
	if err := row.Scan(&p.ID, &p.Title, &p.Body, &p.AuthorID, &p.DecisionStatus, &p.DenyFlag, &p.CreatedAt, &p.EditedAt, &p.DeletedAt); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, ErrNotFound
		}
		return nil, fmt.Errorf("load post: %w", err)
	}
	return &p, nil
}

// Edit snapshots the prior title/body to post_edits, updates the row,
// and re-derives the body-driven junctions (post_mentions, post_tag_refs)
// since the new body may have added or removed mention/tag-ref tokens.
// If neither title nor body changed, returns ErrAlreadyEdited.
func (s *Service) Edit(ctx context.Context, id, editor int64, title, body string, mentions, tagRefs []int64) error {
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		var prevTitle, prevBody string
		err := tx.QueryRow(ctx,
			`SELECT title, body FROM posts WHERE id = $1 FOR UPDATE`, id).
			Scan(&prevTitle, &prevBody)
		if errors.Is(err, pgx.ErrNoRows) {
			return ErrNotFound
		}
		if err != nil {
			return fmt.Errorf("lock post: %w", err)
		}
		if prevTitle == title && prevBody == body {
			return ErrAlreadyEdited
		}
		if _, err := tx.Exec(ctx, `
            INSERT INTO post_edits (post_id, editor_id, prev_title, prev_body)
            VALUES ($1, $2, $3, $4)
        `, id, editor, prevTitle, prevBody); err != nil {
			return fmt.Errorf("insert edit history: %w", err)
		}
		if _, err := tx.Exec(ctx, `
            UPDATE posts SET title = $1, body = $2, edited_at = now() WHERE id = $3
        `, title, body, id); err != nil {
			return fmt.Errorf("update post: %w", err)
		}
		if _, err := tx.Exec(ctx, `DELETE FROM post_mentions WHERE post_id = $1`, id); err != nil {
			return fmt.Errorf("clear mentions: %w", err)
		}
		for _, p := range mentions {
			if _, err := tx.Exec(ctx, `
                INSERT INTO post_mentions (post_id, principal_id) VALUES ($1, $2)
                ON CONFLICT DO NOTHING
            `, id, p); err != nil {
				return fmt.Errorf("insert mention: %w", err)
			}
		}
		if _, err := tx.Exec(ctx, `DELETE FROM post_tag_refs WHERE post_id = $1`, id); err != nil {
			return fmt.Errorf("clear tag refs: %w", err)
		}
		for _, t := range tagRefs {
			if _, err := tx.Exec(ctx, `
                INSERT INTO post_tag_refs (post_id, tag_id) VALUES ($1, $2)
                ON CONFLICT DO NOTHING
            `, id, t); err != nil {
				return fmt.Errorf("insert tag ref: %w", err)
			}
		}
		tagIDs, err := loadPostTagIDs(ctx, tx, id)
		if err != nil {
			return err
		}
		return notifyPostChanged(ctx, tx, id, tagIDs)
	})
}

// loadPostTagIDs reads the tag-attachment ids for a post inside a tx so
// notify emission stays atomic with the write that prompted it.
func loadPostTagIDs(ctx context.Context, tx pgx.Tx, postID int64) ([]int64, error) {
	rows, err := tx.Query(ctx, `SELECT tag_id FROM post_tags WHERE post_id = $1`, postID)
	if err != nil {
		return nil, fmt.Errorf("load post_tags: %w", err)
	}
	defer rows.Close()
	var out []int64
	for rows.Next() {
		var t int64
		if err := rows.Scan(&t); err != nil {
			return nil, err
		}
		out = append(out, t)
	}
	return out, rows.Err()
}

// Delete soft-deletes a post (deleted_at = now()). Comments and reactions
// remain in place for archival; reads filter on deleted_at IS NULL.
func (s *Service) Delete(ctx context.Context, id int64) error {
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		tag, err := tx.Exec(ctx,
			`UPDATE posts SET deleted_at = now() WHERE id = $1 AND deleted_at IS NULL`, id)
		if err != nil {
			return fmt.Errorf("soft-delete: %w", err)
		}
		if tag.RowsAffected() == 0 {
			return ErrNotFound
		}
		tagIDs, err := loadPostTagIDs(ctx, tx, id)
		if err != nil {
			return err
		}
		return notifyPostChanged(ctx, tx, id, tagIDs)
	})
}

func (s *Service) SetDecisionStatus(ctx context.Context, id int64, status *string) error {
	if status != nil && *status != "decision" && *status != "answer" {
		return fmt.Errorf("post: invalid decision status %q", *status)
	}
	tag, err := s.DB.Exec(ctx,
		`UPDATE posts SET decision_status = $1 WHERE id = $2`, status, id)
	if err != nil {
		return fmt.Errorf("set decision: %w", err)
	}
	if tag.RowsAffected() == 0 {
		return ErrNotFound
	}
	return nil
}

func (s *Service) SetDenyFlag(ctx context.Context, id int64, deny bool) error {
	tag, err := s.DB.Exec(ctx,
		`UPDATE posts SET deny_flag = $1 WHERE id = $2`, deny, id)
	if err != nil {
		return fmt.Errorf("set deny: %w", err)
	}
	if tag.RowsAffected() == 0 {
		return ErrNotFound
	}
	return nil
}

// React adds (or refreshes) a (post, principal, emoji) reaction. Idempotent.
func (s *Service) React(ctx context.Context, id, principal int64, emoji string) error {
	_, err := s.DB.Exec(ctx, `
        INSERT INTO post_reactions (post_id, principal_id, emoji)
        VALUES ($1, $2, $3)
        ON CONFLICT (post_id, principal_id, emoji) DO NOTHING
    `, id, principal, emoji)
	return err
}

// Unreact removes a (post, principal, emoji) reaction.
func (s *Service) Unreact(ctx context.Context, id, principal int64, emoji string) error {
	_, err := s.DB.Exec(ctx, `
        DELETE FROM post_reactions WHERE post_id = $1 AND principal_id = $2 AND emoji = $3
    `, id, principal, emoji)
	return err
}

// ReactionTally returns per-emoji counts and the viewer's own reactions
// in a single trip. Used by the GraphQL Post.reactions field.
func (s *Service) ReactionTally(ctx context.Context, id, viewer int64) ([]EmojiCount, error) {
	rows, err := s.DB.Query(ctx, `
        SELECT emoji, COUNT(*)::INT, BOOL_OR(principal_id = $2) AS by_viewer
        FROM post_reactions
        WHERE post_id = $1
        GROUP BY emoji
        ORDER BY emoji
    `, id, viewer)
	if err != nil {
		return nil, fmt.Errorf("tally: %w", err)
	}
	defer rows.Close()
	var out []EmojiCount
	for rows.Next() {
		var e EmojiCount
		if err := rows.Scan(&e.Emoji, &e.Count, &e.ByViewer); err != nil {
			return nil, err
		}
		out = append(out, e)
	}
	return out, rows.Err()
}

// EmojiCount is the aggregated reaction shape returned to clients.
type EmojiCount struct {
	Emoji    string
	Count    int
	ByViewer bool
}

// MarkRead upserts the viewer's last_read_at on a post. If seenAt is nil
// the timestamp is the current server time. The stored value is clamped
// with GREATEST so a stale-client timestamp or clock skew can never move
// the read mark backwards.
func (s *Service) MarkRead(ctx context.Context, id, principal int64, seenAt *time.Time) error {
	_, err := s.DB.Exec(ctx, `
        INSERT INTO principal_post_read (principal_id, post_id, last_read_at)
        VALUES ($1, $2, COALESCE($3, now()))
        ON CONFLICT (principal_id, post_id) DO UPDATE
          SET last_read_at = GREATEST(principal_post_read.last_read_at, COALESCE($3, now()))
    `, principal, id, seenAt)
	return err
}

// TagAttachments returns the post's tag rows for resolver shaping.
func (s *Service) TagAttachments(ctx context.Context, id int64) ([]TagRow, error) {
	rows, err := s.DB.Query(ctx, `
        SELECT tag_id, view_role, interact_role, moderate_role
        FROM post_tags WHERE post_id = $1
    `, id)
	if err != nil {
		return nil, fmt.Errorf("load post_tags: %w", err)
	}
	defer rows.Close()
	var out []TagRow
	for rows.Next() {
		var r TagRow
		if err := rows.Scan(&r.TagID, &r.ViewRole, &r.InteractRole, &r.ModerateRole); err != nil {
			return nil, err
		}
		out = append(out, r)
	}
	return out, rows.Err()
}

type TagRow struct {
	TagID        int64
	ViewRole     bool
	InteractRole bool
	ModerateRole bool
}

// Mentions returns the principal ids mentioned in this post.
func (s *Service) Mentions(ctx context.Context, id int64) ([]int64, error) {
	rows, err := s.DB.Query(ctx,
		`SELECT principal_id FROM post_mentions WHERE post_id = $1`, id)
	if err != nil {
		return nil, fmt.Errorf("load mentions: %w", err)
	}
	defer rows.Close()
	var out []int64
	for rows.Next() {
		var p int64
		if err := rows.Scan(&p); err != nil {
			return nil, err
		}
		out = append(out, p)
	}
	return out, rows.Err()
}

// TagRefs returns the tag ids referenced inline from this post's body.
// Distinct from TagAttachments — these tags are link-only and do not
// affect ACLs.
func (s *Service) TagRefs(ctx context.Context, id int64) ([]int64, error) {
	rows, err := s.DB.Query(ctx,
		`SELECT tag_id FROM post_tag_refs WHERE post_id = $1`, id)
	if err != nil {
		return nil, fmt.Errorf("load tag refs: %w", err)
	}
	defer rows.Close()
	var out []int64
	for rows.Next() {
		var t int64
		if err := rows.Scan(&t); err != nil {
			return nil, err
		}
		out = append(out, t)
	}
	return out, rows.Err()
}

// ListByTag returns posts attached to tagID, paginated by created_at DESC.
// When includeDescendants is true, the result also covers every tag in
// tagID's tag_closure subtree (deduped per-post). The caller passes the
// visibility predicate as already-checked: this function does *not*
// perform a perm check.
func (s *Service) ListByTag(ctx context.Context, tagID int64, includeDescendants bool, limit int) ([]*Post, error) {
	if limit <= 0 || limit > 100 {
		limit = 50
	}
	var (
		rows pgx.Rows
		err  error
	)
	if includeDescendants {
		rows, err = s.DB.Query(ctx, `
            SELECT p.id, p.title, p.body, p.author_id, p.decision_status, p.deny_flag, p.created_at, p.edited_at, p.deleted_at
            FROM posts p
            JOIN post_tags pt ON pt.post_id = p.id
            JOIN tag_closure c ON c.descendant_id = pt.tag_id
            WHERE c.ancestor_id = $1 AND p.deleted_at IS NULL
            GROUP BY p.id
            ORDER BY p.created_at DESC
            LIMIT $2
        `, tagID, limit)
	} else {
		rows, err = s.DB.Query(ctx, `
            SELECT p.id, p.title, p.body, p.author_id, p.decision_status, p.deny_flag, p.created_at, p.edited_at, p.deleted_at
            FROM posts p
            JOIN post_tags pt ON pt.post_id = p.id
            WHERE pt.tag_id = $1 AND p.deleted_at IS NULL
            ORDER BY p.created_at DESC
            LIMIT $2
        `, tagID, limit)
	}
	if err != nil {
		return nil, fmt.Errorf("list by tag: %w", err)
	}
	defer rows.Close()
	var out []*Post
	for rows.Next() {
		var p Post
		if err := rows.Scan(&p.ID, &p.Title, &p.Body, &p.AuthorID, &p.DecisionStatus, &p.DenyFlag, &p.CreatedAt, &p.EditedAt, &p.DeletedAt); err != nil {
			return nil, err
		}
		out = append(out, &p)
	}
	return out, rows.Err()
}

// ExtractMentionsJSON is a debug aid for callers that want to round-trip
// a mention list through a JSONB column for audit_events.diff. Not used
// by the normal flow.
func ExtractMentionsJSON(mentions []int64) (json.RawMessage, error) {
	if len(mentions) == 0 {
		return json.RawMessage(`[]`), nil
	}
	return json.Marshal(mentions)
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
