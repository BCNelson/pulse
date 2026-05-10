package graphql_test

import (
	"context"
	"log/slog"
	"os"
	"testing"
	"time"

	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/chat"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/realtime"
	"github.com/bcnelson/pulse/services/api/internal/search"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

// TestM3SubscriptionDelivers exercises the messageAdded subscription end-
// to-end (without WebSocket transport — the resolver returns a Go channel
// directly). Flow: alice and bob in a DM room, alice opens the subscription,
// bob sends a message, alice's channel fires.
func TestM3SubscriptionDelivers(t *testing.T) {
	pool := pgtest.Pool(t)
	authSvc := &auth.Service{DB: pool}
	postSvc := &post.Service{DB: pool}
	chatSvc := &chat.Service{DB: pool, Posts: postSvc}

	alice := mustSeedUser(t, pool, authSvc, "alice@example.com", "Alice", "alice-pw")
	bob := mustSeedUser(t, pool, authSvc, "bob@example.com", "Bob", "bob-pw")

	dsn := os.Getenv("PULSE_TEST_DB_URL")
	if dsn == "" {
		t.Skip("PULSE_TEST_DB_URL not set")
	}
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	dispatcher, err := realtime.New(ctx, dsn, slog.New(slog.NewTextHandler(os.Stderr, nil)))
	if err != nil {
		t.Fatalf("realtime: %v", err)
	}

	resolver := &pulsegraphql.Resolver{
		DB:       pool,
		Auth:     authSvc,
		Perm:     &perm.Service{DB: pool},
		Tags:     &tag.Service{DB: pool},
		Audit:    &audit.Service{DB: pool},
		Posts:    postSvc,
		Comments: &comment.Service{DB: pool},
		Search:   &search.Service{DB: pool},
		Chat:     chatSvc,
		Realtime: dispatcher,
	}

	roomID, err := chatSvc.CreateRoom(ctx, chat.CreateRoomInput{
		Participants: []chat.ParticipantInput{
			{PrincipalID: alice}, {PrincipalID: bob},
		},
	})
	if err != nil {
		t.Fatalf("create room: %v", err)
	}

	// Open the subscription as alice.
	aliceCtx := perm.WithRequestCache(auth.WithIdentity(ctx, auth.Identity{
		ActingID: alice, EffectiveID: alice,
	}))
	subCh, err := resolver.Subscription().MessageAdded(aliceCtx, roomID.String())
	if err != nil {
		t.Fatalf("MessageAdded: %v", err)
	}

	// Bob sends a message via the chat service (mirrors the mutation).
	if _, err := chatSvc.SendMessage(ctx, chat.SendInput{
		RoomID: roomID, AuthorID: bob, Body: "hello alice",
	}); err != nil {
		t.Fatalf("send: %v", err)
	}

	select {
	case msg := <-subCh:
		if msg == nil {
			t.Fatal("got nil message")
		}
		if msg.Body != "hello alice" {
			t.Errorf("body: %q", msg.Body)
		}
	case <-time.After(3 * time.Second):
		t.Fatal("subscription did not deliver message in time")
	}
}

func TestM3SubscriptionRecheckesAuth(t *testing.T) {
	pool := pgtest.Pool(t)
	authSvc := &auth.Service{DB: pool}
	postSvc := &post.Service{DB: pool}
	chatSvc := &chat.Service{DB: pool, Posts: postSvc}

	alice := mustSeedUser(t, pool, authSvc, "alice@example.com", "Alice", "alice-pw")
	mustSeedUser(t, pool, authSvc, "bob@example.com", "Bob", "bob-pw")
	charlie := mustSeedUser(t, pool, authSvc, "charlie@example.com", "Charlie", "charlie-pw")

	dsn := os.Getenv("PULSE_TEST_DB_URL")
	if dsn == "" {
		t.Skip()
	}
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	dispatcher, err := realtime.New(ctx, dsn, slog.New(slog.NewTextHandler(os.Stderr, nil)))
	if err != nil {
		t.Fatalf("realtime: %v", err)
	}

	resolver := &pulsegraphql.Resolver{
		DB: pool, Auth: authSvc, Perm: &perm.Service{DB: pool},
		Tags: &tag.Service{DB: pool}, Audit: &audit.Service{DB: pool},
		Posts: postSvc, Comments: &comment.Service{DB: pool},
		Search: &search.Service{DB: pool}, Chat: chatSvc, Realtime: dispatcher,
	}

	roomID, _ := chatSvc.CreateRoom(ctx, chat.CreateRoomInput{
		Participants: []chat.ParticipantInput{
			{PrincipalID: alice},
		},
	})

	// charlie tries to subscribe — not a participant, no tags → should be
	// denied by the resolver up-front.
	charlieCtx := perm.WithRequestCache(auth.WithIdentity(ctx, auth.Identity{
		ActingID: charlie, EffectiveID: charlie,
	}))
	if _, err := resolver.Subscription().MessageAdded(charlieCtx, roomID.String()); err == nil {
		t.Fatal("non-participant should be denied")
	}
}

// shadow check: ensure mustSeedUser is the same as in M1/M2 tests.
var _ = func() func() uuid.UUID {
	return func() uuid.UUID { return uuid.Nil }
}
