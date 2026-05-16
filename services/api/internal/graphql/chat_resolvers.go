package graphql

import (
	"context"
	"errors"
	"fmt"

	"github.com/jackc/pgx/v5"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/chat"
	"github.com/bcnelson/pulse/services/api/internal/graphql/model"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// loadChatRoom assembles a *model.ChatRoom by id, gating on the viewer's
// CanInRoom check. Returns nil, nil when the room is not visible (or
// missing — visibility-confused-with-existence by design).
func (r *Resolver) loadChatRoom(ctx context.Context, id int64) (*model.ChatRoom, error) {
	identity := auth.FromContext(ctx)
	if identity.IsAnonymous() {
		return nil, nil
	}
	can, err := r.Perm.CanInRoom(ctx, identity.EffectiveID, id)
	if err != nil {
		return nil, err
	}
	if !can {
		return nil, nil
	}
	room, err := r.Chat.GetRoom(ctx, id)
	if err != nil {
		if errors.Is(err, chat.ErrNotFound) {
			return nil, nil
		}
		return nil, err
	}
	tagIDs, err := r.Chat.RoomTags(ctx, id)
	if err != nil {
		return nil, err
	}
	tags := make([]*model.Tag, 0, len(tagIDs))
	for _, tid := range tagIDs {
		t, err := r.loadTagShallow(ctx, tid)
		if err != nil {
			return nil, err
		}
		if t != nil {
			tags = append(tags, t)
		}
	}
	parts, err := r.Chat.Participants(ctx, id)
	if err != nil {
		return nil, err
	}
	participants := make([]*model.ChatRoomParticipant, 0, len(parts))
	for _, p := range parts {
		pi, err := r.loadPrincipalIface(ctx, p.PrincipalID)
		if err != nil {
			return nil, err
		}
		if pi == nil {
			continue
		}
		mp := &model.ChatRoomParticipant{
			Principal: pi,
			Role:      p.Role,
			JoinedAt:  p.JoinedAt,
		}
		if p.LeftAt != nil {
			lt := *p.LeftAt
			mp.LeftAt = &lt
		}
		participants = append(participants, mp)
	}
	return &model.ChatRoom{
		ID:           ids.FormatID(room.ID),
		GlobalURI:    ids.URI(ids.KindRoom, room.ID),
		IsDm:         room.IsDM,
		Tags:         tags,
		Participants: participants,
		CreatedAt:    room.CreatedAt,
		ArchivedAt:   room.ArchivedAt,
	}, nil
}

// loadMessage assembles a *model.Message. Visibility piggybacks on the
// room — if you can see the room, you can see its messages.
func (r *Resolver) loadMessage(ctx context.Context, id int64) (*model.Message, error) {
	identity := auth.FromContext(ctx)
	if identity.IsAnonymous() {
		return nil, nil
	}
	msg, err := r.Chat.GetMessage(ctx, id)
	if err != nil {
		if errors.Is(err, chat.ErrNotFound) {
			return nil, nil
		}
		return nil, err
	}
	if msg.DeletedAt != nil {
		return nil, nil
	}
	can, err := r.Perm.CanInRoom(ctx, identity.EffectiveID, msg.ChatRoomID)
	if err != nil {
		return nil, err
	}
	if !can {
		return nil, nil
	}
	room, err := r.loadChatRoom(ctx, msg.ChatRoomID)
	if err != nil {
		return nil, err
	}
	author, err := r.loadPrincipalIface(ctx, msg.AuthorID)
	if err != nil {
		return nil, err
	}
	mentionIDs, err := r.Chat.MessageMentions(ctx, id)
	if err != nil {
		return nil, err
	}
	mentions := make([]model.Principal, 0, len(mentionIDs))
	for _, mid := range mentionIDs {
		mp, err := r.loadPrincipalIface(ctx, mid)
		if err != nil {
			return nil, err
		}
		if mp != nil {
			mentions = append(mentions, mp)
		}
	}
	tagRefIDs, err := r.Chat.MessageTagRefs(ctx, id)
	if err != nil {
		return nil, err
	}
	referencedTags := make([]*model.Tag, 0, len(tagRefIDs))
	for _, tid := range tagRefIDs {
		t, err := r.loadTagShallow(ctx, tid)
		if err != nil {
			return nil, err
		}
		if t != nil {
			referencedTags = append(referencedTags, t)
		}
	}
	out := &model.Message{
		ID:             ids.FormatID(msg.ID),
		GlobalURI:      ids.URI(ids.KindMessage, msg.ID),
		ChatRoom:       room,
		Author:         author,
		Body:           msg.Body,
		Mentions:       mentions,
		ReferencedTags: referencedTags,
		CreatedAt:      msg.CreatedAt,
		EditedAt:       msg.EditedAt,
		DeletedAt:      msg.DeletedAt,
	}
	if msg.ReplyTo != nil {
		// Avoid recursive loadMessage — populate just the id+body slice.
		// The full Message can be fetched via a follow-up message(id) if
		// the client cares about the replied-to thread.
		var rb string
		var rcreated, redited *anyTimeImpl
		var t anyTimeImpl
		err := r.DB.QueryRow(ctx, `
            SELECT body, created_at, edited_at FROM messages WHERE id = $1
        `, *msg.ReplyTo).Scan(&rb, &t, &redited)
		if err == nil {
			rcreated = &t
			out.ReplyTo = &model.Message{
				ID:        ids.FormatID(*msg.ReplyTo),
				GlobalURI: ids.URI(ids.KindMessage, *msg.ReplyTo),
				ChatRoom:  room,
				Author:    author, // approx — re-resolve when needed
				Body:      rb,
				CreatedAt: *rcreated,
				EditedAt:  redited,
			}
		} else if !errors.Is(err, pgx.ErrNoRows) {
			return nil, fmt.Errorf("load reply target: %w", err)
		}
	}
	if msg.PromotedToPost != nil {
		p, err := r.loadPost(ctx, *msg.PromotedToPost)
		if err != nil {
			return nil, err
		}
		out.PromotedToPost = p
	}
	return out, nil
}

func (r *Resolver) loadMessageConnection(ctx context.Context, roomID int64, limit int) (*model.MessageConnection, error) {
	msgs, err := r.Chat.ListMessages(ctx, roomID, limit)
	if err != nil {
		return nil, err
	}
	edges := make([]*model.MessageEdge, 0, len(msgs))
	for _, m := range msgs {
		mm, err := r.loadMessage(ctx, m.ID)
		if err != nil {
			return nil, err
		}
		if mm == nil {
			continue
		}
		edges = append(edges, &model.MessageEdge{
			Node:   mm,
			Cursor: encodeCursor(cursor{CreatedAt: m.CreatedAt, ID: m.ID}),
		})
	}
	pi := &model.PageInfo{}
	if len(edges) > 0 {
		s := edges[0].Cursor
		e := edges[len(edges)-1].Cursor
		pi.StartCursor = &s
		pi.EndCursor = &e
	}
	return &model.MessageConnection{Edges: edges, PageInfo: pi}, nil
}
