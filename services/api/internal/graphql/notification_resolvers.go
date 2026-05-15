package graphql

import (
	"context"
	"fmt"

	"github.com/bcnelson/pulse/services/api/internal/graphql/model"
	"github.com/bcnelson/pulse/services/api/internal/notification"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// loadNotification builds a Notification model from a service row. The
// recipient_id is the viewer (we never expose someone else's inbox), so
// we don't perm-check here beyond ownership.
func (r *Resolver) loadNotification(ctx context.Context, n *notification.Notification) (*model.Notification, error) {
	recipient, err := r.loadPrincipalIface(ctx, n.RecipientID)
	if err != nil {
		return nil, err
	}

	out := &model.Notification{
		ID:         ids.FormatID(n.ID),
		Recipient:  recipient,
		Reason:     mapReasonDBToGQL(n.Reason),
		Urgency:    mapNotifUrgencyDBToGQL(n.Urgency),
		SourceType: n.SourceType,
		SourceID:   ids.FormatID(n.SourceID),
		ReadAt:     n.ReadAt,
		CreatedAt:  n.CreatedAt,
	}

	if n.SourceTagID != nil {
		t, err := r.loadTagShallow(ctx, *n.SourceTagID)
		if err != nil {
			return nil, err
		}
		out.SourceTag = t
	}

	// Source resolves to the underlying entity. If the viewer can't see it
	// (e.g. permissions changed since the notification was written), the
	// loader returns nil — the notification row stays visible but with
	// source=null so the client can show the metadata card.
	src, err := r.loadNotificationSource(ctx, n.SourceType, n.SourceID)
	if err != nil {
		return nil, err
	}
	out.Source = src
	return out, nil
}

func (r *Resolver) loadNotificationSource(ctx context.Context, srcType string, srcID int64) (model.NotificationSource, error) {
	switch srcType {
	case "post":
		p, err := r.loadPost(ctx, srcID)
		if err != nil || p == nil {
			return nil, err
		}
		return p, nil
	case "comment":
		c, err := r.loadComment(ctx, srcID)
		if err != nil || c == nil {
			return nil, err
		}
		return c, nil
	case "task":
		t, err := r.loadTask(ctx, srcID)
		if err != nil || t == nil {
			return nil, err
		}
		return t, nil
	case "message":
		m, err := r.loadMessage(ctx, srcID)
		if err != nil || m == nil {
			return nil, err
		}
		return m, nil
	}
	return nil, nil
}

// loadInbox builds a NotificationConnection for the viewer with optional
// filter. Cursor pagination is shaped but not driven by `after` yet —
// M5 wires that.
func (r *Resolver) loadInbox(ctx context.Context, recipient int64, first *int, filter *model.NotificationFilter) (*model.NotificationConnection, error) {
	limit := 50
	if first != nil && *first > 0 && *first <= 200 {
		limit = *first
	}
	unread := false
	if filter != nil && filter.UnreadOnly != nil {
		unread = *filter.UnreadOnly
	}
	rows, err := r.Notifications.Inbox(ctx, recipient, unread, limit)
	if err != nil {
		return nil, fmt.Errorf("inbox: %w", err)
	}

	edges := make([]*model.NotificationEdge, 0, len(rows))
	for _, n := range rows {
		if filter != nil && len(filter.Reasons) > 0 && !reasonInFilter(n.Reason, filter.Reasons) {
			continue
		}
		mn, err := r.loadNotification(ctx, n)
		if err != nil {
			return nil, err
		}
		edges = append(edges, &model.NotificationEdge{
			Node:   mn,
			Cursor: encodeCursor(cursor{CreatedAt: n.CreatedAt, ID: n.ID}),
		})
	}

	var unreadCount int
	if err := r.DB.QueryRow(ctx, `
        SELECT count(*) FROM notifications
        WHERE recipient_id = $1 AND read_at IS NULL
    `, recipient).Scan(&unreadCount); err != nil {
		return nil, err
	}

	pi := &model.PageInfo{}
	if len(edges) > 0 {
		s := edges[0].Cursor
		e := edges[len(edges)-1].Cursor
		pi.StartCursor = &s
		pi.EndCursor = &e
	}
	return &model.NotificationConnection{
		Edges:       edges,
		PageInfo:    pi,
		UnreadCount: unreadCount,
	}, nil
}

func reasonInFilter(dbReason string, gqlReasons []model.NotificationReason) bool {
	mapped := mapReasonDBToGQL(dbReason)
	for _, r := range gqlReasons {
		if r == mapped {
			return true
		}
	}
	return false
}

func mapReasonDBToGQL(s string) model.NotificationReason {
	switch s {
	case notification.ReasonAssignment:
		return model.NotificationReasonAssignment
	case notification.ReasonMention:
		return model.NotificationReasonMention
	case notification.ReasonWatcher:
		return model.NotificationReasonWatcher
	case notification.ReasonTagSubscription:
		return model.NotificationReasonTagSubscription
	case notification.ReasonDM:
		return model.NotificationReasonDm
	}
	return ""
}

func mapNotifUrgencyDBToGQL(s string) model.NotificationUrgency {
	switch s {
	case notification.UrgencyHigh:
		return model.NotificationUrgencyHigh
	case notification.UrgencyLow:
		return model.NotificationUrgencyLow
	}
	return model.NotificationUrgencyNormal
}
