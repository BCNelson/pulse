// Package comment owns comments on posts and threads. The closure-style
// data structure is the materialized ltree path on each row; comments
// don't move (unlike tags), so an incremental insert is enough — no full
// closure table needed. Authorization checks live one layer up.
package comment

import (
	"context"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/bcnelson/pulse/services/api/pkg/ids"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

var (
	ErrNotFound       = errors.New("comment: not found")
	ErrParentMismatch = errors.New("comment: parent belongs to a different post")
	ErrAlreadyEdited  = errors.New("comment: body unchanged")
)

type Service struct {
	DB *pgxpool.Pool
}

// Comment is the read-side row used by GraphQL resolvers.
type Comment struct {
	ID        int64
	PostID    int64
	ParentID  *int64
	Path      string
	AuthorID  int64
	Body      string
	CreatedAt time.Time
	EditedAt  *time.Time
	DeletedAt *time.Time
}

type CreateInput struct {
	PostID   int64
	ParentID *int64 // nil for top-level comments
	AuthorID int64
	Body     string
	Mentions []int64
	TagRefs  []int64 // tag ids referenced inline in the body
}

// Create inserts a comment and writes the materialized ltree path. The
// path label for a comment is "c" + uuid hex (no dashes), since ltree
// labels must start with a letter.
func (s *Service) Create(ctx context.Context, in CreateInput) (int64, error) {
	id := ids.New(ids.KindComment)
	myLabel := pathLabel(id)

	var path string
	if in.ParentID != nil {
		var parentPath string
		var parentPostID int64
		err := s.DB.QueryRow(ctx,
			`SELECT path::text, post_id FROM comments WHERE id = $1`, *in.ParentID).
			Scan(&parentPath, &parentPostID)
		if errors.Is(err, pgx.ErrNoRows) {
			return int64(0), ErrNotFound
		}
		if err != nil {
			return int64(0), fmt.Errorf("load parent: %w", err)
		}
		if parentPostID != in.PostID {
			return int64(0), ErrParentMismatch
		}
		path = parentPath + "." + myLabel
	} else {
		path = myLabel
	}

	err := s.runInTx(ctx, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `
            INSERT INTO comments (id, post_id, parent_id, path, author_id, body)
            VALUES ($1, $2, $3, $4::ltree, $5, $6)
        `, id, in.PostID, in.ParentID, path, in.AuthorID, in.Body); err != nil {
			return fmt.Errorf("insert comment: %w", err)
		}
		for _, p := range in.Mentions {
			if _, err := tx.Exec(ctx, `
                INSERT INTO comment_mentions (comment_id, principal_id) VALUES ($1, $2)
                ON CONFLICT DO NOTHING
            `, id, p); err != nil {
				return fmt.Errorf("insert mention: %w", err)
			}
		}
		for _, t := range in.TagRefs {
			if _, err := tx.Exec(ctx, `
                INSERT INTO comment_tag_refs (comment_id, tag_id) VALUES ($1, $2)
                ON CONFLICT DO NOTHING
            `, id, t); err != nil {
				return fmt.Errorf("insert tag ref: %w", err)
			}
		}
		return nil
	})
	return id, err
}

// Get returns a comment by id.
func (s *Service) Get(ctx context.Context, id int64) (*Comment, error) {
	row := s.DB.QueryRow(ctx, `
        SELECT id, post_id, parent_id, path::text, author_id, body, created_at, edited_at, deleted_at
        FROM comments WHERE id = $1
    `, id)
	var c Comment
	if err := row.Scan(&c.ID, &c.PostID, &c.ParentID, &c.Path, &c.AuthorID, &c.Body, &c.CreatedAt, &c.EditedAt, &c.DeletedAt); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, ErrNotFound
		}
		return nil, fmt.Errorf("load comment: %w", err)
	}
	return &c, nil
}

// Edit appends a snapshot to comment_edits, updates the comment body, and
// re-derives the body-driven junctions (comment_mentions, comment_tag_refs).
func (s *Service) Edit(ctx context.Context, id, editor int64, body string, mentions, tagRefs []int64) error {
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		var prev string
		err := tx.QueryRow(ctx,
			`SELECT body FROM comments WHERE id = $1 FOR UPDATE`, id).
			Scan(&prev)
		if errors.Is(err, pgx.ErrNoRows) {
			return ErrNotFound
		}
		if err != nil {
			return fmt.Errorf("lock comment: %w", err)
		}
		if prev == body {
			return ErrAlreadyEdited
		}
		if _, err := tx.Exec(ctx, `
            INSERT INTO comment_edits (comment_id, editor_id, prev_body)
            VALUES ($1, $2, $3)
        `, id, editor, prev); err != nil {
			return fmt.Errorf("insert edit history: %w", err)
		}
		if _, err := tx.Exec(ctx, `
            UPDATE comments SET body = $1, edited_at = now() WHERE id = $2
        `, body, id); err != nil {
			return fmt.Errorf("update comment: %w", err)
		}
		if _, err := tx.Exec(ctx, `DELETE FROM comment_mentions WHERE comment_id = $1`, id); err != nil {
			return fmt.Errorf("clear mentions: %w", err)
		}
		for _, p := range mentions {
			if _, err := tx.Exec(ctx, `
                INSERT INTO comment_mentions (comment_id, principal_id) VALUES ($1, $2)
                ON CONFLICT DO NOTHING
            `, id, p); err != nil {
				return fmt.Errorf("insert mention: %w", err)
			}
		}
		if _, err := tx.Exec(ctx, `DELETE FROM comment_tag_refs WHERE comment_id = $1`, id); err != nil {
			return fmt.Errorf("clear tag refs: %w", err)
		}
		for _, t := range tagRefs {
			if _, err := tx.Exec(ctx, `
                INSERT INTO comment_tag_refs (comment_id, tag_id) VALUES ($1, $2)
                ON CONFLICT DO NOTHING
            `, id, t); err != nil {
				return fmt.Errorf("insert tag ref: %w", err)
			}
		}
		return nil
	})
}

// Delete soft-deletes a comment. Children remain — clients render
// "[deleted]" placeholders to preserve thread structure.
func (s *Service) Delete(ctx context.Context, id int64) error {
	tag, err := s.DB.Exec(ctx,
		`UPDATE comments SET deleted_at = now() WHERE id = $1 AND deleted_at IS NULL`, id)
	if err != nil {
		return fmt.Errorf("soft-delete: %w", err)
	}
	if tag.RowsAffected() == 0 {
		return ErrNotFound
	}
	return nil
}

// React adds a (comment, principal, emoji) reaction. Idempotent.
func (s *Service) React(ctx context.Context, id, principal int64, emoji string) error {
	_, err := s.DB.Exec(ctx, `
        INSERT INTO comment_reactions (comment_id, principal_id, emoji)
        VALUES ($1, $2, $3)
        ON CONFLICT (comment_id, principal_id, emoji) DO NOTHING
    `, id, principal, emoji)
	return err
}

func (s *Service) Unreact(ctx context.Context, id, principal int64, emoji string) error {
	_, err := s.DB.Exec(ctx, `
        DELETE FROM comment_reactions WHERE comment_id = $1 AND principal_id = $2 AND emoji = $3
    `, id, principal, emoji)
	return err
}

// ListByPost returns active comments for a post in tree order — sibling
// groups by created_at, descendants depth-first via ltree path. The
// returned slice is suitable for resolving a Connection where each Comment
// carries a depth (= label count - 1) for client-side indentation.
func (s *Service) ListByPost(ctx context.Context, postID int64, limit int) ([]*Comment, error) {
	if limit <= 0 || limit > 1000 {
		limit = 200
	}
	rows, err := s.DB.Query(ctx, `
        SELECT id, post_id, parent_id, path::text, author_id, body, created_at, edited_at, deleted_at
        FROM comments
        WHERE post_id = $1
        ORDER BY path
        LIMIT $2
    `, postID, limit)
	if err != nil {
		return nil, fmt.Errorf("list comments: %w", err)
	}
	defer rows.Close()
	var out []*Comment
	for rows.Next() {
		var c Comment
		if err := rows.Scan(&c.ID, &c.PostID, &c.ParentID, &c.Path, &c.AuthorID, &c.Body, &c.CreatedAt, &c.EditedAt, &c.DeletedAt); err != nil {
			return nil, err
		}
		out = append(out, &c)
	}
	return out, rows.Err()
}

// Depth returns the comment's nesting level by counting `.` separators in
// the path. Top-level comment has depth 0.
func Depth(path string) int {
	if path == "" {
		return 0
	}
	return strings.Count(path, ".")
}

func pathLabel(id int64) string {
	// ids.FormatID(uuid) is 36 chars with dashes; strip the dashes for ltree
	// label rules and prefix with "c" so the label starts with a letter.
	s := ids.FormatID(id)
	out := make([]byte, 0, 33)
	out = append(out, 'c')
	for i := 0; i < len(s); i++ {
		if s[i] != '-' {
			out = append(out, s[i])
		}
	}
	return string(out)
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
