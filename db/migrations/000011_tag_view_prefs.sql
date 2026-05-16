-- +goose Up
-- +goose StatementBegin

-- Per-(principal, tag) feed view preferences. Sparse: a row only exists
-- when at least one pref differs from defaults. Today the only pref is
-- include_descendants — when TRUE, Tag.posts and Subscription.postChanged
-- expand the selected tag's feed to cover its tag_closure descendants.
CREATE TABLE tag_view_prefs (
  principal_id        BIGINT NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  tag_id              BIGINT NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  include_descendants BOOLEAN NOT NULL DEFAULT FALSE,
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (principal_id, tag_id)
);
CREATE INDEX tag_view_prefs_tag_idx ON tag_view_prefs (tag_id);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS tag_view_prefs;
-- +goose StatementEnd
