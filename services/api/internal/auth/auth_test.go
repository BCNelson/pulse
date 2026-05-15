package auth_test

import (
	"context"
	"testing"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

func TestLoginRoundTrip(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &auth.Service{DB: pool}

	mustCreateUserWithPassword(t, pool, "alice@example.com", "Alice", "hunter2-correct-horse")

	issued, principalID, err := svc.Login(context.Background(), "alice@example.com", "hunter2-correct-horse", "test")
	if err != nil {
		t.Fatalf("Login: %v", err)
	}
	if issued.Token == "" || principalID == int64(0) {
		t.Fatal("Login should issue a non-empty token and a real principal id")
	}

	// Lookup the issued token to confirm it resolves to the same principal.
	gotPrincipal, err := svc.Lookup(context.Background(), issued.Token)
	if err != nil {
		t.Fatalf("Lookup: %v", err)
	}
	if gotPrincipal != principalID {
		t.Errorf("Lookup principal: want %d got %d", principalID, gotPrincipal)
	}
}

func TestLoginWrongPassword(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &auth.Service{DB: pool}

	mustCreateUserWithPassword(t, pool, "alice@example.com", "Alice", "real-password")

	_, _, err := svc.Login(context.Background(), "alice@example.com", "wrong-password", "")
	if err != auth.ErrInvalidCredentials {
		t.Fatalf("expected ErrInvalidCredentials, got %v", err)
	}
}

func TestLoginUnknownEmail(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &auth.Service{DB: pool}

	_, _, err := svc.Login(context.Background(), "nobody@example.com", "anything", "")
	if err != auth.ErrInvalidCredentials {
		t.Fatalf("expected ErrInvalidCredentials, got %v", err)
	}
}

func TestLogoutRevokesSession(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &auth.Service{DB: pool}

	mustCreateUserWithPassword(t, pool, "alice@example.com", "Alice", "pw")
	issued, _, err := svc.Login(context.Background(), "alice@example.com", "pw", "")
	if err != nil {
		t.Fatalf("Login: %v", err)
	}

	if err := svc.Logout(context.Background(), issued.Token); err != nil {
		t.Fatalf("Logout: %v", err)
	}
	if _, err := svc.Lookup(context.Background(), issued.Token); err != auth.ErrSessionRevoked {
		t.Fatalf("expected ErrSessionRevoked, got %v", err)
	}
}

func TestLookupExpired(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &auth.Service{DB: pool}

	principal := mustCreatePrincipalWithEmail(t, pool, "alice@example.com", "Alice")
	// Issue with a near-zero lifetime — already expired by the time Lookup runs.
	issued, err := svc.IssueSession(context.Background(), principal, "test", -1*time.Second)
	if err != nil {
		t.Fatalf("IssueSession: %v", err)
	}
	if _, err := svc.Lookup(context.Background(), issued.Token); err != auth.ErrSessionExpired {
		t.Fatalf("expected ErrSessionExpired, got %v", err)
	}
}

func TestBotKeyAuth(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &auth.Service{DB: pool}

	owner := mustCreatePrincipalWithEmail(t, pool, "owner@example.com", "Owner")
	bot := mustCreateBotPrincipal(t, pool, "the-bot")

	key, err := svc.IssueBotKey(context.Background(), bot, owner)
	if err != nil {
		t.Fatalf("IssueBotKey: %v", err)
	}
	got, err := svc.AuthenticateBotKey(context.Background(), key)
	if err != nil {
		t.Fatalf("AuthenticateBotKey: %v", err)
	}
	if got != bot {
		t.Errorf("authenticated principal: want %d got %d", bot, got)
	}

	if _, err := svc.AuthenticateBotKey(context.Background(), "wrong-key"); err != auth.ErrInvalidCredentials {
		t.Fatalf("expected ErrInvalidCredentials for wrong key, got %v", err)
	}
}

// --- helpers ---

func mustCreatePrincipalWithEmail(t *testing.T, pool *pgxpool.Pool, email, displayName string) int64 {
	t.Helper()
	id := ids.New(ids.KindUser)
	uri := "local://principals/" + ids.FormatID(id)
	_, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, $3, $4)
    `, id, uri, displayName, email)
	if err != nil {
		t.Fatalf("insert principal: %v", err)
	}
	return id
}

func mustCreateBotPrincipal(t *testing.T, pool *pgxpool.Pool, displayName string) int64 {
	t.Helper()
	id := ids.New(ids.KindUser)
	uri := "local://principals/" + ids.FormatID(id)
	_, err := pool.Exec(context.Background(), `
        INSERT INTO principals (id, kind, status, global_uri, display_name)
        VALUES ($1, 'bot', 'active', $2, $3)
    `, id, uri, displayName)
	if err != nil {
		t.Fatalf("insert bot principal: %v", err)
	}
	return id
}

func mustCreateUserWithPassword(t *testing.T, pool *pgxpool.Pool, email, displayName, password string) int64 {
	t.Helper()
	id := mustCreatePrincipalWithEmail(t, pool, email, displayName)
	hash, err := auth.HashPassword(password)
	if err != nil {
		t.Fatalf("HashPassword: %v", err)
	}
	_, err = pool.Exec(context.Background(), `
        INSERT INTO user_credentials (principal_id, password_hash)
        VALUES ($1, $2)
    `, id, hash)
	if err != nil {
		t.Fatalf("insert credential: %v", err)
	}
	return id
}
