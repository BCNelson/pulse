// Package search blends Postgres FTS over the searchable_content view
// with the viewer's visibility predicate. M2 covers posts and comments;
// messages and tasks join in M3 and M4 by amending the SQL union.
//
// Q31 ranking: ts_rank_cd × a 1/(1+days_old) recency factor. The factor
// is intentionally crude — proper tuning waits until we have real corpus
// behaviour to look at.
package search

import (
	"context"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

type Service struct {
	DB *pgxpool.Pool
}

// Kind enumerates the kinds the search method can return. Future kinds
// (message, task) join the same union without touching callers that
// don't filter explicitly.
type Kind string

const (
	KindPost    Kind = "post"
	KindComment Kind = "comment"
)

// Hit is a single search result. Title is empty for non-post hits.
type Hit struct {
	Kind      Kind
	ID        int64
	Title     string
	Body      string
	AuthorID  int64
	Score     float64
	CreatedAt time.Time
}

// TagHit is a fuzzy tag-name match.
type TagHit struct {
	ID          int64
	Slug        string
	DisplayName string
	Similarity  float64
}

var ErrEmptyQuery = errors.New("search: query is required")

// Search runs an FTS query across posts and comments, filtered to what
// the viewer can see, ranked by ts_rank_cd × recency. kinds restricts
// the output to a subset; nil/empty returns all kinds.
func (s *Service) Search(ctx context.Context, viewer int64, query string, kinds []Kind, limit int) ([]Hit, error) {
	query = strings.TrimSpace(query)
	if query == "" {
		return nil, ErrEmptyQuery
	}
	if limit <= 0 || limit > 100 {
		limit = 25
	}
	allow := allowedKinds(kinds)

	parts := []string{}
	args := []any{query, viewer}
	if allow[KindPost] {
		parts = append(parts, postBranchSQL())
	}
	if allow[KindComment] {
		parts = append(parts, commentBranchSQL())
	}
	if len(parts) == 0 {
		return nil, nil
	}
	sql := strings.Join(parts, "\nUNION ALL\n") + `
        ORDER BY score DESC, created_at DESC
        LIMIT $3`
	args = append(args, limit)

	rows, err := s.DB.Query(ctx, sql, args...)
	if err != nil {
		return nil, fmt.Errorf("query search: %w", err)
	}
	defer rows.Close()
	var out []Hit
	for rows.Next() {
		var h Hit
		var title *string
		if err := rows.Scan(&h.Kind, &h.ID, &title, &h.Body, &h.AuthorID, &h.CreatedAt, &h.Score); err != nil {
			return nil, fmt.Errorf("scan hit: %w", err)
		}
		if title != nil {
			h.Title = *title
		}
		out = append(out, h)
	}
	return out, rows.Err()
}

// SearchTags performs a trigram-similarity fuzzy match against tag slugs
// and display names. Filtered through the viewer's tag visibility.
func (s *Service) SearchTags(ctx context.Context, viewer int64, query string, limit int) ([]TagHit, error) {
	query = strings.TrimSpace(query)
	if query == "" {
		return nil, ErrEmptyQuery
	}
	if limit <= 0 || limit > 50 {
		limit = 15
	}
	rows, err := s.DB.Query(ctx, `
        SELECT t.id, t.slug, t.display_name,
               GREATEST(similarity(t.slug, $1), similarity(t.display_name, $1)) AS sim
        FROM tags t
        WHERE t.archived_at IS NULL
          AND (t.slug % $1 OR t.display_name % $1)
          AND EXISTS (
            SELECT 1 FROM tag_grants g
            JOIN tag_closure c ON c.ancestor_id = g.tag_id
            WHERE c.descendant_id = t.id
              AND g.principal_id = $2
              AND (c.depth = 0 OR g.cascade = TRUE)
          )
        ORDER BY sim DESC
        LIMIT $3
    `, query, viewer, limit)
	if err != nil {
		return nil, fmt.Errorf("search tags: %w", err)
	}
	defer rows.Close()
	var out []TagHit
	for rows.Next() {
		var h TagHit
		if err := rows.Scan(&h.ID, &h.Slug, &h.DisplayName, &h.Similarity); err != nil {
			return nil, err
		}
		out = append(out, h)
	}
	return out, rows.Err()
}

func allowedKinds(kinds []Kind) map[Kind]bool {
	if len(kinds) == 0 {
		return map[Kind]bool{KindPost: true, KindComment: true}
	}
	out := make(map[Kind]bool, len(kinds))
	for _, k := range kinds {
		out[k] = true
	}
	return out
}

// postBranchSQL is a UNION branch for post hits. $1 is the websearch
// query, $2 is the viewer principal id; ts_rank_cd is multiplied by a
// 1/(1+days_old) recency factor so fresh posts edge out comparable
// older ones (Q31's first-pass blend).
func postBranchSQL() string {
	return `
        SELECT 'post'::text AS kind, p.id, p.title AS title, p.body, p.author_id, p.created_at,
               (ts_rank_cd(p.body_tsv, websearch_to_tsquery('english', $1))
                 * (1.0 / (1.0 + EXTRACT(EPOCH FROM (now() - p.created_at)) / 86400.0))) AS score
        FROM posts p
        WHERE p.deleted_at IS NULL
          AND p.body_tsv @@ websearch_to_tsquery('english', $1)
          AND EXISTS (
            SELECT 1 FROM post_tags pt
            JOIN tag_closure c ON c.descendant_id = pt.tag_id
            JOIN tag_grants  g ON g.tag_id = c.ancestor_id
            WHERE pt.post_id = p.id
              AND pt.view_role = TRUE
              AND g.principal_id = $2
              AND (c.depth = 0 OR g.cascade = TRUE)
          )
    `
}

func commentBranchSQL() string {
	return `
        SELECT 'comment'::text AS kind, cm.id, NULL::text AS title, cm.body, cm.author_id, cm.created_at,
               (ts_rank_cd(cm.body_tsv, websearch_to_tsquery('english', $1))
                 * (1.0 / (1.0 + EXTRACT(EPOCH FROM (now() - cm.created_at)) / 86400.0))) AS score
        FROM comments cm
        JOIN posts p ON p.id = cm.post_id
        WHERE cm.deleted_at IS NULL AND p.deleted_at IS NULL
          AND cm.body_tsv @@ websearch_to_tsquery('english', $1)
          AND EXISTS (
            SELECT 1 FROM post_tags pt
            JOIN tag_closure c ON c.descendant_id = pt.tag_id
            JOIN tag_grants  g ON g.tag_id = c.ancestor_id
            WHERE pt.post_id = cm.post_id
              AND pt.view_role = TRUE
              AND g.principal_id = $2
              AND (c.depth = 0 OR g.cascade = TRUE)
          )
    `
}
