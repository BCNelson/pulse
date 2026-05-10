-- +goose Up
-- +goose StatementBegin

-- chat_rooms: a conversation. is_dm is denormalized — true iff every
-- participant lives under a user-tag root and no org tag is attached.
-- Recomputed by the chat service on participant or tag changes.
CREATE TABLE chat_rooms (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  defaults    JSONB NOT NULL DEFAULT '{}',
  is_dm       BOOLEAN NOT NULL DEFAULT FALSE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  archived_at TIMESTAMPTZ
);

-- chat_room_tags: org-tag attachment. A room with no tags is a DM by
-- definition. Adding a tag to an existing DM is the "DM → team space"
-- promotion path; recompute is_dm afterward.
CREATE TABLE chat_room_tags (
  chat_room_id UUID NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  tag_id       UUID NOT NULL REFERENCES tags(id),
  PRIMARY KEY (chat_room_id, tag_id)
);

-- chat_room_participants: who's in the room. left_at NULL means current
-- member; setting left_at preserves historical read access (per
-- architecture: "set = retains historical read access").
CREATE TABLE chat_room_participants (
  chat_room_id UUID NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  principal_id UUID NOT NULL REFERENCES principals(id),
  role         TEXT NOT NULL DEFAULT 'member' CHECK (role IN ('member', 'admin')),
  joined_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  left_at      TIMESTAMPTZ,
  PRIMARY KEY (chat_room_id, principal_id)
);
CREATE INDEX chat_room_participants_principal_idx
  ON chat_room_participants (principal_id)
  WHERE left_at IS NULL;

-- messages: chat content. promoted_to_post is non-null iff this message
-- got hoisted into a post — preserves the link both directions for
-- "where did this thread come from?" UI.
CREATE TABLE messages (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  chat_room_id     UUID NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  author_id        UUID NOT NULL REFERENCES principals(id),
  body             TEXT NOT NULL,
  body_tsv         tsvector GENERATED ALWAYS AS (
                     to_tsvector('english', coalesce(body, ''))
                   ) STORED,
  reply_to         UUID REFERENCES messages(id),
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  edited_at        TIMESTAMPTZ,
  deleted_at       TIMESTAMPTZ,
  promoted_to_post UUID REFERENCES posts(id)
);
CREATE INDEX messages_room_created_idx ON messages (chat_room_id, created_at DESC);
CREATE INDEX messages_body_tsv_idx     ON messages USING GIN (body_tsv);
CREATE INDEX messages_active_idx       ON messages (chat_room_id, created_at DESC)
  WHERE deleted_at IS NULL;

-- Extend the searchable_content view to include messages. Tasks join in M4.
CREATE OR REPLACE VIEW searchable_content AS
  SELECT
    'post'::TEXT       AS kind,
    p.id               AS id,
    p.body_tsv         AS tsv,
    p.title            AS title,
    p.body             AS body,
    p.author_id        AS author_id,
    p.created_at       AS created_at
  FROM posts p
  WHERE p.deleted_at IS NULL
  UNION ALL
  SELECT
    'comment'::TEXT    AS kind,
    c.id               AS id,
    c.body_tsv         AS tsv,
    NULL::TEXT         AS title,
    c.body             AS body,
    c.author_id        AS author_id,
    c.created_at       AS created_at
  FROM comments c
  WHERE c.deleted_at IS NULL
  UNION ALL
  SELECT
    'message'::TEXT    AS kind,
    m.id               AS id,
    m.body_tsv         AS tsv,
    NULL::TEXT         AS title,
    m.body             AS body,
    m.author_id        AS author_id,
    m.created_at       AS created_at
  FROM messages m
  WHERE m.deleted_at IS NULL;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- Drop the extended view and recreate the M2 version so the M2 migration
-- remains the source of truth for that schema state on a downgrade.
DROP VIEW IF EXISTS searchable_content;
CREATE OR REPLACE VIEW searchable_content AS
  SELECT 'post'::TEXT AS kind, p.id, p.body_tsv AS tsv, p.title, p.body, p.author_id, p.created_at
  FROM posts p WHERE p.deleted_at IS NULL
  UNION ALL
  SELECT 'comment'::TEXT, c.id, c.body_tsv, NULL::TEXT, c.body, c.author_id, c.created_at
  FROM comments c WHERE c.deleted_at IS NULL;

DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS chat_room_participants;
DROP TABLE IF EXISTS chat_room_tags;
DROP TABLE IF EXISTS chat_rooms;
-- +goose StatementEnd
