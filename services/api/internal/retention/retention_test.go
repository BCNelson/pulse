package retention_test

import (
	"context"
	"testing"
	"time"

	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/retention"
)

func TestSweepPurgesPastCutoff(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	// 30-day retention for the test.
	if _, err := pool.Exec(ctx,
		`UPDATE workspace_config SET retention_window_days = 30 WHERE id = 1`); err != nil {
		t.Fatalf("set retention: %v", err)
	}

	// Seed: two principals, one post, one comment. Soft-delete one
	// fresh and one ancient.
	authorID := uuid.New()
	tagID := uuid.New()
	if _, err := pool.Exec(ctx, `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, 'A', 'a@example.com')
    `, authorID, "local://principals/"+authorID.String()); err != nil {
		t.Fatalf("seed: %v", err)
	}
	if _, err := pool.Exec(ctx, `
        INSERT INTO tags (id, parent_id, slug, display_name, root_kind, defaults)
        VALUES ($1, NULL, 'org', 'Org', 'org', '{}')
    `, tagID); err != nil {
		t.Fatalf("seed tag: %v", err)
	}
	if _, err := pool.Exec(ctx,
		`INSERT INTO tag_closure (ancestor_id, descendant_id, depth) VALUES ($1, $1, 0)`,
		tagID); err != nil {
		t.Fatalf("closure: %v", err)
	}

	freshID := uuid.New()
	oldID := uuid.New()
	old := time.Now().Add(-90 * 24 * time.Hour)
	for _, p := range []struct {
		id        uuid.UUID
		deletedAt *time.Time
	}{
		{freshID, ptrTime(time.Now().Add(-24 * time.Hour))}, // 1 day ago, kept
		{oldID, &old}, // 90 days ago, purged
	} {
		if _, err := pool.Exec(ctx, `
            INSERT INTO posts (id, title, body, author_id, deleted_at)
            VALUES ($1, 'old', 'old', $2, $3)
        `, p.id, authorID, p.deletedAt); err != nil {
			t.Fatalf("seed post %s: %v", p.id, err)
		}
		if _, err := pool.Exec(ctx,
			`INSERT INTO post_tags (post_id, tag_id) VALUES ($1, $2)`, p.id, tagID); err != nil {
			t.Fatalf("post_tag: %v", err)
		}
	}

	svc := &retention.Service{DB: pool}
	res, err := svc.Sweep(ctx)
	if err != nil {
		t.Fatalf("sweep: %v", err)
	}
	if res.Posts != 1 {
		t.Errorf("posts: got %d want 1 (only the 90-day-old one)", res.Posts)
	}
	var remaining int
	if err := pool.QueryRow(ctx, `SELECT count(*) FROM posts`).Scan(&remaining); err != nil {
		t.Fatalf("count: %v", err)
	}
	if remaining != 1 {
		t.Errorf("remaining: got %d want 1", remaining)
	}
}

func ptrTime(t time.Time) *time.Time { return &t }
