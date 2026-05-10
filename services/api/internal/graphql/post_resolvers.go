package graphql

import (
	"context"
	"errors"
	"fmt"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	"github.com/bcnelson/pulse/services/api/internal/graphql/loaders"
	"github.com/bcnelson/pulse/services/api/internal/graphql/model"
	"github.com/bcnelson/pulse/services/api/internal/perm"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// loadPost fetches a post by id, performs the Q3 two-layer visibility
// check, and assembles its full GraphQL representation. Returns nil, nil
// when the viewer cannot view the post (existence-confused with
// visibility, on purpose). Returns nil, error for hard failures.
func (r *Resolver) loadPost(ctx context.Context, id uuid.UUID) (*model.Post, error) {
	identity := auth.FromContext(ctx)
	if identity.IsAnonymous() {
		return nil, nil
	}
	canView, err := r.Perm.CanOnPost(ctx, identity.EffectiveID, perm.ActionView, id)
	if err != nil {
		return nil, fmt.Errorf("post visibility: %w", err)
	}
	if !canView {
		return nil, nil
	}

	p, err := r.Posts.Get(ctx, id)
	if err != nil {
		if errors.Is(err, post.ErrNotFound) {
			return nil, nil
		}
		return nil, err
	}
	if p.DeletedAt != nil {
		return nil, nil
	}

	// Author.
	author, err := r.loadPrincipalIface(ctx, p.AuthorID)
	if err != nil {
		return nil, err
	}

	// Tags (with role flags).
	tagAttachments, err := r.Posts.TagAttachments(ctx, id)
	if err != nil {
		return nil, err
	}
	postTags := make([]*model.PostTag, 0, len(tagAttachments))
	for _, a := range tagAttachments {
		t, err := r.loadTagShallow(ctx, a.TagID)
		if err != nil {
			return nil, err
		}
		if t == nil {
			continue
		}
		postTags = append(postTags, &model.PostTag{
			Tag:          t,
			ViewRole:     a.ViewRole,
			InteractRole: a.InteractRole,
			ModerateRole: a.ModerateRole,
		})
	}

	// Mentions.
	mentionIDs, err := r.Posts.Mentions(ctx, id)
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

	// Reactions (aggregated). Goes through the loader so a feed view
	// that already primed the cache hits in O(1); single-post lookups
	// fall through to a one-row query.
	reactions, err := r.loadPostReactions(ctx, id, identity.EffectiveID)
	if err != nil {
		return nil, err
	}

	// Comments — eager load up to a default page. M2 uses a fixed cap;
	// post-Connection pagination args are accepted but the load itself is
	// bounded server-side here so we don't surprise resolvers depending on
	// a value being present.
	comments, err := r.loadCommentsForPost(ctx, id, 200)
	if err != nil {
		return nil, err
	}

	// Permissions.
	bundle, _, err := r.Perm.EffectiveOnPost(ctx, identity.EffectiveID, id)
	if err != nil {
		return nil, err
	}
	canContribute, err := r.Perm.CanOnPost(ctx, identity.EffectiveID, perm.ActionContribute, id)
	if err != nil {
		return nil, err
	}
	canModerate, err := r.Perm.CanOnPost(ctx, identity.EffectiveID, perm.ActionModerate, id)
	if err != nil {
		return nil, err
	}
	myPerms := &model.PostPermissions{
		CanView:       canView,
		CanContribute: canContribute,
		CanModerate:   canModerate,
	}
	if bundle != perm.BundleNone {
		b := mapBundleDBToGQL(bundle)
		myPerms.Bundle = &b
	}

	// Last-read timestamp for the viewer.
	var lastRead *anyTimeImpl
	var t anyTimeImpl
	err = r.DB.QueryRow(ctx, `
        SELECT last_read_at FROM principal_post_read
        WHERE principal_id = $1 AND post_id = $2
    `, identity.EffectiveID, id).Scan(&t)
	if err == nil {
		lastRead = &t
	} else if !errors.Is(err, pgx.ErrNoRows) {
		return nil, err
	}

	out := &model.Post{
		ID:            p.ID.String(),
		GlobalURI:     ids.URI("posts", p.ID),
		Title:         p.Title,
		Body:          p.Body,
		Author:        author,
		Tags:          postTags,
		Mentions:      mentions,
		Comments:      comments,
		Reactions:     reactions,
		DenyFlag:      p.DenyFlag,
		MyPermissions: myPerms,
		CreatedAt:     p.CreatedAt,
		EditedAt:      p.EditedAt,
		DeletedAt:     p.DeletedAt,
		LastReadAt:    lastRead,
	}
	if p.DecisionStatus != nil {
		ds := mapDecisionDBToGQL(*p.DecisionStatus)
		out.DecisionStatus = &ds
	}
	return out, nil
}

func (r *Resolver) loadCommentsForPost(ctx context.Context, postID uuid.UUID, limit int) (*model.CommentConnection, error) {
	rows, err := r.Comments.ListByPost(ctx, postID, limit)
	if err != nil {
		return nil, err
	}
	edges := make([]*model.CommentEdge, 0, len(rows))
	for _, c := range rows {
		if c.DeletedAt != nil {
			continue
		}
		mc, err := r.commentToModel(ctx, c)
		if err != nil {
			return nil, err
		}
		edges = append(edges, &model.CommentEdge{
			Node:   mc,
			Cursor: encodeCursor(cursor{CreatedAt: c.CreatedAt, ID: c.ID}),
		})
	}
	pi := &model.PageInfo{}
	if len(edges) > 0 {
		s := edges[0].Cursor
		e := edges[len(edges)-1].Cursor
		pi.StartCursor = &s
		pi.EndCursor = &e
	}
	return &model.CommentConnection{Edges: edges, PageInfo: pi}, nil
}

func (r *Resolver) commentToModel(ctx context.Context, c *comment.Comment) (*model.Comment, error) {
	identity := auth.FromContext(ctx)
	author, err := r.loadPrincipalIface(ctx, c.AuthorID)
	if err != nil {
		return nil, err
	}
	mentionRows, err := r.DB.Query(ctx,
		`SELECT principal_id FROM comment_mentions WHERE comment_id = $1`, c.ID)
	if err != nil {
		return nil, err
	}
	defer mentionRows.Close()
	var mentions []model.Principal
	for mentionRows.Next() {
		var pid uuid.UUID
		if err := mentionRows.Scan(&pid); err != nil {
			return nil, err
		}
		mp, err := r.loadPrincipalIface(ctx, pid)
		if err != nil {
			return nil, err
		}
		if mp != nil {
			mentions = append(mentions, mp)
		}
	}
	tally, err := r.commentReactionTally(ctx, c.ID, identity.EffectiveID)
	if err != nil {
		return nil, err
	}
	parentID := ""
	if c.ParentID != nil {
		parentID = c.ParentID.String()
	}
	return &model.Comment{
		ID:        c.ID.String(),
		PostID:    c.PostID.String(),
		ParentID:  optString(parentID),
		Depth:     comment.Depth(c.Path),
		Author:    author,
		Body:      c.Body,
		Mentions:  mentions,
		Reactions: tally,
		CreatedAt: c.CreatedAt,
		EditedAt:  c.EditedAt,
		DeletedAt: c.DeletedAt,
	}, nil
}

func (r *Resolver) commentReactionTally(ctx context.Context, commentID, viewer uuid.UUID) ([]*model.ReactionSummary, error) {
	rows, err := r.DB.Query(ctx, `
        SELECT emoji, COUNT(*)::INT, BOOL_OR(principal_id = $2)
        FROM comment_reactions WHERE comment_id = $1
        GROUP BY emoji ORDER BY emoji
    `, commentID, viewer)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	out := []*model.ReactionSummary{}
	for rows.Next() {
		var s model.ReactionSummary
		if err := rows.Scan(&s.Emoji, &s.Count, &s.ByViewer); err != nil {
			return nil, err
		}
		out = append(out, &s)
	}
	return out, rows.Err()
}

func (r *Resolver) loadComment(ctx context.Context, id uuid.UUID) (*model.Comment, error) {
	c, err := r.Comments.Get(ctx, id)
	if err != nil {
		if errors.Is(err, comment.ErrNotFound) {
			return nil, nil
		}
		return nil, err
	}
	// Visibility piggybacks on the parent post: if the viewer can see the
	// post, they can see its comments. The post-level check captures
	// tag-grant cascading and per-post role flags in one shot.
	identity := auth.FromContext(ctx)
	if identity.IsAnonymous() {
		return nil, nil
	}
	can, err := r.Perm.CanOnPost(ctx, identity.EffectiveID, perm.ActionView, c.PostID)
	if err != nil {
		return nil, err
	}
	if !can {
		return nil, nil
	}
	if c.DeletedAt != nil {
		return nil, nil
	}
	return r.commentToModel(ctx, c)
}

// loadPrincipalIface resolves a principal id to the appropriate concrete
// GraphQL Principal (User or Bot). Returns the model.Principal interface
// with the underlying type.
//
// Goes through the per-request loader cache when available — feed-shaped
// resolvers should call loaders.FromContext(ctx).Principals.Prime(ids)
// before iterating so this becomes a cache hit rather than N queries.
func (r *Resolver) loadPrincipalIface(ctx context.Context, id uuid.UUID) (model.Principal, error) {
	if l := loaders.FromContext(ctx); l != nil {
		row, err := l.Principals.Get(ctx, id)
		if err != nil {
			return nil, err
		}
		if row == nil {
			return nil, nil
		}
		return r.shapePrincipalFromLoader(ctx, row)
	}

	var (
		kind        string
		status      string
		displayName string
		email       *string
		homeTagID   *uuid.UUID
		ownerID     *uuid.UUID
	)
	err := r.DB.QueryRow(ctx, `
        SELECT p.kind, p.status, p.display_name, p.email, p.home_tag_id,
               bc.owner_principal_id
        FROM principals p
        LEFT JOIN bot_credentials bc ON bc.principal_id = p.id
        WHERE p.id = $1
    `, id).Scan(&kind, &status, &displayName, &email, &homeTagID, &ownerID)
	if errors.Is(err, pgx.ErrNoRows) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	row := &loaders.PrincipalRow{
		ID: id, Kind: kind, Status: status, DisplayName: displayName,
		Email: email, HomeTagID: homeTagID, BotOwnerID: ownerID,
	}
	return r.shapePrincipalFromLoader(ctx, row)
}

// shapePrincipalFromLoader builds the GraphQL principal model from a
// loader row. Shared between cached and direct paths so the field
// derivation lives in one place.
func (r *Resolver) shapePrincipalFromLoader(ctx context.Context, row *loaders.PrincipalRow) (model.Principal, error) {
	var homeTag *model.Tag
	if row.HomeTagID != nil {
		ht, err := r.loadTagShallow(ctx, *row.HomeTagID)
		if err != nil {
			return nil, err
		}
		homeTag = ht
	}
	switch row.Kind {
	case "user":
		return model.User{
			ID:          row.ID.String(),
			GlobalURI:   ids.URI("principals", row.ID),
			Kind:        model.PrincipalKindUser,
			Status:      mapStatusDBToGQL(row.Status),
			DisplayName: row.DisplayName,
			HomeTag:     homeTag,
			Email:       row.Email,
		}, nil
	case "bot":
		var owner model.Principal
		if row.BotOwnerID != nil {
			owner, _ = r.loadPrincipalIface(ctx, *row.BotOwnerID)
		}
		return model.Bot{
			ID:             row.ID.String(),
			GlobalURI:      ids.URI("principals", row.ID),
			Kind:           model.PrincipalKindBot,
			Status:         mapStatusDBToGQL(row.Status),
			DisplayName:    row.DisplayName,
			HomeTag:        homeTag,
			OwnerPrincipal: owner,
		}, nil
	}
	return nil, nil
}

// --- mapping ---

func mapDecisionDBToGQL(s string) model.DecisionStatus {
	switch s {
	case "decision":
		return model.DecisionStatusDecision
	case "answer":
		return model.DecisionStatusAnswer
	}
	return ""
}

func mapDecisionGQLToDB(s model.DecisionStatus) string {
	switch s {
	case model.DecisionStatusDecision:
		return "decision"
	case model.DecisionStatusAnswer:
		return "answer"
	}
	return ""
}

func optString(s string) *string {
	if s == "" {
		return nil
	}
	return &s
}

// primePostListLoaders pre-warms the per-request loader caches for a
// list of posts: distinct authors, distinct attached tags, reaction
// tallies. Three round-trips total instead of N×3.
func (r *Resolver) primePostListLoaders(ctx context.Context, posts []*post.Post, viewer uuid.UUID) {
	l := loaders.FromContext(ctx)
	if l == nil {
		return
	}
	authorIDs := make([]uuid.UUID, 0, len(posts))
	postIDs := make([]uuid.UUID, 0, len(posts))
	for _, p := range posts {
		authorIDs = append(authorIDs, p.AuthorID)
		postIDs = append(postIDs, p.ID)
	}
	_ = l.Principals.Prime(ctx, authorIDs)
	_ = l.PostReactions.Prime(ctx, postIDs, viewer)

	// Tag attachments: query post_tags once and prime the tag loader
	// with the distinct tag ids found.
	if len(postIDs) > 0 {
		rows, err := r.DB.Query(ctx,
			`SELECT DISTINCT tag_id FROM post_tags WHERE post_id = ANY($1::UUID[])`, postIDs)
		if err == nil {
			tagIDs := []uuid.UUID{}
			for rows.Next() {
				var id uuid.UUID
				if err := rows.Scan(&id); err == nil {
					tagIDs = append(tagIDs, id)
				}
			}
			rows.Close()
			_ = l.Tags.Prime(ctx, tagIDs)
		}
	}
}

// loadPostReactions returns aggregated reaction tallies for a post via
// the loader (cache hit for primed feed views, lazy load otherwise).
func (r *Resolver) loadPostReactions(ctx context.Context, postID, viewer uuid.UUID) ([]*model.ReactionSummary, error) {
	if l := loaders.FromContext(ctx); l != nil {
		tally, err := l.PostReactions.Get(ctx, postID, viewer)
		if err != nil {
			return nil, err
		}
		out := make([]*model.ReactionSummary, 0, len(tally))
		for _, t := range tally {
			out = append(out, &model.ReactionSummary{
				Emoji: t.Emoji, Count: t.Count, ByViewer: t.ByViewer,
			})
		}
		return out, nil
	}
	tally, err := r.Posts.ReactionTally(ctx, postID, viewer)
	if err != nil {
		return nil, err
	}
	out := make([]*model.ReactionSummary, 0, len(tally))
	for _, e := range tally {
		out = append(out, &model.ReactionSummary{
			Emoji: e.Emoji, Count: e.Count, ByViewer: e.ByViewer,
		})
	}
	return out, nil
}
