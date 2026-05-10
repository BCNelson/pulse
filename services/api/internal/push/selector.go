package push

import (
	"context"
	"fmt"
)

// Selector is a Provider that routes by platform: iOS → APNs, Android
// & web → FCM. Either provider may be nil; in that case messages for
// that platform are dropped with a warning so the caller doesn't
// confuse "not configured" with "delivered".
type Selector struct {
	APNs *APNsProvider
	FCM  *FCMProvider
}

func (s *Selector) Send(ctx context.Context, msg Message) error {
	switch msg.Platform {
	case "ios":
		if s.APNs == nil {
			return fmt.Errorf("push/selector: ios platform but APNs not configured")
		}
		return s.APNs.Send(ctx, msg)
	case "android", "web":
		if s.FCM == nil {
			return fmt.Errorf("push/selector: %s platform but FCM not configured", msg.Platform)
		}
		return s.FCM.Send(ctx, msg)
	}
	return fmt.Errorf("push/selector: unknown platform %q", msg.Platform)
}

// IsTokenInvalid asks whichever provider produced the error if it
// indicates a dead token. Used by callers to prune device_tokens.
func (s *Selector) IsTokenInvalid(err error) bool {
	if s.APNs != nil && s.APNs.IsTokenInvalid(err) {
		return true
	}
	if s.FCM != nil && s.FCM.IsTokenInvalid(err) {
		return true
	}
	return false
}
