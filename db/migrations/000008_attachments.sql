-- +goose Up
-- +goose StatementBegin

-- Attachments are stored in an external S3-compatible bucket; the row
-- here is metadata only. storage_key is the bucket-relative path under
-- which the bytes live; the API never proxies bytes — clients PUT/GET
-- directly to the bucket via presigned URLs.
--
-- owner_type + owner_id is a polymorphic association into post|comment|
-- message. We accept the typed-FK trade-off here because the alternative
-- (one join table per kind) makes "all attachments for this entity"
-- queries miserable, and the kinds are stable.
CREATE TABLE attachments (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_type    TEXT NOT NULL CHECK (owner_type IN ('post','comment','message')),
  owner_id      UUID NOT NULL,
  uploader_id   UUID NOT NULL REFERENCES principals(id),
  storage_key   TEXT NOT NULL UNIQUE,
  filename      TEXT NOT NULL,
  mime_type     TEXT NOT NULL,
  size_bytes    BIGINT NOT NULL CHECK (size_bytes >= 0),
  sha256        BYTEA, -- nullable: client-claimed pre-upload, verified later
  state         TEXT NOT NULL DEFAULT 'pending'
                  CHECK (state IN ('pending','ready','tombstoned')),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  ready_at      TIMESTAMPTZ
);
CREATE INDEX attachments_owner_idx ON attachments (owner_type, owner_id);
CREATE INDEX attachments_uploader_idx ON attachments (uploader_id, created_at DESC);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS attachments;
-- +goose StatementEnd
