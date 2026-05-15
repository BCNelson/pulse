package tag_test

import (
	"context"
	"fmt"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

func TestCreateRootTagOrg(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &tag.Service{DB: pool}

	id, err := svc.Create(context.Background(), tag.CreateInput{
		Slug:        "engineering",
		DisplayName: "Engineering",
		RootKind:    tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root: %v", err)
	}

	depth, ok := readDepth(t, pool, id, id)
	if !ok || depth != 0 {
		t.Fatalf("self-edge missing or wrong depth: ok=%v depth=%d", ok, depth)
	}
}

func TestCreateChildTagsAndClosure(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &tag.Service{DB: pool}

	root := mustCreateRoot(t, svc, "engineering")
	backend := mustCreateChild(t, svc, root, "backend")
	billing := mustCreateChild(t, svc, backend, "billing")

	// root is ancestor of itself, backend, billing
	wantPairs := map[[2]int64]int{
		{root, root}:       0,
		{backend, backend}: 0,
		{billing, billing}: 0,
		{root, backend}:    1,
		{root, billing}:    2,
		{backend, billing}: 1,
	}
	for pair, wantDepth := range wantPairs {
		gotDepth, ok := readDepth(t, pool, pair[0], pair[1])
		if !ok {
			t.Errorf("missing closure edge ancestor=%d descendant=%d", pair[0], pair[1])
			continue
		}
		if gotDepth != wantDepth {
			t.Errorf("ancestor=%d descendant=%d: depth want=%d got=%d", pair[0], pair[1], wantDepth, gotDepth)
		}
	}
}

func TestMoveSubtreeRewritesClosure(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &tag.Service{DB: pool}

	root := mustCreateRoot(t, svc, "org")
	a := mustCreateChild(t, svc, root, "a")
	b := mustCreateChild(t, svc, root, "b")
	a1 := mustCreateChild(t, svc, a, "a1")
	a1x := mustCreateChild(t, svc, a1, "a1x")

	// Move a1 (subtree {a1, a1x}) from under a to under b.
	if err := svc.Move(context.Background(), a1, b); err != nil {
		t.Fatalf("move: %v", err)
	}

	// a1's old ancestor 'a' should no longer be an ancestor of a1 or a1x.
	if _, ok := readDepth(t, pool, a, a1); ok {
		t.Error("a should no longer be ancestor of a1")
	}
	if _, ok := readDepth(t, pool, a, a1x); ok {
		t.Error("a should no longer be ancestor of a1x")
	}
	// b should be ancestor of a1 (depth 1) and a1x (depth 2).
	if d, ok := readDepth(t, pool, b, a1); !ok || d != 1 {
		t.Errorf("b->a1: ok=%v depth=%d want 1", ok, d)
	}
	if d, ok := readDepth(t, pool, b, a1x); !ok || d != 2 {
		t.Errorf("b->a1x: ok=%v depth=%d want 2", ok, d)
	}
	// root should still be ancestor of every tag, with new depths.
	if d, _ := readDepth(t, pool, root, a1); d != 2 {
		t.Errorf("root->a1: depth=%d want 2", d)
	}
	if d, _ := readDepth(t, pool, root, a1x); d != 3 {
		t.Errorf("root->a1x: depth=%d want 3", d)
	}
	// Within-subtree edges preserved.
	if d, _ := readDepth(t, pool, a1, a1x); d != 1 {
		t.Errorf("a1->a1x: depth=%d want 1", d)
	}
}

func TestMoveCycleRefused(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &tag.Service{DB: pool}

	root := mustCreateRoot(t, svc, "org")
	a := mustCreateChild(t, svc, root, "a")
	a1 := mustCreateChild(t, svc, a, "a1")

	// Moving a under a1 (its own descendant) is a cycle.
	if err := svc.Move(context.Background(), a, a1); err != tag.ErrCycle {
		t.Fatalf("expected ErrCycle, got %v", err)
	}
	// Self-move is also a cycle (self-edge in closure).
	if err := svc.Move(context.Background(), a, a); err != tag.ErrCycle {
		t.Fatalf("expected ErrCycle on self-move, got %v", err)
	}
}

func TestMoveRootRefused(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &tag.Service{DB: pool}

	root := mustCreateRoot(t, svc, "org")
	other := mustCreateRoot(t, svc, "other")
	if err := svc.Move(context.Background(), root, other); err != tag.ErrRootMove {
		t.Fatalf("expected ErrRootMove, got %v", err)
	}
}

func TestArchiveCascades(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &tag.Service{DB: pool}

	root := mustCreateRoot(t, svc, "org")
	a := mustCreateChild(t, svc, root, "a")
	a1 := mustCreateChild(t, svc, a, "a1")

	if err := svc.Archive(context.Background(), a); err != nil {
		t.Fatalf("archive: %v", err)
	}

	if !isArchived(t, pool, a) {
		t.Error("a should be archived")
	}
	if !isArchived(t, pool, a1) {
		t.Error("a1 should be archived (cascade)")
	}
	if isArchived(t, pool, root) {
		t.Error("root should not be archived")
	}
}

func TestRebuildClosureMatchesIncremental(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &tag.Service{DB: pool}

	root := mustCreateRoot(t, svc, "org")
	for i := 0; i < 8; i++ {
		mustCreateChild(t, svc, root, fmt.Sprintf("child-%d", i))
	}
	// snapshot incremental closure
	before := dumpClosure(t, pool)

	if err := svc.RebuildClosure(context.Background()); err != nil {
		t.Fatalf("rebuild: %v", err)
	}
	after := dumpClosure(t, pool)

	if len(before) != len(after) {
		t.Fatalf("closure size differs: before=%d after=%d", len(before), len(after))
	}
	for k, v := range before {
		if after[k] != v {
			t.Errorf("edge %v: before=%d after=%d", k, v, after[k])
		}
	}
}

// TestStressBranchingTree builds a synthetic tree of ~1k tags and validates
// that RebuildClosure produces the same closure the incremental code did.
// The architecture risks section flags closure rebuild as the trickiest
// piece; this is the catch-net for "the SQL looks right but breaks on real
// shapes."
func TestStressBranchingTree(t *testing.T) {
	if testing.Short() {
		t.Skip("skipping stress test in -short")
	}
	pool := pgtest.Pool(t)
	svc := &tag.Service{DB: pool}

	// Build a tree: 1 root, 10 children, each with 10 children, each with 10
	// children. 1 + 10 + 100 + 1000 = 1111 tags, depth 3.
	root := mustCreateRoot(t, svc, "stress")
	const fanout = 10
	for i := 0; i < fanout; i++ {
		l1 := mustCreateChild(t, svc, root, fmt.Sprintf("l1-%d", i))
		for j := 0; j < fanout; j++ {
			l2 := mustCreateChild(t, svc, l1, fmt.Sprintf("l2-%d-%d", i, j))
			for k := 0; k < fanout; k++ {
				mustCreateChild(t, svc, l2, fmt.Sprintf("l3-%d-%d-%d", i, j, k))
			}
		}
	}

	// Snapshot incremental closure, rebuild, and compare.
	before := dumpClosure(t, pool)
	if err := svc.RebuildClosure(context.Background()); err != nil {
		t.Fatalf("rebuild: %v", err)
	}
	after := dumpClosure(t, pool)

	if len(before) != len(after) {
		t.Fatalf("closure size: before=%d after=%d", len(before), len(after))
	}
	for k, v := range before {
		if after[k] != v {
			t.Errorf("edge %v: before=%d after=%d", k, v, after[k])
		}
	}
}

// --- helpers ---

func mustCreateRoot(t *testing.T, svc *tag.Service, slug string) int64 {
	t.Helper()
	id, err := svc.Create(context.Background(), tag.CreateInput{
		Slug:        slug,
		DisplayName: slug,
		RootKind:    tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root %q: %v", slug, err)
	}
	return id
}

func mustCreateChild(t *testing.T, svc *tag.Service, parent int64, slug string) int64 {
	t.Helper()
	p := parent
	id, err := svc.Create(context.Background(), tag.CreateInput{
		ParentID:    &p,
		Slug:        slug,
		DisplayName: slug,
		RootKind:    tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create child %q under %d: %v", slug, parent, err)
	}
	return id
}

func readDepth(t *testing.T, pool *pgxpool.Pool, ancestor, descendant int64) (int, bool) {
	t.Helper()
	var depth int
	err := pool.QueryRow(context.Background(),
		`SELECT depth FROM tag_closure WHERE ancestor_id = $1 AND descendant_id = $2`,
		ancestor, descendant).Scan(&depth)
	if err != nil {
		return 0, false
	}
	return depth, true
}

func isArchived(t *testing.T, pool *pgxpool.Pool, id int64) bool {
	t.Helper()
	var archived bool
	if err := pool.QueryRow(context.Background(),
		`SELECT archived_at IS NOT NULL FROM tags WHERE id = $1`, id).Scan(&archived); err != nil {
		t.Fatalf("read archived: %v", err)
	}
	return archived
}

func dumpClosure(t *testing.T, pool *pgxpool.Pool) map[[2]int64]int {
	t.Helper()
	rows, err := pool.Query(context.Background(), `SELECT ancestor_id, descendant_id, depth FROM tag_closure`)
	if err != nil {
		t.Fatalf("dump closure: %v", err)
	}
	defer rows.Close()
	out := make(map[[2]int64]int)
	for rows.Next() {
		var a, d int64
		var depth int
		if err := rows.Scan(&a, &d, &depth); err != nil {
			t.Fatalf("scan: %v", err)
		}
		out[[2]int64{a, d}] = depth
	}
	if err := rows.Err(); err != nil {
		t.Fatalf("rows err: %v", err)
	}
	return out
}
