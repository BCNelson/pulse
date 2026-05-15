package perm

import (
	"context"
	"fmt"
)

// CanInRoom evaluates chat-room visibility. Two paths grant access:
//  1. Direct participation — the viewer has an active chat_room_participants row.
//  2. Tag-based — the room has at least one tag and the viewer holds a
//     cascading view-or-better grant on (an ancestor of) that tag.
//
// M3 collapses view/send/moderate into a single Boolean; per-action role
// flags on messages aren't in v1 scope. M5 may layer admin-only mutations
// (rename room, kick participants) on top of this check by calling
// EffectiveInRoom.
func (s *Service) CanInRoom(ctx context.Context, viewer, roomID int64) (bool, error) {
	// Cheap path first: participant?
	var isParticipant bool
	if err := s.DB.QueryRow(ctx, `
        SELECT EXISTS (
          SELECT 1 FROM chat_room_participants
          WHERE chat_room_id = $1 AND principal_id = $2 AND left_at IS NULL
        )
    `, roomID, viewer).Scan(&isParticipant); err != nil {
		return false, fmt.Errorf("check participant: %w", err)
	}
	if isParticipant {
		return true, nil
	}

	// Tag-based fallback: viewer holds a (cascading) grant on any of the
	// room's attached tags.
	var canViaTag bool
	if err := s.DB.QueryRow(ctx, `
        SELECT EXISTS (
          SELECT 1 FROM chat_room_tags crt
          JOIN tag_closure c ON c.descendant_id = crt.tag_id
          JOIN tag_grants  g ON g.tag_id = c.ancestor_id
          WHERE crt.chat_room_id = $1
            AND g.principal_id = $2
            AND (c.depth = 0 OR g.cascade = TRUE)
        )
    `, roomID, viewer).Scan(&canViaTag); err != nil {
		return false, fmt.Errorf("check tag grant: %w", err)
	}
	return canViaTag, nil
}

// EffectiveInRoom returns the viewer's max bundle across attached tags.
// Direct participants get an implicit Contributor bundle (they can speak
// even without an explicit tag grant). M5 will likely add per-room admin
// roles (kick, rename) layered on top of this.
func (s *Service) EffectiveInRoom(ctx context.Context, viewer, roomID int64) (Bundle, error) {
	var isParticipant bool
	if err := s.DB.QueryRow(ctx, `
        SELECT EXISTS (
          SELECT 1 FROM chat_room_participants
          WHERE chat_room_id = $1 AND principal_id = $2 AND left_at IS NULL
        )
    `, roomID, viewer).Scan(&isParticipant); err != nil {
		return BundleNone, fmt.Errorf("check participant: %w", err)
	}

	rows, err := s.DB.Query(ctx, `
        SELECT crt.tag_id FROM chat_room_tags crt WHERE crt.chat_room_id = $1
    `, roomID)
	if err != nil {
		return BundleNone, fmt.Errorf("load room tags: %w", err)
	}
	defer rows.Close()

	max := BundleNone
	for rows.Next() {
		var tagID int64
		if err := rows.Scan(&tagID); err != nil {
			return BundleNone, err
		}
		bundle, _, err := s.EffectiveOnTag(ctx, viewer, tagID)
		if err != nil {
			return BundleNone, err
		}
		if bundle.rank() > max.rank() {
			max = bundle
		}
	}
	if err := rows.Err(); err != nil {
		return BundleNone, err
	}

	if isParticipant && max.rank() < BundleContributor.rank() {
		max = BundleContributor
	}
	return max, nil
}

// RoomVisibilityPredicateSQL returns a Postgres EXISTS fragment that
// passes when the viewer can see the named room — either as a
// participant or via a tag grant. Compose into list queries (e.g. a
// "rooms I can see" page).
func RoomVisibilityPredicateSQL(roomIDColumn, viewerParam string) string {
	return fmt.Sprintf(`
        (
          EXISTS (
            SELECT 1 FROM chat_room_participants p
            WHERE p.chat_room_id = %s AND p.principal_id = %s AND p.left_at IS NULL
          )
          OR EXISTS (
            SELECT 1 FROM chat_room_tags crt
            JOIN tag_closure c ON c.descendant_id = crt.tag_id
            JOIN tag_grants  g ON g.tag_id = c.ancestor_id
            WHERE crt.chat_room_id = %s
              AND g.principal_id = %s
              AND (c.depth = 0 OR g.cascade = TRUE)
          )
        )
    `, roomIDColumn, viewerParam, roomIDColumn, viewerParam)
}
