// Package attachment owns metadata for uploads stored in an external
// S3-compatible bucket. The API server never proxies bytes — clients
// fetch a presigned URL, PUT/GET directly against the bucket, and then
// finalize the metadata via Confirm.
//
// Why presigned URLs: keeps the Go process single-purpose and out of
// the data plane (a 1GB upload would otherwise pin a request goroutine
// for minutes). Q27 in the architecture flagged the storage-dep
// trade-off; we accept it.
//
// Storage key layout: <owner_type>/<owner_id>/<attachment_id>/<filename>.
// Object versioning is left to the bucket; deletes are tombstoned in
// our table so soft-delete + retention semantics live in our schema.
package attachment

import (
	"context"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	v4 "github.com/aws/aws-sdk-go-v2/aws/signer/v4"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

var (
	ErrNotFound     = errors.New("attachment: not found")
	ErrInvalidOwner = errors.New("attachment: invalid owner type")
	ErrTooLarge     = errors.New("attachment: size exceeds limit")
	ErrUnauthorized = errors.New("attachment: not the uploader")
)

// MaxSizeBytes caps any single attachment. v1 sticks to 100MB so the
// presigned PUT can be a single request and the bucket cost stays
// bounded.
const MaxSizeBytes int64 = 100 * 1024 * 1024

// PresignTTL controls how long an issued URL is valid. Short enough
// that a leaked URL has limited blast radius; long enough that mobile
// clients can finish a slow upload.
const PresignTTL = 15 * time.Minute

// PresignClient is what we need from the AWS SDK. Defined as an
// interface so tests can substitute a stub.
type PresignClient interface {
	PresignPutObject(ctx context.Context, params *s3.PutObjectInput, optFns ...func(*s3.PresignOptions)) (*v4.PresignedHTTPRequest, error)
	PresignGetObject(ctx context.Context, params *s3.GetObjectInput, optFns ...func(*s3.PresignOptions)) (*v4.PresignedHTTPRequest, error)
}

// Service hands out presigned URLs and tracks attachment metadata.
type Service struct {
	DB       *pgxpool.Pool
	Presign  PresignClient
	Bucket   string
	S3Client *s3.Client // optional: for hard-delete on tombstone
}

// Attachment is the read-side row.
type Attachment struct {
	ID         int64
	OwnerType  string
	OwnerID    int64
	UploaderID int64
	StorageKey string
	Filename   string
	MimeType   string
	SizeBytes  int64
	State      string
	CreatedAt  time.Time
	ReadyAt    *time.Time
}

// IssueInput captures what the client tells us up front. We don't
// trust the size — the bucket policy is the actual cap — but we use
// it to short-circuit obvious aborts and pre-check quotas.
type IssueInput struct {
	OwnerType  string
	OwnerID    int64
	UploaderID int64
	Filename   string
	MimeType   string
	SizeBytes  int64
}

// IssueResult is what the client gets back: a presigned PUT URL and
// the attachment id (so the eventual Confirm call has a stable handle).
type IssueResult struct {
	AttachmentID int64
	UploadURL    string
	Method       string
	StorageKey   string
	ExpiresAt    time.Time
}

// IssueUpload creates a pending attachment row and returns a presigned
// PUT URL. The bytes themselves are uploaded by the client directly to
// the bucket; on completion the client calls Confirm to flip the row
// state. Until Confirm fires, the row is invisible to readers.
func (s *Service) IssueUpload(ctx context.Context, in IssueInput) (*IssueResult, error) {
	if !validOwnerType(in.OwnerType) {
		return nil, ErrInvalidOwner
	}
	if in.SizeBytes > MaxSizeBytes {
		return nil, ErrTooLarge
	}
	if in.SizeBytes < 0 {
		return nil, errors.New("attachment: size must be non-negative")
	}
	if in.MimeType == "" {
		in.MimeType = "application/octet-stream"
	}

	id := ids.New(ids.KindAttachment)
	key := storageKey(in.OwnerType, in.OwnerID, id, in.Filename)

	if _, err := s.DB.Exec(ctx, `
        INSERT INTO attachments (id, owner_type, owner_id, uploader_id, storage_key, filename, mime_type, size_bytes)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
    `, id, in.OwnerType, in.OwnerID, in.UploaderID, key, in.Filename, in.MimeType, in.SizeBytes); err != nil {
		return nil, fmt.Errorf("insert attachment: %w", err)
	}

	req, err := s.Presign.PresignPutObject(ctx, &s3.PutObjectInput{
		Bucket:      aws.String(s.Bucket),
		Key:         aws.String(key),
		ContentType: aws.String(in.MimeType),
	}, func(o *s3.PresignOptions) {
		o.Expires = PresignTTL
	})
	if err != nil {
		return nil, fmt.Errorf("presign: %w", err)
	}
	return &IssueResult{
		AttachmentID: id,
		UploadURL:    req.URL,
		Method:       methodOf(req),
		StorageKey:   key,
		ExpiresAt:    time.Now().Add(PresignTTL),
	}, nil
}

// methodOf reads the HTTP method off the SDK's presigned request. The
// SDK typically sets it to "PUT" for PutObject and "GET" for GetObject.
func methodOf(req *v4.PresignedHTTPRequest) string {
	if req == nil || req.Method == "" {
		return "PUT"
	}
	return req.Method
}

// Confirm flips a pending attachment to ready. Caller must be the
// uploader (or moderation logic at a higher layer; we just check the
// uploader here).
func (s *Service) Confirm(ctx context.Context, attachmentID, uploader int64, sha256 []byte) error {
	tag, err := s.DB.Exec(ctx, `
        UPDATE attachments
           SET state = 'ready',
               ready_at = now(),
               sha256 = $3
         WHERE id = $1
           AND uploader_id = $2
           AND state = 'pending'
    `, attachmentID, uploader, sha256)
	if err != nil {
		return fmt.Errorf("confirm: %w", err)
	}
	if tag.RowsAffected() == 0 {
		return ErrNotFound
	}
	return nil
}

// IssueDownload returns a presigned GET URL for an attachment the
// caller has already been authorized to view. Authorization is the
// caller's responsibility — perm checks live one layer up at the
// resolver, mirroring the post/task pattern.
func (s *Service) IssueDownload(ctx context.Context, attachmentID int64) (string, time.Time, error) {
	a, err := s.Get(ctx, attachmentID)
	if err != nil {
		return "", time.Time{}, err
	}
	if a.State != "ready" {
		return "", time.Time{}, ErrNotFound
	}
	req, err := s.Presign.PresignGetObject(ctx, &s3.GetObjectInput{
		Bucket: aws.String(s.Bucket),
		Key:    aws.String(a.StorageKey),
	}, func(o *s3.PresignOptions) {
		o.Expires = PresignTTL
	})
	if err != nil {
		return "", time.Time{}, fmt.Errorf("presign get: %w", err)
	}
	return req.URL, time.Now().Add(PresignTTL), nil
}

// Tombstone marks an attachment as deleted. The bytes stay in the
// bucket until the retention sweep hard-deletes; the row is invisible
// to reads immediately. Only the uploader (or a moderator at a higher
// layer) may tombstone.
func (s *Service) Tombstone(ctx context.Context, attachmentID, by int64) error {
	tag, err := s.DB.Exec(ctx, `
        UPDATE attachments SET state = 'tombstoned'
         WHERE id = $1 AND state <> 'tombstoned'
           AND uploader_id = $2
    `, attachmentID, by)
	if err != nil {
		return fmt.Errorf("tombstone: %w", err)
	}
	if tag.RowsAffected() == 0 {
		return ErrUnauthorized
	}
	return nil
}

// Get returns the row by id. Tombstoned attachments come back with
// State='tombstoned' so callers can filter; ErrNotFound is for "row
// doesn't exist".
func (s *Service) Get(ctx context.Context, id int64) (*Attachment, error) {
	row := s.DB.QueryRow(ctx, `
        SELECT id, owner_type, owner_id, uploader_id, storage_key, filename, mime_type,
               size_bytes, state, created_at, ready_at
        FROM attachments WHERE id = $1
    `, id)
	var a Attachment
	if err := row.Scan(&a.ID, &a.OwnerType, &a.OwnerID, &a.UploaderID, &a.StorageKey,
		&a.Filename, &a.MimeType, &a.SizeBytes, &a.State, &a.CreatedAt, &a.ReadyAt); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, ErrNotFound
		}
		return nil, fmt.Errorf("get attachment: %w", err)
	}
	return &a, nil
}

// ListByOwner returns ready attachments for an owner. Tombstoned and
// pending rows are filtered out so resolvers don't have to.
func (s *Service) ListByOwner(ctx context.Context, ownerType string, ownerID int64) ([]*Attachment, error) {
	rows, err := s.DB.Query(ctx, `
        SELECT id, owner_type, owner_id, uploader_id, storage_key, filename, mime_type,
               size_bytes, state, created_at, ready_at
        FROM attachments
        WHERE owner_type = $1 AND owner_id = $2 AND state = 'ready'
        ORDER BY created_at
    `, ownerType, ownerID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var out []*Attachment
	for rows.Next() {
		var a Attachment
		if err := rows.Scan(&a.ID, &a.OwnerType, &a.OwnerID, &a.UploaderID, &a.StorageKey,
			&a.Filename, &a.MimeType, &a.SizeBytes, &a.State, &a.CreatedAt, &a.ReadyAt); err != nil {
			return nil, err
		}
		out = append(out, &a)
	}
	return out, rows.Err()
}

func validOwnerType(t string) bool {
	switch t {
	case "post", "comment", "message":
		return true
	}
	return false
}

// storageKey builds a deterministic bucket key. The filename is kept
// for content-disposition niceness on download but doesn't drive the
// id namespace — the attachment uuid does.
func storageKey(ownerType string, ownerID, attachmentID int64, filename string) string {
	safe := strings.ReplaceAll(filename, "/", "_")
	return fmt.Sprintf("%s/%s/%s/%s", ownerType, ids.FormatID(ownerID), ids.FormatID(attachmentID), safe)
}
