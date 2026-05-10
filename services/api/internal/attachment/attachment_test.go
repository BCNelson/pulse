package attachment_test

import (
	"context"
	"strings"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws/signer/v4"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/internal/attachment"
	"github.com/bcnelson/pulse/services/api/internal/pgtest"
)

// fakePresign is a stand-in for the S3 PresignClient. It records
// calls and returns deterministic URLs so tests don't need a live
// MinIO during unit-level verification.
type fakePresign struct {
	puts int
	gets int
}

func (f *fakePresign) PresignPutObject(ctx context.Context, params *s3.PutObjectInput, _ ...func(*s3.PresignOptions)) (*v4.PresignedHTTPRequest, error) {
	f.puts++
	return &v4.PresignedHTTPRequest{
		URL:    "https://bucket.example.com/" + *params.Key + "?put",
		Method: "PUT",
	}, nil
}

func (f *fakePresign) PresignGetObject(ctx context.Context, params *s3.GetObjectInput, _ ...func(*s3.PresignOptions)) (*v4.PresignedHTTPRequest, error) {
	f.gets++
	return &v4.PresignedHTTPRequest{
		URL:    "https://bucket.example.com/" + *params.Key + "?get",
		Method: "GET",
	}, nil
}

func TestIssueUploadCreatesPendingRow(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	// Seed minimum: one principal.
	uploaderID := uuid.New()
	if _, err := pool.Exec(ctx, `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, 'Up', 'up@example.com')
    `, uploaderID, "local://principals/"+uploaderID.String()); err != nil {
		t.Fatalf("seed: %v", err)
	}

	// Attach to a placeholder owner — we just need a UUID for the test.
	ownerID := uuid.New()

	pres := &fakePresign{}
	svc := &attachment.Service{
		DB:      pool,
		Presign: pres,
		Bucket:  "bucket",
	}

	res, err := svc.IssueUpload(ctx, attachment.IssueInput{
		OwnerType:  "post",
		OwnerID:    ownerID,
		UploaderID: uploaderID,
		Filename:   "image.png",
		MimeType:   "image/png",
		SizeBytes:  10240,
	})
	if err != nil {
		t.Fatalf("issue: %v", err)
	}
	if res.UploadURL == "" || res.AttachmentID == uuid.Nil {
		t.Fatalf("bad result: %+v", res)
	}
	if !strings.Contains(res.UploadURL, "image.png") {
		t.Errorf("expected URL to include filename, got %s", res.UploadURL)
	}
	if pres.puts != 1 {
		t.Errorf("presign puts: got %d want 1", pres.puts)
	}

	// Pending row exists.
	var state string
	if err := pool.QueryRow(ctx,
		`SELECT state FROM attachments WHERE id = $1`, res.AttachmentID).Scan(&state); err != nil {
		t.Fatalf("scan: %v", err)
	}
	if state != "pending" {
		t.Errorf("state: got %q want pending", state)
	}

	// Confirm flips to ready.
	if err := svc.Confirm(ctx, res.AttachmentID, uploaderID, []byte{0x01, 0x02}); err != nil {
		t.Fatalf("confirm: %v", err)
	}
	if err := pool.QueryRow(ctx,
		`SELECT state FROM attachments WHERE id = $1`, res.AttachmentID).Scan(&state); err != nil {
		t.Fatalf("scan2: %v", err)
	}
	if state != "ready" {
		t.Errorf("state after confirm: got %q want ready", state)
	}

	// IssueDownload returns a presigned URL.
	url, _, err := svc.IssueDownload(ctx, res.AttachmentID)
	if err != nil {
		t.Fatalf("download: %v", err)
	}
	if !strings.Contains(url, "?get") {
		t.Errorf("download URL: got %s", url)
	}

	// ListByOwner sees it now.
	list, err := svc.ListByOwner(ctx, "post", ownerID)
	if err != nil {
		t.Fatalf("list: %v", err)
	}
	if len(list) != 1 {
		t.Errorf("list: got %d want 1", len(list))
	}
}

func TestIssueUploadRejectsOversize(t *testing.T) {
	pool := pgtest.Pool(t)
	svc := &attachment.Service{DB: pool, Presign: &fakePresign{}, Bucket: "b"}
	_, err := svc.IssueUpload(context.Background(), attachment.IssueInput{
		OwnerType:  "post",
		OwnerID:    uuid.New(),
		UploaderID: uuid.New(),
		Filename:   "huge.bin",
		MimeType:   "application/octet-stream",
		SizeBytes:  attachment.MaxSizeBytes + 1,
	})
	if err != attachment.ErrTooLarge {
		t.Errorf("err: got %v want ErrTooLarge", err)
	}
}

func TestTombstoneOnlyByUploader(t *testing.T) {
	pool := pgtest.Pool(t)
	ctx := context.Background()

	uploader := uuid.New()
	intruder := uuid.New()
	for _, id := range []uuid.UUID{uploader, intruder} {
		if _, err := pool.Exec(ctx, `
            INSERT INTO principals (id, kind, status, global_uri, display_name, email)
            VALUES ($1, 'user', 'active', $2, 'X', $3)
        `, id, "local://principals/"+id.String(), id.String()+"@example.com"); err != nil {
			t.Fatalf("seed: %v", err)
		}
	}

	svc := &attachment.Service{DB: pool, Presign: &fakePresign{}, Bucket: "b"}
	res, err := svc.IssueUpload(ctx, attachment.IssueInput{
		OwnerType: "post", OwnerID: uuid.New(), UploaderID: uploader,
		Filename: "a.txt", MimeType: "text/plain", SizeBytes: 4,
	})
	if err != nil {
		t.Fatalf("issue: %v", err)
	}
	_ = svc.Confirm(ctx, res.AttachmentID, uploader, nil)

	if err := svc.Tombstone(ctx, res.AttachmentID, intruder); err == nil {
		t.Error("intruder should not be able to tombstone")
	}
	if err := svc.Tombstone(ctx, res.AttachmentID, uploader); err != nil {
		t.Errorf("uploader tombstone: %v", err)
	}
}
