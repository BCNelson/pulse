package graphql

import (
	"context"
	"encoding/hex"
	"errors"
	"fmt"
	"strings"

	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/internal/attachment"
	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/graphql/model"
	"github.com/bcnelson/pulse/services/api/internal/perm"
)

// attachmentToModel projects the service row into the GraphQL model.
// downloadUrl is left empty here — the field resolver hands it back per
// request so URLs never go stale in cache.
func (r *Resolver) attachmentToModel(ctx context.Context, a *attachment.Attachment) (*model.Attachment, error) {
	uploader, err := r.loadPrincipalIface(ctx, a.UploaderID)
	if err != nil {
		return nil, err
	}
	return &model.Attachment{
		ID:        a.ID.String(),
		OwnerType: ownerTypeToGQL(a.OwnerType),
		OwnerID:   a.OwnerID.String(),
		Uploader:  uploader,
		Filename:  a.Filename,
		MimeType:  a.MimeType,
		SizeBytes: int(a.SizeBytes),
		CreatedAt: a.CreatedAt,
	}, nil
}

func (r *Resolver) listAttachments(ctx context.Context, ownerType string, ownerID uuid.UUID) ([]*model.Attachment, error) {
	rows, err := r.Attachments.ListByOwner(ctx, ownerType, ownerID)
	if err != nil {
		return nil, err
	}
	out := make([]*model.Attachment, 0, len(rows))
	for _, a := range rows {
		m, err := r.attachmentToModel(ctx, a)
		if err != nil {
			return nil, err
		}
		out = append(out, m)
	}
	return out, nil
}

// canViewAttachmentOwner checks the ambient perm for the parent
// entity. Reuses the post/comment/message machinery so the attachment
// inherits the parent's visibility.
func (r *Resolver) canViewAttachmentOwner(ctx context.Context, viewer uuid.UUID, ownerType string, ownerID uuid.UUID) (bool, error) {
	switch ownerType {
	case "post":
		return r.Perm.CanOnPost(ctx, viewer, perm.ActionView, ownerID)
	case "comment":
		// Comments inherit visibility from the parent post.
		var postID uuid.UUID
		if err := r.DB.QueryRow(ctx,
			`SELECT post_id FROM comments WHERE id = $1`, ownerID).Scan(&postID); err != nil {
			return false, err
		}
		return r.Perm.CanOnPost(ctx, viewer, perm.ActionView, postID)
	case "message":
		var roomID uuid.UUID
		if err := r.DB.QueryRow(ctx,
			`SELECT chat_room_id FROM messages WHERE id = $1`, ownerID).Scan(&roomID); err != nil {
			return false, err
		}
		return r.Perm.CanInRoom(ctx, viewer, roomID)
	}
	return false, nil
}

// canContributeToOwner gates the issueUpload / removeAttachment
// mutations: caller must be able to contribute to (or moderate) the
// parent entity.
func (r *Resolver) canContributeToOwner(ctx context.Context, viewer uuid.UUID, ownerType string, ownerID uuid.UUID) (bool, error) {
	switch ownerType {
	case "post":
		return r.Perm.CanOnPost(ctx, viewer, perm.ActionContribute, ownerID)
	case "comment":
		var postID uuid.UUID
		if err := r.DB.QueryRow(ctx,
			`SELECT post_id FROM comments WHERE id = $1`, ownerID).Scan(&postID); err != nil {
			return false, err
		}
		return r.Perm.CanOnPost(ctx, viewer, perm.ActionContribute, postID)
	case "message":
		var roomID uuid.UUID
		if err := r.DB.QueryRow(ctx,
			`SELECT chat_room_id FROM messages WHERE id = $1`, ownerID).Scan(&roomID); err != nil {
			return false, err
		}
		// Same gate as visibility: speaking and uploading are the same
		// privilege for v1.
		return r.Perm.CanInRoom(ctx, viewer, roomID)
	}
	return false, nil
}

// resolveAttachmentDownloadURL is what the field resolver calls — it
// re-issues the presigned GET each time so a cached UI doesn't store a
// soon-stale URL.
func (r *Resolver) resolveAttachmentDownloadURL(ctx context.Context, attachmentID string) (string, error) {
	identity := auth.FromContext(ctx)
	if identity.IsAnonymous() {
		return "", errPermissionDenied
	}
	id, err := uuid.Parse(attachmentID)
	if err != nil {
		return "", fmt.Errorf("invalid id: %w", err)
	}
	a, err := r.Attachments.Get(ctx, id)
	if err != nil {
		return "", err
	}
	can, err := r.canViewAttachmentOwner(ctx, identity.EffectiveID, a.OwnerType, a.OwnerID)
	if err != nil {
		return "", err
	}
	if !can {
		return "", errPermissionDenied
	}
	url, _, err := r.Attachments.IssueDownload(ctx, id)
	if err != nil {
		return "", err
	}
	return url, nil
}

// IssueAttachmentUpload is the mutation entry point. Validates the
// caller can contribute to the owner, then asks the service for a
// presigned PUT.
func (r *Resolver) issueAttachmentUpload(ctx context.Context, input model.IssueAttachmentUploadInput) (*model.AttachmentUploadTicket, error) {
	identity, err := requireIdentity(ctx)
	if err != nil {
		return nil, err
	}
	ownerID, err := uuid.Parse(input.OwnerID)
	if err != nil {
		return nil, fmt.Errorf("invalid ownerId: %w", err)
	}
	ownerType := ownerTypeFromGQL(input.OwnerType)
	can, err := r.canContributeToOwner(ctx, identity.EffectiveID, ownerType, ownerID)
	if err != nil {
		return nil, err
	}
	if !can {
		return nil, errPermissionDenied
	}
	res, err := r.Attachments.IssueUpload(ctx, attachment.IssueInput{
		OwnerType:  ownerType,
		OwnerID:    ownerID,
		UploaderID: identity.EffectiveID,
		Filename:   input.Filename,
		MimeType:   input.MimeType,
		SizeBytes:  int64(input.SizeBytes),
	})
	if err != nil {
		return nil, err
	}
	return &model.AttachmentUploadTicket{
		AttachmentID: res.AttachmentID.String(),
		UploadURL:    res.UploadURL,
		Method:       res.Method,
		ExpiresAt:    res.ExpiresAt,
		StorageKey:   res.StorageKey,
	}, nil
}

func (r *Resolver) confirmAttachmentUpload(ctx context.Context, attachmentID string, sha256 *string) (*model.Attachment, error) {
	identity, err := requireIdentity(ctx)
	if err != nil {
		return nil, err
	}
	id, err := uuid.Parse(attachmentID)
	if err != nil {
		return nil, fmt.Errorf("invalid id: %w", err)
	}
	var hashBytes []byte
	if sha256 != nil && strings.TrimSpace(*sha256) != "" {
		hashBytes, err = hex.DecodeString(strings.TrimSpace(*sha256))
		if err != nil {
			return nil, fmt.Errorf("invalid sha256: %w", err)
		}
	}
	if err := r.Attachments.Confirm(ctx, id, identity.EffectiveID, hashBytes); err != nil {
		return nil, err
	}
	a, err := r.Attachments.Get(ctx, id)
	if err != nil {
		return nil, err
	}
	return r.attachmentToModel(ctx, a)
}

func (r *Resolver) removeAttachment(ctx context.Context, attachmentID string) (bool, error) {
	identity, err := requireIdentity(ctx)
	if err != nil {
		return false, err
	}
	id, err := uuid.Parse(attachmentID)
	if err != nil {
		return false, fmt.Errorf("invalid id: %w", err)
	}
	if err := r.Attachments.Tombstone(ctx, id, identity.EffectiveID); err != nil {
		if errors.Is(err, attachment.ErrUnauthorized) {
			return false, errPermissionDenied
		}
		return false, err
	}
	return true, nil
}

func ownerTypeFromGQL(k model.AttachmentOwnerKind) string {
	switch k {
	case model.AttachmentOwnerKindPost:
		return "post"
	case model.AttachmentOwnerKindComment:
		return "comment"
	case model.AttachmentOwnerKindMessage:
		return "message"
	}
	return ""
}

func ownerTypeToGQL(s string) model.AttachmentOwnerKind {
	switch s {
	case "post":
		return model.AttachmentOwnerKindPost
	case "comment":
		return model.AttachmentOwnerKindComment
	case "message":
		return model.AttachmentOwnerKindMessage
	}
	return ""
}
