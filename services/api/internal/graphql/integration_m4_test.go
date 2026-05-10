package graphql_test

import (
	"context"
	"log/slog"
	"net/http/httptest"
	"os"
	"testing"
	"time"

	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/internal/audit"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/chat"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	pulsegraphql "github.com/bcnelson/pulse/services/api/internal/graphql"
	"github.com/bcnelson/pulse/services/api/internal/job"
	"github.com/bcnelson/pulse/services/api/internal/notification"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/realtime"
	"github.com/bcnelson/pulse/services/api/internal/search"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/internal/task"
)

// TestM4TaskAndNotifications exercises the M4 surface end-to-end:
//  1. alice creates a task tagged under root with bob as assignee.
//  2. The notification.fanout job runs and writes a notification for bob
//     (reason=assignment, urgency=high).
//  3. bob queries his inbox and sees the notification.
//  4. charlie (no grant on the tag) cannot see the task.
//  5. bob marks the notification read; the unread count drops to zero.
func TestM4TaskAndNotifications(t *testing.T) {
	pool := pgtest.Pool(t)
	authSvc := &auth.Service{DB: pool}

	alice := mustSeedUser(t, pool, authSvc, "alice@example.com", "Alice", "alice-pw-123")
	bob := mustSeedUser(t, pool, authSvc, "bob@example.com", "Bob", "bob-pw-123")
	mustSeedUser(t, pool, authSvc, "charlie@example.com", "Charlie", "charlie-pw-123")

	tags := &tag.Service{DB: pool}
	rootID, err := tags.Create(context.Background(), tag.CreateInput{
		Slug: "org", DisplayName: "Org", RootKind: tag.RootKindOrg,
	})
	if err != nil {
		t.Fatalf("create root: %v", err)
	}
	mustGrant(t, pool, rootID, alice, "owner", true)
	mustGrant(t, pool, rootID, bob, "contributor", true)
	// charlie has no grant on root.

	postSvc := &post.Service{DB: pool}
	taskSvc := &task.Service{DB: pool}
	notifSvc := &notification.Service{DB: pool}

	resolver := &pulsegraphql.Resolver{
		DB:            pool,
		Auth:          authSvc,
		Perm:          &perm.Service{DB: pool},
		Tags:          tags,
		Audit:         &audit.Service{DB: pool},
		Posts:         postSvc,
		Comments:      &comment.Service{DB: pool},
		Search:        &search.Service{DB: pool},
		Chat:          &chat.Service{DB: pool, Posts: postSvc},
		Tasks:         taskSvc,
		Notifications: notifSvc,
	}
	ts := httptest.NewServer(buildM2Server(resolver, authSvc))
	t.Cleanup(ts.Close)

	aliceTok := loginAs(t, ts.URL, "alice@example.com", "alice-pw-123")
	bobTok := loginAs(t, ts.URL, "bob@example.com", "bob-pw-123")
	charlieTok := loginAs(t, ts.URL, "charlie@example.com", "charlie-pw-123")

	// alice creates a task assigned to bob.
	createResp := gqlPost(t, ts.URL, aliceTok, `
        mutation($t:ID!, $b:ID!) {
          createTask(input:{
            title:"Migrate elephants to staging",
            description:"Pre-flight checklist before prod migration",
            tags:[{tagId:$t}],
            assignees:[$b]
          }) {
            id title status
            assignees { displayName }
            myPermissions { canView canContribute canModerate }
          }
        }`, map[string]any{"t": rootID.String(), "b": bob.String()})
	assertNoErrors(t, createResp)
	taskID := createResp.path("data", "createTask", "id").(string)
	if taskID == "" {
		t.Fatal("no task id")
	}
	if assigneesAny := createResp.path("data", "createTask", "assignees").([]any); len(assigneesAny) != 1 {
		t.Errorf("expected one assignee, got %d", len(assigneesAny))
	}

	// Run the worker once to dispatch the notification.fanout job.
	registry := job.NewRegistry()
	registry.Register("notification.fanout", notifSvc.Handler)
	worker := &job.Worker{
		DB: pool, Registry: registry,
		Logger:     slog.New(slog.NewTextHandler(os.Stderr, nil)),
		BatchSize:  4,
		WorkerName: "test-worker",
	}
	if _, err := worker.RunOnce(context.Background()); err != nil {
		t.Fatalf("worker: %v", err)
	}

	// bob's inbox should have the assignment notification.
	inboxResp := gqlPost(t, ts.URL, bobTok, `
        query {
          notifications(first:10) {
            edges { node { reason urgency sourceType source { __typename ... on Task { title } } } }
            unreadCount
          }
        }`, nil)
	assertNoErrors(t, inboxResp)
	edges := inboxResp.path("data", "notifications", "edges").([]any)
	if len(edges) == 0 {
		t.Fatalf("bob should have an assignment notification; got 0")
	}
	first := edges[0].(map[string]any)["node"].(map[string]any)
	if first["reason"] != "ASSIGNMENT" {
		t.Errorf("reason: got %v", first["reason"])
	}
	if first["urgency"] != "HIGH" {
		t.Errorf("urgency: got %v", first["urgency"])
	}
	if first["sourceType"] != "task" {
		t.Errorf("sourceType: got %v", first["sourceType"])
	}
	src := first["source"].(map[string]any)
	if src["__typename"] != "Task" {
		t.Errorf("source __typename: got %v", src["__typename"])
	}
	if src["title"] != "Migrate elephants to staging" {
		t.Errorf("source title: got %v", src["title"])
	}
	unread := inboxResp.path("data", "notifications", "unreadCount").(float64)
	if unread != 1 {
		t.Errorf("unreadCount: got %v want 1", unread)
	}

	// charlie cannot see the task (no grant on the tag).
	charlieResp := gqlPost(t, ts.URL, charlieTok, `query($id:ID!){ task(id:$id){ id title } }`,
		map[string]any{"id": taskID})
	assertNoErrors(t, charlieResp)
	if got := charlieResp.path("data", "task"); got != nil {
		t.Errorf("charlie should not see the task; got %v", got)
	}

	// bob marks all notifications read; unreadCount drops to zero.
	markResp := gqlPost(t, ts.URL, bobTok, `mutation { markAllNotificationsRead }`, nil)
	assertNoErrors(t, markResp)

	inboxResp2 := gqlPost(t, ts.URL, bobTok, `
        query { notifications(first:10) { unreadCount } }`, nil)
	assertNoErrors(t, inboxResp2)
	if got := inboxResp2.path("data", "notifications", "unreadCount").(float64); got != 0 {
		t.Errorf("unreadCount after mark-read: got %v want 0", got)
	}

	// bob transitions the task to in_progress.
	statusResp := gqlPost(t, ts.URL, bobTok, `
        mutation($id:ID!){ setTaskStatus(taskId:$id, status:IN_PROGRESS){ status } }`,
		map[string]any{"id": taskID})
	assertNoErrors(t, statusResp)
	if got := statusResp.path("data", "setTaskStatus", "status"); got != "IN_PROGRESS" {
		t.Errorf("status: got %v", got)
	}

	// alice queries Tag.tasks and sees the task.
	tasksResp := gqlPost(t, ts.URL, aliceTok, `
        query($t:ID!){ tag(id:$t){ tasks(first:10) { edges { node { title status } } } } }`,
		map[string]any{"t": rootID.String()})
	assertNoErrors(t, tasksResp)
	taskEdges := tasksResp.path("data", "tag", "tasks", "edges").([]any)
	if len(taskEdges) != 1 {
		t.Errorf("expected 1 task under tag, got %d", len(taskEdges))
	}
}

// TestM4NotificationSubscription drives the notificationReceived
// subscription end-to-end through the realtime dispatcher.
func TestM4NotificationSubscription(t *testing.T) {
	pool, dsn := pgtest.PoolAndDSN(t)
	authSvc := &auth.Service{DB: pool}

	alice := mustSeedUser(t, pool, authSvc, "alice@example.com", "Alice", "alice-pw-123")
	bob := mustSeedUser(t, pool, authSvc, "bob@example.com", "Bob", "bob-pw-123")

	tags := &tag.Service{DB: pool}
	rootID, _ := tags.Create(context.Background(), tag.CreateInput{
		Slug: "org", DisplayName: "Org", RootKind: tag.RootKindOrg,
	})
	mustGrant(t, pool, rootID, alice, "owner", true)
	mustGrant(t, pool, rootID, bob, "contributor", true)

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	dispatcher, err := realtime.New(ctx, dsn, slog.New(slog.NewTextHandler(os.Stderr, nil)))
	if err != nil {
		t.Fatalf("realtime: %v", err)
	}

	postSvc := &post.Service{DB: pool}
	taskSvc := &task.Service{DB: pool}
	notifSvc := &notification.Service{DB: pool}

	resolver := &pulsegraphql.Resolver{
		DB:            pool,
		Auth:          authSvc,
		Perm:          &perm.Service{DB: pool},
		Tags:          tags,
		Audit:         &audit.Service{DB: pool},
		Posts:         postSvc,
		Comments:      &comment.Service{DB: pool},
		Search:        &search.Service{DB: pool},
		Chat:          &chat.Service{DB: pool, Posts: postSvc},
		Tasks:         taskSvc,
		Notifications: notifSvc,
		Realtime:      dispatcher,
	}

	// bob opens the notificationReceived subscription.
	bobCtx := perm.WithRequestCache(auth.WithIdentity(ctx, auth.Identity{
		ActingID: bob, EffectiveID: bob,
	}))
	subCh, err := resolver.Subscription().NotificationReceived(bobCtx)
	if err != nil {
		t.Fatalf("subscribe: %v", err)
	}

	// alice creates a task assigning bob.
	if _, err := taskSvc.Create(context.Background(), task.CreateInput{
		CreatorID: alice,
		Title:     "Pack the elephants",
		Tags:      []task.TagAttachment{{TagID: rootID, ViewRole: true, InteractRole: true, ModerateRole: true}},
		Assignees: []uuid.UUID{bob},
	}); err != nil {
		t.Fatalf("create task: %v", err)
	}

	// Run the worker to fan out.
	registry := job.NewRegistry()
	registry.Register("notification.fanout", notifSvc.Handler)
	worker := &job.Worker{DB: pool, Registry: registry, Logger: slog.New(slog.NewTextHandler(os.Stderr, nil))}
	if _, err := worker.RunOnce(context.Background()); err != nil {
		t.Fatalf("worker: %v", err)
	}

	// bob's subscription should fire.
	select {
	case n := <-subCh:
		if n == nil {
			t.Fatal("got nil notification")
		}
		if n.Reason != "ASSIGNMENT" {
			t.Errorf("reason: got %v", n.Reason)
		}
	case <-time.After(3 * time.Second):
		t.Fatal("subscription did not deliver in time")
	}
}
