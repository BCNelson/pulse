-- +goose Up
-- +goose StatementBegin

-- ltree powers comment threading: each comment carries a materialized path
-- of comment-id labels, indexed with GIST for ancestor/descendant queries.
-- The DAL stores comment IDs in the path as their wire-form Crockford
-- string (12 chars, always starts with 'C') — alphanumeric and valid as
-- ltree labels.
CREATE EXTENSION IF NOT EXISTS ltree;

-- ----- posts -----

CREATE TABLE posts (
  id              BIGINT PRIMARY KEY DEFAULT gen_id_post(),
  title           TEXT NOT NULL,
  body            TEXT NOT NULL,
  body_tsv        tsvector GENERATED ALWAYS AS (
                    setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
                    setweight(to_tsvector('english', coalesce(body,  '')), 'B')
                  ) STORED,
  author_id       BIGINT NOT NULL REFERENCES principals(id),
  decision_status TEXT CHECK (decision_status IN ('decision', 'answer')),
  deny_flag       BOOLEAN NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  edited_at       TIMESTAMPTZ,
  deleted_at      TIMESTAMPTZ
);
CREATE INDEX posts_body_tsv_idx ON posts USING GIN (body_tsv);
CREATE INDEX posts_author_idx   ON posts (author_id, created_at DESC);
CREATE INDEX posts_active_idx   ON posts (created_at DESC) WHERE deleted_at IS NULL;

-- post_tags carries the Q3 "two-layer" model. tag-level grants give
-- visibility into the tag; the role booleans here decide whether the
-- viewer's tag-bundle confers view/interact/moderate against THIS post.
-- Default is true on all three for compatibility with existing tag grants.
CREATE TABLE post_tags (
  post_id        BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  tag_id         BIGINT NOT NULL REFERENCES tags(id),
  view_role      BOOLEAN NOT NULL DEFAULT TRUE,
  interact_role  BOOLEAN NOT NULL DEFAULT TRUE,
  moderate_role  BOOLEAN NOT NULL DEFAULT TRUE,
  added_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (post_id, tag_id)
);
CREATE INDEX post_tags_tag_idx ON post_tags (tag_id);

CREATE TABLE post_mentions (
  post_id      BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  principal_id BIGINT NOT NULL REFERENCES principals(id),
  PRIMARY KEY (post_id, principal_id)
);

-- Edit history (Q26): append-only snapshot of pre-edit state. Read-side
-- uses these to render "edited 3 times" with an expandable history. Not
-- truncated on retention sweep — historical text is part of the record.
CREATE TABLE post_edits (
  id          BIGSERIAL PRIMARY KEY,
  post_id     BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  editor_id   BIGINT NOT NULL REFERENCES principals(id),
  prev_title  TEXT NOT NULL,
  prev_body   TEXT NOT NULL,
  edited_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX post_edits_post_idx ON post_edits (post_id, edited_at DESC);

-- ----- comments -----

CREATE TABLE comments (
  id          BIGINT PRIMARY KEY DEFAULT gen_id_comment(),
  post_id     BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  parent_id   BIGINT REFERENCES comments(id),
  path        ltree NOT NULL,
  author_id   BIGINT NOT NULL REFERENCES principals(id),
  body        TEXT NOT NULL,
  body_tsv    tsvector GENERATED ALWAYS AS (
                to_tsvector('english', coalesce(body, ''))
              ) STORED,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  edited_at   TIMESTAMPTZ,
  deleted_at  TIMESTAMPTZ
);
CREATE INDEX comments_path_idx     ON comments USING GIST (path);
CREATE INDEX comments_post_idx     ON comments (post_id, created_at);
CREATE INDEX comments_body_tsv_idx ON comments USING GIN (body_tsv);
CREATE INDEX comments_active_idx   ON comments (post_id, created_at)
  WHERE deleted_at IS NULL;

CREATE TABLE comment_mentions (
  comment_id   BIGINT NOT NULL REFERENCES comments(id) ON DELETE CASCADE,
  principal_id BIGINT NOT NULL REFERENCES principals(id),
  PRIMARY KEY (comment_id, principal_id)
);

CREATE TABLE comment_edits (
  id          BIGSERIAL PRIMARY KEY,
  comment_id  BIGINT NOT NULL REFERENCES comments(id) ON DELETE CASCADE,
  editor_id   BIGINT NOT NULL REFERENCES principals(id),
  prev_body   TEXT NOT NULL,
  edited_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX comment_edits_comment_idx ON comment_edits (comment_id, edited_at DESC);

-- ----- reactions (Q25) -----
-- Separate tables for post and comment reactions: typed FKs catch more
-- bugs than a polymorphic discriminator. Aggregate counts are computed
-- with COUNT(*) GROUP BY emoji at read time; if benchmark shows hot
-- posts struggle, a denormalized counter table can be added without a
-- read-side change because reactions are accessed via a service method.

CREATE TABLE post_reactions (
  post_id      BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  principal_id BIGINT NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  emoji        TEXT NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (post_id, principal_id, emoji)
);
CREATE INDEX post_reactions_emoji_idx ON post_reactions (post_id, emoji);

CREATE TABLE comment_reactions (
  comment_id   BIGINT NOT NULL REFERENCES comments(id) ON DELETE CASCADE,
  principal_id BIGINT NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  emoji        TEXT NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (comment_id, principal_id, emoji)
);
CREATE INDEX comment_reactions_emoji_idx ON comment_reactions (comment_id, emoji);

-- ----- read state (Q29) -----
-- Per-principal-per-post last-read timestamp. Update volume is the concern;
-- M5 may batch upserts at the application layer if the synchronous path
-- becomes a hotspot.

CREATE TABLE principal_post_read (
  principal_id BIGINT NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  post_id      BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  last_read_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (principal_id, post_id)
);

-- ----- search -----
-- Unified searchable_content view across posts and comments. Messages and
-- tasks join in M3/M4 by recreating this view; CREATE OR REPLACE makes
-- forward migrations cheap.

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
  WHERE c.deleted_at IS NULL;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP VIEW IF EXISTS searchable_content;
DROP TABLE IF EXISTS principal_post_read;
DROP TABLE IF EXISTS comment_reactions;
DROP TABLE IF EXISTS post_reactions;
DROP TABLE IF EXISTS comment_edits;
DROP TABLE IF EXISTS comment_mentions;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS post_edits;
DROP TABLE IF EXISTS post_mentions;
DROP TABLE IF EXISTS post_tags;
DROP TABLE IF EXISTS posts;
-- ltree intentionally left enabled; downgrade does not unprovision shared extensions.
-- +goose StatementEnd
