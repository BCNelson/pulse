package audit_test

import (
	"context"
	"encoding/json"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestWriteRecordsActingAndEffective(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &audit.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "Alice")
	bob := mustCreatePrincipal(t, pool, "Bob")
	target := ids.New(ids.KindUser)

	ctx := auth.WithIdentity(context.Background(), auth.Identity{
		ActingID:    alice,
		EffectiveID: bob, // simulating an impersonation session
	})
	err := svc.Write(ctx, audit.Event{
		Action:     "tag.move",
		TargetType: "tag",
		TargetID:   target,
		Diff:       json.RawMessage(`{"gained":1,"lost":0}`),
		Reason:     "scheduled reorg",
	})
	if err != nil {
		t.Fatalf("Write: %v", err)
	}

	var actingID, effectiveID int64
	var action, targetType, reason string
	var diff []byte
	err = pool.QueryRow(context.Background(), `
        SELECT acting_id, effective_id, action, target_type, diff, reason
        FROM audit_events ORDER BY id DESC LIMIT 1
    `).Scan(&actingID, &effectiveID, &action, &targetType, &diff, &reason)
	if err != nil {
		t.Fatalf("read back: %v", err)
	}
	if actingID != alice {
		t.Errorf("acting_id: want %d got %d", alice, actingID)
	}
	if effectiveID != bob {
		t.Errorf("effective_id: want %d got %d", bob, effectiveID)
	}
	if action != "tag.move" {
		t.Errorf("action: %q", action)
	}
	if reason != "scheduled reorg" {
		t.Errorf("reason: %q", reason)
	}
}

func TestWriteAnonymousErrors(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &audit.Service{DB: pool}

	err := svc.Write(context.Background(), audit.Event{
		Action:     "tag.move",
		TargetType: "tag",
		TargetID:   ids.New(ids.KindUser),
	})
	if err != audit.ErrNoIdentity {
		t.Fatalf("expected ErrNoIdentity, got %v", err)
	}
}

func mustCreatePrincipal(t *testing.T, pool *pgxpool.Pool, name string) int64 {
	t.Helper()
	id := ids.New(ids.KindUser)
	_, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name)
        VALUES ($1, 'user', 'active', $2, $3)
    `, id, "local://principals/"+ids.FormatID(id), name)
	if err != nil {
		t.Fatalf("insert principal: %v", err)
	}
	return id
}
