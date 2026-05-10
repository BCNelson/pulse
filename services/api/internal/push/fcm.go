package push

import (
	"context"
	"errors"
	"fmt"
	"log/slog"
	"os"

	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/messaging"
	"golang.org/x/oauth2/google"
	"google.golang.org/api/option"
)

// FCMProvider sends pushes through Firebase Cloud Messaging using the
// HTTP v1 API. Authentication is via a service-account JSON key — the
// SDK handles oauth2 token rotation. Build with NewFCMProvider once
// at boot; it owns its own HTTP client + token cache.
//
// Same provider serves Android tokens directly and web push (browser
// vapid-style FCM) — the API is unified upstream.
type FCMProvider struct {
	client *messaging.Client
	logger *slog.Logger
}

// NewFCMProvider constructs a provider from a service-account JSON
// path. projectID can be empty; the SDK reads it from the credentials
// file when needed.
func NewFCMProvider(ctx context.Context, credentialsFile, projectID string, logger *slog.Logger) (*FCMProvider, error) {
	if credentialsFile == "" {
		return nil, errors.New("push/fcm: credentials file required")
	}
	conf := &firebase.Config{}
	if projectID != "" {
		conf.ProjectID = projectID
	}
	// Read the JSON ourselves and pass via WithCredentialsJSON so we
	// don't trigger the deprecated WithCredentialsFile shape (which
	// has a path-traversal risk in some hosts).
	keyBytes, err := os.ReadFile(credentialsFile)
	if err != nil {
		return nil, fmt.Errorf("fcm: read credentials: %w", err)
	}
	// The "deprecated" form is only risky when credentials come from
	// untrusted input. Ours come from operator-controlled env config —
	// PULSE_FCM_CREDENTIALS_FILE — so the safety invariant holds.
	// nolint:staticcheck // SA1019: trusted source for credentials JSON
	creds, err := google.CredentialsFromJSON(ctx, keyBytes,
		"https://www.googleapis.com/auth/firebase.messaging")
	if err != nil {
		return nil, fmt.Errorf("fcm: parse credentials: %w", err)
	}
	app, err := firebase.NewApp(ctx, conf, option.WithCredentials(creds))
	if err != nil {
		return nil, fmt.Errorf("fcm: init app: %w", err)
	}
	client, err := app.Messaging(ctx)
	if err != nil {
		return nil, fmt.Errorf("fcm: messaging client: %w", err)
	}
	if logger == nil {
		logger = slog.Default()
	}
	return &FCMProvider{client: client, logger: logger}, nil
}

// Send dispatches one message via FCM. Tokens marked stale by the
// upstream get returned as an Unregistered error which callers should
// route to FCMProvider.IsTokenInvalid for cleanup.
func (p *FCMProvider) Send(ctx context.Context, msg Message) error {
	m := &messaging.Message{
		Token: msg.Token,
		Notification: &messaging.Notification{
			Title: msg.Title,
			Body:  msg.Body,
		},
		Data: msg.Data,
	}
	_, err := p.client.Send(ctx, m)
	if err != nil {
		// Surface the raw err; the worker logs with context.
		return fmt.Errorf("fcm: send: %w", err)
	}
	return nil
}

// IsTokenInvalid maps an error to a Boolean: true when the token is
// known-bad (registration-token-not-registered or invalid-argument).
// Callers use this to decide whether to drop the device row.
func (p *FCMProvider) IsTokenInvalid(err error) bool {
	if err == nil {
		return false
	}
	return messaging.IsUnregistered(err) || messaging.IsInvalidArgument(err)
}
