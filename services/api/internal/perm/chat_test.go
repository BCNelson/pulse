package perm_test

import (
	"context"
	"testing"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

func TestCanInRoomParticipant(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	roomID := mustCreateChatRoom(t, pool)
	mustAddParticipant(t, pool, roomID, alice)

	can, err := svc.CanInRoom(context.Background(), alice, roomID)
	if err != nil {
		t.Fatalf("CanInRoom: %v", err)
	}
	if !can {
		t.Errorf("participant should be able to see the room")
	}
}

func TestCanInRoomTagGrant(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "engineering")
	mustGrant(t, pool, root, alice, "viewer", true, nil)

	roomID := mustCreateChatRoom(t, pool)
	mustAddRoomTag(t, pool, roomID, root)

	can, err := svc.CanInRoom(context.Background(), alice, roomID)
	if err != nil {
		t.Fatalf("CanInRoom: %v", err)
	}
	if !can {
		t.Errorf("tag-grant holder should be able to see the room")
	}
}

func TestCanInRoomNeitherDenies(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	roomID := mustCreateChatRoom(t, pool)
	// alice is neither a participant nor has a tag grant.

	can, err := svc.CanInRoom(context.Background(), alice, roomID)
	if err != nil {
		t.Fatalf("CanInRoom: %v", err)
	}
	if can {
		t.Errorf("non-participant with no tag grant should be denied")
	}
}

func TestEffectiveInRoomParticipantUpgrades(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &perm.Service{DB: pool}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "alice")
	root := mustCreateTagRoot(t, tags, "engineering")
	mustGrant(t, pool, root, alice, "viewer", true, nil)

	roomID := mustCreateChatRoom(t, pool)
	mustAddRoomTag(t, pool, roomID, root)
	mustAddParticipant(t, pool, roomID, alice)

	// Viewer-via-tag would be Bundle=viewer; participant upgrades to contributor.
	bundle, err := svc.EffectiveInRoom(context.Background(), alice, roomID)
	if err != nil {
		t.Fatalf("EffectiveInRoom: %v", err)
	}
	if !bundle.AtLeast(perm.BundleContributor) {
		t.Errorf("participant should imply at least contributor; got %q", bundle)
	}
}

// --- helpers (chat-specific) ---

func mustCreateChatRoom(t *testing.T, pool *pgxpool.Pool) uuid.UUID {
	t.Helper()
	var id uuid.UUID
	if err := pool.QueryRow(context.Background(),
		`INSERT INTO chat_rooms DEFAULT VALUES RETURNING id`).Scan(&id); err != nil {
		t.Fatalf("create room: %v", err)
	}
	return id
}

func mustAddParticipant(t *testing.T, pool *pgxpool.Pool, roomID, principalID uuid.UUID) {
	t.Helper()
	if _, err := pool.Exec(context.Background(), `
        INSERT INTO chat_room_participants (chat_room_id, principal_id, role)
        VALUES ($1, $2, 'member')
    `, roomID, principalID); err != nil {
		t.Fatalf("add participant: %v", err)
	}
}

func mustAddRoomTag(t *testing.T, pool *pgxpool.Pool, roomID, tagID uuid.UUID) {
	t.Helper()
	if _, err := pool.Exec(context.Background(),
		`INSERT INTO chat_room_tags (chat_room_id, tag_id) VALUES ($1, $2)`, roomID, tagID); err != nil {
		t.Fatalf("add room tag: %v", err)
	}
}
