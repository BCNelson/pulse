package chat_test

import (
	"context"
	"testing"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/chat"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

func TestCreateRoomTwoUsersIsDM(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &chat.Service{DB: pool, Posts: &post.Service{DB: pool}}

	alice := mustCreatePrincipal(t, pool, "user", "Alice")
	bob := mustCreatePrincipal(t, pool, "user", "Bob")

	roomID, err := svc.CreateRoom(context.Background(), chat.CreateRoomInput{
		Participants: []chat.ParticipantInput{
			{PrincipalID: alice}, {PrincipalID: bob},
		},
	})
	if err != nil {
		t.Fatalf("create room: %v", err)
	}
	room, err := svc.GetRoom(context.Background(), roomID)
	if err != nil {
		t.Fatalf("get room: %v", err)
	}
	if !room.IsDM {
		t.Errorf("two-user room with no tags should be a DM")
	}
}

func TestAddTagFlipsIsDM(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &chat.Service{DB: pool, Posts: &post.Service{DB: pool}}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "user", "Alice")
	bob := mustCreatePrincipal(t, pool, "user", "Bob")
	root := mustCreateTagRoot(t, tags, "engineering")

	roomID, _ := svc.CreateRoom(context.Background(), chat.CreateRoomInput{
		Participants: []chat.ParticipantInput{
			{PrincipalID: alice}, {PrincipalID: bob},
		},
	})
	if room, _ := svc.GetRoom(context.Background(), roomID); !room.IsDM {
		t.Fatalf("expected DM before tag")
	}

	// Architecture's "DM → team space" promotion: attach an org tag.
	if err := svc.AddTag(context.Background(), roomID, root); err != nil {
		t.Fatalf("add tag: %v", err)
	}
	room, _ := svc.GetRoom(context.Background(), roomID)
	if room.IsDM {
		t.Errorf("attaching org tag should clear is_dm")
	}
}

func TestBotParticipantBlocksDM(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &chat.Service{DB: pool, Posts: &post.Service{DB: pool}}

	alice := mustCreatePrincipal(t, pool, "user", "Alice")
	notifyBot := mustCreatePrincipal(t, pool, "bot", "Notifier")

	roomID, _ := svc.CreateRoom(context.Background(), chat.CreateRoomInput{
		Participants: []chat.ParticipantInput{
			{PrincipalID: alice}, {PrincipalID: notifyBot},
		},
	})
	room, _ := svc.GetRoom(context.Background(), roomID)
	if room.IsDM {
		t.Errorf("a bot participant should block DM rendering")
	}
}

func TestSendAndList(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &chat.Service{DB: pool, Posts: &post.Service{DB: pool}}

	alice := mustCreatePrincipal(t, pool, "user", "Alice")
	roomID, _ := svc.CreateRoom(context.Background(), chat.CreateRoomInput{
		Participants: []chat.ParticipantInput{{PrincipalID: alice}},
	})
	if _, err := svc.SendMessage(context.Background(), chat.SendInput{
		RoomID: roomID, AuthorID: alice, Body: "first message",
	}); err != nil {
		t.Fatalf("send: %v", err)
	}
	if _, err := svc.SendMessage(context.Background(), chat.SendInput{
		RoomID: roomID, AuthorID: alice, Body: "second message",
	}); err != nil {
		t.Fatalf("send: %v", err)
	}
	msgs, err := svc.ListMessages(context.Background(), roomID, 10)
	if err != nil {
		t.Fatalf("list: %v", err)
	}
	if len(msgs) != 2 {
		t.Errorf("expected 2 messages, got %d", len(msgs))
	}
}

func TestPromoteMessageCreatesPost(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &chat.Service{DB: pool, Posts: &post.Service{DB: pool}}
	tags := &tag.Service{DB: pool}

	alice := mustCreatePrincipal(t, pool, "user", "Alice")
	root := mustCreateTagRoot(t, tags, "engineering")

	roomID, _ := svc.CreateRoom(context.Background(), chat.CreateRoomInput{
		Tags:         []uuid.UUID{root},
		Participants: []chat.ParticipantInput{{PrincipalID: alice}},
	})
	msgID, _ := svc.SendMessage(context.Background(), chat.SendInput{
		RoomID: roomID, AuthorID: alice, Body: "this should be a post.",
	})

	postID, err := svc.PromoteMessage(context.Background(), msgID, alice)
	if err != nil {
		t.Fatalf("promote: %v", err)
	}
	if postID == uuid.Nil {
		t.Fatal("expected a post id")
	}
	// The message should now be linked.
	msg, _ := svc.GetMessage(context.Background(), msgID)
	if msg.PromotedToPost == nil || *msg.PromotedToPost != postID {
		t.Errorf("expected promoted_to_post = %s, got %v", postID, msg.PromotedToPost)
	}
	// Promoting again returns ErrAlreadyPromoted.
	if _, err := svc.PromoteMessage(context.Background(), msgID, alice); err != chat.ErrAlreadyPromoted {
		t.Errorf("expected ErrAlreadyPromoted, got %v", err)
	}
}

func TestPromoteRequiresTag(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &chat.Service{DB: pool, Posts: &post.Service{DB: pool}}

	alice := mustCreatePrincipal(t, pool, "user", "Alice")
	roomID, _ := svc.CreateRoom(context.Background(), chat.CreateRoomInput{
		Participants: []chat.ParticipantInput{{PrincipalID: alice}},
	})
	msgID, _ := svc.SendMessage(context.Background(), chat.SendInput{
		RoomID: roomID, AuthorID: alice, Body: "no tag, no promotion",
	})
	if _, err := svc.PromoteMessage(context.Background(), msgID, alice); err != chat.ErrPromoteDM {
		t.Errorf("expected ErrPromoteDM for tag-less room, got %v", err)
	}
}

// --- helpers ---

func mustCreatePrincipal(t *testing.T, pool *pgxpool.Pool, kind, name string) uuid.UUID {
	t.Helper()
	id := uuid.New()
	_, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name)
        VALUES ($1, $2, 'active', $3, $4)
    `, id, kind, "local://principals/"+id.String(), name)
	if err != nil {
		t.Fatalf("insert principal: %v", err)
	}
	return id
}

func mustCreateTagRoot(t *testing.T, svc *tag.Service, slug string) uuid.UUID {
	t.Helper()
	id, err := svc.Create(context.Background(), tag.CreateInput{
		Slug: slug, DisplayName: slug, RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root: %v", err)
	}
	return id
}
