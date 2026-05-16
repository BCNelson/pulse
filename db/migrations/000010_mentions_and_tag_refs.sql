-- +goose Up
-- +goose StatementBegin

-- Tag references parsed from post/comment/message bodies. Distinct from
-- post_tags (the ACL-bearing attachments) — these are link-only inline
-- references to other tags from inside a body string. Populated when the
-- body contains a canonical [#path/to/tag](pulse-tag:path/to/tag) link.
CREATE TABLE post_tag_refs (
  post_id BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  tag_id  BIGINT NOT NULL REFERENCES tags(id),
  PRIMARY KEY (post_id, tag_id)
);
CREATE INDEX post_tag_refs_tag_idx ON post_tag_refs (tag_id);

CREATE TABLE comment_tag_refs (
  comment_id BIGINT NOT NULL REFERENCES comments(id) ON DELETE CASCADE,
  tag_id     BIGINT NOT NULL REFERENCES tags(id),
  PRIMARY KEY (comment_id, tag_id)
);
CREATE INDEX comment_tag_refs_tag_idx ON comment_tag_refs (tag_id);

-- Messages now have first-class mentions, paralleling post_mentions /
-- comment_mentions. Populated from canonical [@slug](pulse-user:slug) links.
CREATE TABLE message_mentions (
  message_id   BIGINT NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  principal_id BIGINT NOT NULL REFERENCES principals(id),
  PRIMARY KEY (message_id, principal_id)
);
CREATE INDEX message_mentions_principal_idx ON message_mentions (principal_id);

CREATE TABLE message_tag_refs (
  message_id BIGINT NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  tag_id     BIGINT NOT NULL REFERENCES tags(id),
  PRIMARY KEY (message_id, tag_id)
);
CREATE INDEX message_tag_refs_tag_idx ON message_tag_refs (tag_id);

-- Backfill reverse indexes on the pre-existing mention tables so "who has
-- mentioned principal X?" queries (notification inboxes, profile pages)
-- don't seq-scan.
CREATE INDEX IF NOT EXISTS post_mentions_principal_idx    ON post_mentions (principal_id);
CREATE INDEX IF NOT EXISTS comment_mentions_principal_idx ON comment_mentions (principal_id);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP INDEX IF EXISTS comment_mentions_principal_idx;
DROP INDEX IF EXISTS post_mentions_principal_idx;
DROP TABLE IF EXISTS message_tag_refs;
DROP TABLE IF EXISTS message_mentions;
DROP TABLE IF EXISTS comment_tag_refs;
DROP TABLE IF EXISTS post_tag_refs;
-- +goose StatementEnd
