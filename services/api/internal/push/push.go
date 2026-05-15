// Package push delivers high-urgency notifications to registered
// device tokens. v1 ships with a Provider interface and a logging stub
// — real APNs/FCM credentials are deployment configuration the
// operator wires in (Q35 in the architecture).
//
// The notification fan-out worker calls Service.Dispatch(notificationID)
// for any notification with urgency=high; the service looks up the
// recipient's device tokens and hands each (token, platform, payload)
// to the configured provider.
package push

import (
	"context"
	"fmt"
	"log/slog"

	"github.com/bcnelson/pulse/services/api/pkg/ids"
	"github.com/jackc/pgx/v5/pgxpool"
)

// Provider sends a single push. Implementations: LogProvider (dev),
// future APNsProvider / FCMProvider (production).
type Provider interface {
	Send(ctx context.Context, msg Message) error
}

// Message is what a provider needs to dispatch one push.
type Message struct {
	Token    string
	Platform string // 'ios', 'android', 'web'
	Title    string
	Body     string
	Data     map[string]string // arbitrary extras (e.g. deep-link target)
}

// LogProvider just logs each send. Use in dev / when no real provider
// is configured. Operators replace with a real Provider via the
// Service's constructor.
type LogProvider struct {
	Logger *slog.Logger
}

func (p *LogProvider) Send(ctx context.Context, msg Message) error {
	if p.Logger == nil {
		p.Logger = slog.Default()
	}
	p.Logger.Info("push.stub.send",
		"platform", msg.Platform,
		"token", maskToken(msg.Token),
		"title", msg.Title,
	)
	return nil
}

// Service owns device token registration and push dispatch.
type Service struct {
	DB       *pgxpool.Pool
	Provider Provider
	Logger   *slog.Logger
}

// Register inserts (or refreshes) a (principal, token) pair. Idempotent
// on the unique key — re-registering bumps last_seen_at so stale-token
// reapers can prune the long-tail.
func (s *Service) Register(ctx context.Context, principal int64, token, platform string) error {
	if token == "" {
		return fmt.Errorf("push: token required")
	}
	if !validPlatform(platform) {
		return fmt.Errorf("push: invalid platform %q", platform)
	}
	_, err := s.DB.Exec(ctx, `
        INSERT INTO device_tokens (principal_id, token, platform)
        VALUES ($1, $2, $3)
        ON CONFLICT (principal_id, token) DO UPDATE
        SET platform = EXCLUDED.platform, last_seen_at = now()
    `, principal, token, platform)
	if err != nil {
		return fmt.Errorf("register device: %w", err)
	}
	return nil
}

// Unregister removes a token. Idempotent.
func (s *Service) Unregister(ctx context.Context, principal int64, token string) error {
	_, err := s.DB.Exec(ctx,
		`DELETE FROM device_tokens WHERE principal_id = $1 AND token = $2`,
		principal, token)
	return err
}

// Dispatch sends the named notification's content to every device
// token registered to its recipient. Skipped silently when no provider
// is configured, no tokens exist, or urgency != high (the fan-out
// worker filters before calling).
func (s *Service) Dispatch(ctx context.Context, notificationID int64, title, body string) error {
	if s.Provider == nil {
		return nil
	}
	var recipient int64
	if err := s.DB.QueryRow(ctx,
		`SELECT recipient_id FROM notifications WHERE id = $1`, notificationID).
		Scan(&recipient); err != nil {
		return fmt.Errorf("load recipient: %w", err)
	}
	rows, err := s.DB.Query(ctx,
		`SELECT token, platform FROM device_tokens WHERE principal_id = $1`, recipient)
	if err != nil {
		return fmt.Errorf("load tokens: %w", err)
	}
	defer rows.Close()
	for rows.Next() {
		var token, platform string
		if err := rows.Scan(&token, &platform); err != nil {
			return err
		}
		msg := Message{
			Token: token, Platform: platform,
			Title: title, Body: body,
			Data: map[string]string{"notification_id": ids.FormatID(notificationID)},
		}
		if err := s.Provider.Send(ctx, msg); err != nil {
			if s.Logger != nil {
				s.Logger.Warn("push.send.failed", "err", err, "platform", platform)
			}
			// Don't bail the loop on one provider error — best-effort
			// per device. The worker that drove us is fire-and-forget.
		}
	}
	return rows.Err()
}

func validPlatform(p string) bool {
	switch p {
	case "ios", "android", "web":
		return true
	}
	return false
}

func maskToken(t string) string {
	if len(t) <= 8 {
		return "***"
	}
	return t[:4] + "..." + t[len(t)-4:]
}
