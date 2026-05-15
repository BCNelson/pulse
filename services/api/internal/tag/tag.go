// Package tag owns the tag tree: adjacency-list rows plus a closure table
// that the application keeps in sync transactionally. Triggers were
// considered and rejected — the architecture wants this logic explicit and
// testable. M1 covers create/move/archive/rebuild; later milestones layer
// on the GraphQL surface and the perm-check wrappers.
package tag

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

const (
	RootKindOrg  = "org"
	RootKindUser = "user"
)

var (
	ErrNotFound       = errors.New("tag: not found")
	ErrCycle          = errors.New("tag: move would create a cycle")
	ErrRootMove       = errors.New("tag: cannot move a root tag")
	ErrInvalidParent  = errors.New("tag: invalid parent")
	ErrInvalidRootArg = errors.New("tag: invalid root-tag arguments")
)

// Service exposes tag-tree mutations with closure-table maintenance.
// Authorization checks live one layer up; this package is a data-shape
// guardian, not a policy enforcer.
type Service struct {
	DB *pgxpool.Pool
}

// CreateInput is what callers fill in to add a tag. ParentID is nil for a
// root tag; in that case RootKind selects 'org' or 'user' and BoundPrincipal
// must be non-nil iff RootKind == 'user'.
type CreateInput struct {
	ParentID       *int64
	Slug           string
	DisplayName    string
	RootKind       string
	BoundPrincipal *int64
	Defaults       json.RawMessage
}

// Create inserts a tag and the closure rows that link it to its ancestors.
// Returns the new tag's id.
func (s *Service) Create(ctx context.Context, in CreateInput) (int64, error) {
	if err := validateCreate(in); err != nil {
		return int64(0), err
	}
	defaults := in.Defaults
	if len(defaults) == 0 {
		defaults = []byte("{}")
	}

	var id int64
	err := s.runInTx(ctx, func(tx pgx.Tx) error {
		row := tx.QueryRow(ctx, `
            INSERT INTO tags (parent_id, slug, display_name, root_kind, bound_principal, defaults)
            VALUES ($1, $2, $3, $4, $5, $6)
            RETURNING id
        `, in.ParentID, in.Slug, in.DisplayName, in.RootKind, in.BoundPrincipal, defaults)
		if err := row.Scan(&id); err != nil {
			return fmt.Errorf("insert tag: %w", err)
		}
		// Self-edge at depth 0.
		if _, err := tx.Exec(ctx,
			`INSERT INTO tag_closure (ancestor_id, descendant_id, depth) VALUES ($1, $1, 0)`,
			id); err != nil {
			return fmt.Errorf("insert self closure: %w", err)
		}
		// Inherit ancestor edges from the parent (when there is one).
		if in.ParentID != nil {
			if _, err := tx.Exec(ctx, `
                INSERT INTO tag_closure (ancestor_id, descendant_id, depth)
                SELECT ancestor_id, $1, depth + 1
                FROM tag_closure
                WHERE descendant_id = $2
            `, id, *in.ParentID); err != nil {
				return fmt.Errorf("insert ancestor closure: %w", err)
			}
		}
		return nil
	})
	return id, err
}

// Move relocates tagID under newParentID, rebuilding the closure rows for
// every descendant of tagID. Caller is responsible for permission checks
// and audit. Errors with ErrRootMove if tagID is a root, ErrCycle if the
// move would be cyclic, ErrNotFound if tagID is unknown.
func (s *Service) Move(ctx context.Context, tagID, newParentID int64) error {
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		var srcParent *int64
		err := tx.QueryRow(ctx,
			`SELECT parent_id FROM tags WHERE id = $1 FOR UPDATE`,
			tagID).Scan(&srcParent)
		if errors.Is(err, pgx.ErrNoRows) {
			return ErrNotFound
		}
		if err != nil {
			return fmt.Errorf("lock src: %w", err)
		}
		if srcParent == nil {
			return ErrRootMove
		}

		// Cycle check first — if dest is in src's subtree the move would be
		// circular. tag_closure includes self-edges so this also catches
		// "moving a tag under itself".
		var cycle bool
		if err := tx.QueryRow(ctx, `
            SELECT EXISTS (
              SELECT 1 FROM tag_closure WHERE ancestor_id = $1 AND descendant_id = $2
            )
        `, tagID, newParentID).Scan(&cycle); err != nil {
			return fmt.Errorf("cycle check: %w", err)
		}
		if cycle {
			return ErrCycle
		}

		// Lock destination row so concurrent moves serialize on the same dest.
		var destExists bool
		if err := tx.QueryRow(ctx,
			`SELECT EXISTS (SELECT 1 FROM tags WHERE id = $1 FOR UPDATE)`,
			newParentID).Scan(&destExists); err != nil {
			return fmt.Errorf("lock dest: %w", err)
		}
		if !destExists {
			return ErrInvalidParent
		}

		// Delete the closure edges that link descendants of the moving subtree
		// to ancestors that lie *outside* the subtree. Edges fully inside the
		// subtree (subtree-to-subtree) are preserved.
		if _, err := tx.Exec(ctx, `
            DELETE FROM tag_closure
            WHERE descendant_id IN (
                    SELECT descendant_id FROM tag_closure WHERE ancestor_id = $1
                  )
              AND ancestor_id NOT IN (
                    SELECT descendant_id FROM tag_closure WHERE ancestor_id = $1
                  )
        `, tagID); err != nil {
			return fmt.Errorf("clear old closure: %w", err)
		}

		// Insert edges from every ancestor of the new parent to every
		// descendant of the moved subtree. Depth = ancestor.depth + subtree.depth + 1.
		if _, err := tx.Exec(ctx, `
            INSERT INTO tag_closure (ancestor_id, descendant_id, depth)
            SELECT supertree.ancestor_id, subtree.descendant_id,
                   supertree.depth + subtree.depth + 1
            FROM tag_closure supertree
            JOIN tag_closure subtree ON subtree.ancestor_id = $1
            WHERE supertree.descendant_id = $2
        `, tagID, newParentID); err != nil {
			return fmt.Errorf("insert new closure: %w", err)
		}

		if _, err := tx.Exec(ctx,
			`UPDATE tags SET parent_id = $1 WHERE id = $2`,
			newParentID, tagID); err != nil {
			return fmt.Errorf("update parent: %w", err)
		}
		return nil
	})
}

// Archive marks tagID and every descendant archived (idempotent — already-
// archived rows are left untouched).
func (s *Service) Archive(ctx context.Context, tagID int64) error {
	tag, err := s.DB.Exec(ctx, `
        UPDATE tags SET archived_at = now()
        WHERE id IN (SELECT descendant_id FROM tag_closure WHERE ancestor_id = $1)
          AND archived_at IS NULL
    `, tagID)
	if err != nil {
		return fmt.Errorf("archive: %w", err)
	}
	if tag.RowsAffected() == 0 {
		// Either tag is missing or already fully archived; only the missing
		// case is interesting to callers.
		var exists bool
		if err := s.DB.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM tags WHERE id = $1)`, tagID).Scan(&exists); err != nil {
			return fmt.Errorf("check existence: %w", err)
		}
		if !exists {
			return ErrNotFound
		}
	}
	return nil
}

// RebuildClosure rebuilds tag_closure from tags.parent_id. Used as a
// recovery path when a consistency check (depth / orphan / dup edges) fails.
// Truncates and re-derives — callers must ensure exclusive access.
func (s *Service) RebuildClosure(ctx context.Context) error {
	return s.runInTx(ctx, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `TRUNCATE tag_closure`); err != nil {
			return fmt.Errorf("truncate: %w", err)
		}
		_, err := tx.Exec(ctx, `
            WITH RECURSIVE descent AS (
              SELECT id AS ancestor_id, id AS descendant_id, 0 AS depth FROM tags
              UNION ALL
              SELECT d.ancestor_id, t.id, d.depth + 1
              FROM descent d JOIN tags t ON t.parent_id = d.descendant_id
            )
            INSERT INTO tag_closure (ancestor_id, descendant_id, depth)
            SELECT ancestor_id, descendant_id, depth FROM descent
        `)
		if err != nil {
			return fmt.Errorf("rebuild: %w", err)
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

func validateCreate(in CreateInput) error {
	if in.Slug == "" || in.DisplayName == "" || in.RootKind == "" {
		return ErrInvalidRootArg
	}
	if in.ParentID == nil {
		switch in.RootKind {
		case RootKindOrg:
			if in.BoundPrincipal != nil {
				return ErrInvalidRootArg
			}
		case RootKindUser:
			if in.BoundPrincipal == nil {
				return ErrInvalidRootArg
			}
		default:
			return ErrInvalidRootArg
		}
	}
	return nil
}
