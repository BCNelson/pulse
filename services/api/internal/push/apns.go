package push

import (
	"bytes"
	"context"
	"crypto/ecdsa"
	"crypto/x509"
	"encoding/json"
	"encoding/pem"
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
	"sync"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/net/http2"
)

// APNsProvider talks to Apple's HTTP/2 push endpoint with token-based
// auth: an ES256 JWT signed by the team's auth key. Tokens rotate
// hourly; the provider caches the active one and only re-mints when
// it's about to expire.
//
// Production endpoint is api.push.apple.com; sandbox is
// api.sandbox.push.apple.com. Operators set APNS_HOST to override.
type APNsProvider struct {
	client *http.Client
	host   string

	teamID string
	keyID  string
	topic  string

	mu       sync.Mutex
	signKey  *ecdsa.PrivateKey
	cachedTk string
	tokenAt  time.Time
}

// APNsConfig captures the credentials APNs needs.
type APNsConfig struct {
	TeamID  string // 10-char team identifier
	KeyID   string // 10-char auth key id
	KeyFile string // path to .p8 ES256 private key
	Topic   string // bundle id (e.g. com.example.pulse)
	Host    string // override; defaults to api.push.apple.com
}

// NewAPNsProvider validates config and parses the key file once.
func NewAPNsProvider(cfg APNsConfig) (*APNsProvider, error) {
	if cfg.TeamID == "" || cfg.KeyID == "" || cfg.KeyFile == "" || cfg.Topic == "" {
		return nil, errors.New("push/apns: TeamID, KeyID, KeyFile, Topic all required")
	}
	host := cfg.Host
	if host == "" {
		host = "https://api.push.apple.com"
	}
	keyBytes, err := os.ReadFile(cfg.KeyFile)
	if err != nil {
		return nil, fmt.Errorf("apns: read key: %w", err)
	}
	key, err := parseECPrivate(keyBytes)
	if err != nil {
		return nil, fmt.Errorf("apns: parse key: %w", err)
	}
	tr := &http.Transport{}
	if err := http2.ConfigureTransport(tr); err != nil {
		return nil, fmt.Errorf("apns: configure http2: %w", err)
	}
	return &APNsProvider{
		client:  &http.Client{Transport: tr, Timeout: 30 * time.Second},
		host:    host,
		teamID:  cfg.TeamID,
		keyID:   cfg.KeyID,
		topic:   cfg.Topic,
		signKey: key,
	}, nil
}

// Send delivers one push. The payload follows Apple's aps schema —
// alert object with title/body plus our custom data merged at the top
// level.
func (p *APNsProvider) Send(ctx context.Context, msg Message) error {
	token, err := p.providerToken()
	if err != nil {
		return err
	}

	payload := map[string]any{
		"aps": map[string]any{
			"alert": map[string]any{
				"title": msg.Title,
				"body":  msg.Body,
			},
			"sound": "default",
		},
	}
	for k, v := range msg.Data {
		payload[k] = v
	}
	bs, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("apns: marshal: %w", err)
	}

	url := fmt.Sprintf("%s/3/device/%s", p.host, msg.Token)
	req, err := http.NewRequestWithContext(ctx, http.MethodPost, url, bytes.NewReader(bs))
	if err != nil {
		return err
	}
	req.Header.Set("authorization", "bearer "+token)
	req.Header.Set("apns-topic", p.topic)
	req.Header.Set("apns-push-type", "alert")
	req.Header.Set("content-type", "application/json")

	resp, err := p.client.Do(req)
	if err != nil {
		return fmt.Errorf("apns: send: %w", err)
	}
	defer func() { _ = resp.Body.Close() }()
	if resp.StatusCode == http.StatusOK {
		return nil
	}
	body, _ := io.ReadAll(resp.Body)
	// Apple returns reason in JSON {"reason":"BadDeviceToken"} etc.
	return &APNsError{Status: resp.StatusCode, Body: string(body)}
}

// APNsError surfaces the HTTP status and body so callers can decide
// whether the token is dead.
type APNsError struct {
	Status int
	Body   string
}

func (e *APNsError) Error() string {
	return fmt.Sprintf("apns: status %d: %s", e.Status, e.Body)
}

// IsTokenInvalid returns true for the documented "drop this token"
// reasons so callers can prune device_tokens.
func (p *APNsProvider) IsTokenInvalid(err error) bool {
	var apnsErr *APNsError
	if !errors.As(err, &apnsErr) {
		return false
	}
	if apnsErr.Status == http.StatusGone /* 410 — Unregistered */ {
		return true
	}
	if apnsErr.Status == http.StatusBadRequest && // 400 with BadDeviceToken
		bytes.Contains([]byte(apnsErr.Body), []byte("BadDeviceToken")) {
		return true
	}
	return false
}

// providerToken returns a cached JWT, minting a fresh one when the
// previous is about to expire (Apple caps lifetime at 60 minutes; we
// rotate at 50 to leave headroom).
func (p *APNsProvider) providerToken() (string, error) {
	p.mu.Lock()
	defer p.mu.Unlock()
	if p.cachedTk != "" && time.Since(p.tokenAt) < 50*time.Minute {
		return p.cachedTk, nil
	}
	now := time.Now()
	tok := jwt.NewWithClaims(jwt.SigningMethodES256, jwt.MapClaims{
		"iss": p.teamID,
		"iat": now.Unix(),
	})
	tok.Header["kid"] = p.keyID
	signed, err := tok.SignedString(p.signKey)
	if err != nil {
		return "", fmt.Errorf("apns: sign jwt: %w", err)
	}
	p.cachedTk = signed
	p.tokenAt = now
	return signed, nil
}

func parseECPrivate(pemBytes []byte) (*ecdsa.PrivateKey, error) {
	block, _ := pem.Decode(pemBytes)
	if block == nil {
		return nil, errors.New("apns: not PEM-encoded")
	}
	// .p8 keys are PKCS#8.
	keyAny, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		// Some shops ship EC keys in SEC1; fall through.
		ecKey, ec1Err := x509.ParseECPrivateKey(block.Bytes)
		if ec1Err != nil {
			return nil, fmt.Errorf("parse pkcs8: %v / parse ec: %v", err, ec1Err)
		}
		return ecKey, nil
	}
	ecKey, ok := keyAny.(*ecdsa.PrivateKey)
	if !ok {
		return nil, errors.New("apns: key is not ECDSA")
	}
	return ecKey, nil
}
