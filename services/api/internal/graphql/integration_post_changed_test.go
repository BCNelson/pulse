package graphql_test

import (
	"context"
	"encoding/json"
	"log/slog"
	"os"
	"testing"
	"time"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/realtime"
	"github.com/bcnelson/pulse/services/api/internal/search"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// TestPostChangedDescendantFanout verifies that PostChanged(includeDescendants:true)
// receives events published on a descendant tag's topic, while a parallel
// subscriber with includeDescendants=false only sees events on its own tag.
func TestPostChangedDescendantFanout(t *testing.T) {
	pool, dsn := pgtest.PoolAndDSN(t)
	authSvc := &auth.Service{DB: pool}
	postSvc := &post.Service{DB: pool}

	alice := mustSeedUser(t, pool, authSvc, "alice@example.com", "Alice", "alice-pw")

	tags := &tag.Service{DB: pool}
	rootID, err := tags.Create(context.Background(), tag.CreateInput{
		Slug: "org", DisplayName: "Org", RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root: %v", err)
	}
	mustGrant(t, pool, rootID, alice, "owner", true)
	childID, err := tags.Create(context.Background(), tag.CreateInput{
		ParentID: &rootID, Slug: "team-a", DisplayName: "Team A", RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create child: %v", err)
	}

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	dispatcher, err := realtime.New(ctx, dsn, slog.New(slog.NewTextHandler(os.Stderr, nil)))
	if err != nil {
		t.Fatalf("realtime: %v", err)
	}

	resolver := &pulsegraphql.Resolver{
		DB: pool, Auth: authSvc, Perm: &perm.Service{DB: pool},
		Tags: tags, Audit: &audit.Service{DB: pool},
		Posts: postSvc, Comments: &comment.Service{DB: pool},
		Search: &search.Service{DB: pool}, Realtime: dispatcher,
	}

	// Need a real post so the subscriber's CanOnPost check passes. Attach
	// it to the child tag so descendant fan-out is what surfaces it under
	// the root subscriber.
	postID, err := postSvc.Create(ctx, post.CreateInput{
		AuthorID: alice, Title: "hi", Body: "hi",
		Tags: []post.TagAttachment{{TagID: childID, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	if err != nil {
		t.Fatalf("create post: %v", err)
	}

	aliceCtx := perm.WithRequestCache(auth.WithIdentity(ctx, auth.Identity{
		ActingID: alice, EffectiveID: alice,
	}))

	trueVal := true
	deepCh, err := resolver.Subscription().PostChanged(aliceCtx, ids.FormatID(rootID), &trueVal)
	if err != nil {
		t.Fatalf("PostChanged deep: %v", err)
	}
	shallowCh, err := resolver.Subscription().PostChanged(aliceCtx, ids.FormatID(rootID), nil)
	if err != nil {
		t.Fatalf("PostChanged shallow: %v", err)
	}

	// Give the subscriber goroutines a moment to register their Subscribe
	// calls before the publish.
	time.Sleep(50 * time.Millisecond)

	payload, _ := json.Marshal(map[string]any{"post_id": ids.FormatID(postID)})
	dispatcher.Publish(realtime.Event{
		Topic: "posts.tag." + ids.FormatID(childID), Payload: payload,
	})

	// Deep subscriber receives the descendant event.
	select {
	case got := <-deepCh:
		if got == nil {
			t.Fatal("deep got nil post")
		}
		if got.ID != ids.FormatID(postID) {
			t.Errorf("deep id: %q want %q", got.ID, ids.FormatID(postID))
		}
	case <-time.After(2 * time.Second):
		t.Fatal("deep subscription did not deliver")
	}

	// Shallow subscriber must NOT receive the descendant event.
	select {
	case got := <-shallowCh:
		t.Errorf("shallow subscriber leaked a descendant event: %+v", got)
	case <-time.After(300 * time.Millisecond):
	}
}

// TestPostChangedFromProductionCreate exercises the real pg_notify path:
// post.Service.Create emits posts.tag.<tagID> inside its transaction; the
// dispatcher's LISTEN connection delivers it to the subscriber. No
// dispatcher.Publish shortcut.
func TestPostChangedFromProductionCreate(t *testing.T) {
	pool, dsn := pgtest.PoolAndDSN(t)
	authSvc := &auth.Service{DB: pool}
	postSvc := &post.Service{DB: pool}

	alice := mustSeedUser(t, pool, authSvc, "alice@example.com", "Alice", "alice-pw")

	tags := &tag.Service{DB: pool}
	rootID, err := tags.Create(context.Background(), tag.CreateInput{
		Slug: "org", DisplayName: "Org", RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root: %v", err)
	}
	mustGrant(t, pool, rootID, alice, "owner", true)

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	dispatcher, err := realtime.New(ctx, dsn, slog.New(slog.NewTextHandler(os.Stderr, nil)))
	if err != nil {
		t.Fatalf("realtime: %v", err)
	}

	resolver := &pulsegraphql.Resolver{
		DB: pool, Auth: authSvc, Perm: &perm.Service{DB: pool},
		Tags: tags, Audit: &audit.Service{DB: pool},
		Posts: postSvc, Comments: &comment.Service{DB: pool},
		Search: &search.Service{DB: pool}, Realtime: dispatcher,
	}

	aliceCtx := perm.WithRequestCache(auth.WithIdentity(ctx, auth.Identity{
		ActingID: alice, EffectiveID: alice,
	}))

	ch, err := resolver.Subscription().PostChanged(aliceCtx, ids.FormatID(rootID), nil)
	if err != nil {
		t.Fatalf("PostChanged: %v", err)
	}
	// Let the subscriber goroutine register before the create fires.
	time.Sleep(50 * time.Millisecond)

	postID, err := postSvc.Create(ctx, post.CreateInput{
		AuthorID: alice, Title: "hi", Body: "hi",
		Tags: []post.TagAttachment{{TagID: rootID, ViewRole: true, InteractRole: true, ModerateRole: true}},
	})
	if err != nil {
		t.Fatalf("create post: %v", err)
	}

	select {
	case got := <-ch:
		if got == nil {
			t.Fatal("got nil post from subscription")
		}
		if got.ID != ids.FormatID(postID) {
			t.Errorf("post id: %q want %q", got.ID, ids.FormatID(postID))
		}
	case <-time.After(2 * time.Second):
		t.Fatal("subscriber did not receive event from production Create path")
	}
}
