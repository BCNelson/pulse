// Package auth covers password login, session/token issuance and validation,
// and bot API-key authentication. M1 ships the core surfaces; MFA columns
// are wired into the schema but not enforced here yet (the architecture
// flags MFA as optional in v1, and a workspace policy switch lands in M5).
package auth

import (
	"context"
	"crypto/rand"
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"golang.org/x/crypto/bcrypt"
)

const (
	// SessionTokenBytes is the entropy of an issued session/bot token before
	// hex encoding. 32 bytes = 256 bits.
	SessionTokenBytes = 32
	// DefaultSessionLifetime is the validity window of a fresh session. The
	// caller may override per-call.
	DefaultSessionLifetime = 30 * 24 * time.Hour
	// BcryptCost balances login latency against brute-force resistance.
	// 12 is the modern default and runs in ~250ms on commodity hardware.
	BcryptCost = 12
)

var (
	ErrInvalidCredentials = errors.New("auth: invalid credentials")
	ErrSessionExpired     = errors.New("auth: session expired")
	ErrSessionRevoked     = errors.New("auth: session revoked")
	ErrSessionNotFound    = errors.New("auth: session not found")
)

// Service is the auth boundary. Methods on it operate on a *pgxpool.Pool;
// transactions are internal where multi-statement atomicity matters.
type Service struct {
	DB *pgxpool.Pool
}

// Issued describes a freshly minted session. Token is the secret returned
// to the client (cookie value or bearer); it is never stored in the DB.
type Issued struct {
	SessionID uuid.UUID
	Token     string
	ExpiresAt time.Time
}

// Login authenticates a user by email + password. Returns ErrInvalidCredentials
// for any failure mode the caller should treat uniformly (no enumeration).
// Successful login issues a session.
func (s *Service) Login(ctx context.Context, email, password, userAgent string) (*Issued, uuid.UUID, error) {
	email = strings.ToLower(strings.TrimSpace(email))
	if email == "" || password == "" {
		return nil, uuid.Nil, ErrInvalidCredentials
	}

	var principalID uuid.UUID
	var hash *string
	err := s.DB.QueryRow(ctx, `
        SELECT p.id, c.password_hash
        FROM principals p
        JOIN user_credentials c ON c.principal_id = p.id
        WHERE p.kind = 'user'
          AND p.status = 'active'
          AND lower(p.email) = $1
          AND c.revoked_at IS NULL
    `, email).Scan(&principalID, &hash)
	if errors.Is(err, pgx.ErrNoRows) || hash == nil {
		// Run a dummy bcrypt compare so timing doesn't leak account existence.
		_ = bcrypt.CompareHashAndPassword([]byte("$2a$12$invalidinvalidinvalidinvalidinvalidinvalidinvalidinvalidinO"), []byte(password))
		return nil, uuid.Nil, ErrInvalidCredentials
	}
	if err != nil {
		return nil, uuid.Nil, fmt.Errorf("lookup credentials: %w", err)
	}
	if err := bcrypt.CompareHashAndPassword([]byte(*hash), []byte(password)); err != nil {
		return nil, uuid.Nil, ErrInvalidCredentials
	}

	issued, err := s.IssueSession(ctx, principalID, userAgent, DefaultSessionLifetime)
	if err != nil {
		return nil, uuid.Nil, err
	}
	return issued, principalID, nil
}

// IssueSession mints a fresh session for principal P with the given lifetime.
// The Token field of the result is the secret to hand the client; only its
// hash is persisted.
func (s *Service) IssueSession(ctx context.Context, principal uuid.UUID, userAgent string, lifetime time.Duration) (*Issued, error) {
	token, err := randomToken()
	if err != nil {
		return nil, fmt.Errorf("generate token: %w", err)
	}
	hash := hashToken(token)
	expires := time.Now().Add(lifetime).UTC()

	var id uuid.UUID
	err = s.DB.QueryRow(ctx, `
        INSERT INTO sessions (principal_id, token_hash, user_agent, expires_at)
        VALUES ($1, $2, NULLIF($3, ''), $4)
        RETURNING id
    `, principal, hash, userAgent, expires).Scan(&id)
	if err != nil {
		return nil, fmt.Errorf("insert session: %w", err)
	}
	return &Issued{SessionID: id, Token: token, ExpiresAt: expires}, nil
}

// Lookup resolves a token back to its principal. Returns the typed
// "expired"/"revoked"/"not found" errors so callers can distinguish for
// logging without surfacing the distinction to the user.
//
// Deprecated: prefer LookupSession which surfaces the acting/effective
// split; Lookup is retained for callers that only need the effective id.
func (s *Service) Lookup(ctx context.Context, token string) (uuid.UUID, error) {
	sess, err := s.LookupSession(ctx, token)
	if err != nil {
		return uuid.Nil, err
	}
	return sess.EffectiveID, nil
}

// SessionRecord is the resolved session pulled from a token. ActingID is
// the user who actually holds the session (the original login). When
// impersonation is active, EffectiveID is a different principal — the
// one whose perms are evaluated for this request. Audit writers stamp
// both.
type SessionRecord struct {
	SessionID   uuid.UUID
	ActingID    uuid.UUID
	EffectiveID uuid.UUID
}

// LookupSession resolves a token to the full session record including
// the acting/effective split.
func (s *Service) LookupSession(ctx context.Context, token string) (SessionRecord, error) {
	if token == "" {
		return SessionRecord{}, ErrSessionNotFound
	}
	hash := hashToken(token)

	var sess SessionRecord
	var effective *uuid.UUID
	var expiresAt time.Time
	var revokedAt *time.Time
	err := s.DB.QueryRow(ctx, `
        SELECT id, principal_id, effective_principal_id, expires_at, revoked_at
        FROM sessions
        WHERE token_hash = $1
    `, hash).Scan(&sess.SessionID, &sess.ActingID, &effective, &expiresAt, &revokedAt)
	if errors.Is(err, pgx.ErrNoRows) {
		return SessionRecord{}, ErrSessionNotFound
	}
	if err != nil {
		return SessionRecord{}, fmt.Errorf("lookup session: %w", err)
	}
	if revokedAt != nil {
		return SessionRecord{}, ErrSessionRevoked
	}
	if !expiresAt.After(time.Now()) {
		return SessionRecord{}, ErrSessionExpired
	}
	sess.EffectiveID = sess.ActingID
	if effective != nil {
		sess.EffectiveID = *effective
	}
	return sess, nil
}

// Logout revokes the session named by token. Idempotent: revoking an
// already-revoked or unknown session is not an error.
func (s *Service) Logout(ctx context.Context, token string) error {
	if token == "" {
		return nil
	}
	_, err := s.DB.Exec(ctx, `
        UPDATE sessions
        SET revoked_at = now()
        WHERE token_hash = $1 AND revoked_at IS NULL
    `, hashToken(token))
	return err
}

// HashPassword wraps bcrypt for the password-set flows. Callers store the
// returned string in user_credentials.password_hash.
func HashPassword(plaintext string) (string, error) {
	h, err := bcrypt.GenerateFromPassword([]byte(plaintext), BcryptCost)
	if err != nil {
		return "", fmt.Errorf("hash password: %w", err)
	}
	return string(h), nil
}

// AuthenticateBotKey resolves a bot API key to its principal. Bot keys live
// in bot_credentials.api_key_hash (sha256 of the issued key).
func (s *Service) AuthenticateBotKey(ctx context.Context, key string) (uuid.UUID, error) {
	if key == "" {
		return uuid.Nil, ErrInvalidCredentials
	}
	hash := hashToken(key)

	var principalID uuid.UUID
	var revokedAt *time.Time
	err := s.DB.QueryRow(ctx, `
        SELECT bc.principal_id, bc.revoked_at
        FROM bot_credentials bc
        JOIN principals p ON p.id = bc.principal_id
        WHERE bc.api_key_hash = $1
          AND p.status = 'active'
    `, hash).Scan(&principalID, &revokedAt)
	if errors.Is(err, pgx.ErrNoRows) {
		return uuid.Nil, ErrInvalidCredentials
	}
	if err != nil {
		return uuid.Nil, fmt.Errorf("lookup bot key: %w", err)
	}
	if revokedAt != nil {
		return uuid.Nil, ErrSessionRevoked
	}
	return principalID, nil
}

// IssueBotKey provisions a fresh API key for an existing bot principal,
// returning the plaintext key once. The caller stores it in their secret
// vault; we keep only the hash.
func (s *Service) IssueBotKey(ctx context.Context, principal, owner uuid.UUID) (string, error) {
	key, err := randomToken()
	if err != nil {
		return "", fmt.Errorf("generate key: %w", err)
	}
	hash := hashToken(key)

	_, err = s.DB.Exec(ctx, `
        INSERT INTO bot_credentials (principal_id, api_key_hash, owner_principal_id)
        VALUES ($1, $2, $3)
        ON CONFLICT (principal_id) DO UPDATE
            SET api_key_hash = EXCLUDED.api_key_hash,
                owner_principal_id = EXCLUDED.owner_principal_id,
                revoked_at = NULL
    `, principal, hash, owner)
	if err != nil {
		return "", fmt.Errorf("upsert bot credential: %w", err)
	}
	return key, nil
}

func randomToken() (string, error) {
	b := make([]byte, SessionTokenBytes)
	if _, err := rand.Read(b); err != nil {
		return "", err
	}
	return hex.EncodeToString(b), nil
}

func hashToken(token string) string {
	sum := sha256.Sum256([]byte(token))
	return hex.EncodeToString(sum[:])
}
