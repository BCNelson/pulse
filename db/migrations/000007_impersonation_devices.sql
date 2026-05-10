-- +goose Up
-- +goose StatementBegin

-- Sessions gain an effective_principal_id column so a single session
-- can switch between the actual user (acting) and the impersonated
-- principal (effective). Defaults to NULL meaning "no impersonation"
-- — the application code interprets that as effective = acting.
ALTER TABLE sessions ADD COLUMN effective_principal_id UUID
  REFERENCES principals(id);
CREATE INDEX sessions_effective_idx ON sessions (effective_principal_id)
  WHERE effective_principal_id IS NOT NULL;

-- Device tokens: one row per (principal, token) so a user with mobile
-- + desktop has multiple. The push fan-out worker selects all rows
-- for a recipient and dispatches per platform.
CREATE TABLE device_tokens (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  principal_id  UUID NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  token         TEXT NOT NULL,
  platform      TEXT NOT NULL CHECK (platform IN ('ios', 'android', 'web')),
  registered_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_seen_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (principal_id, token)
);
CREATE INDEX device_tokens_principal_idx ON device_tokens (principal_id);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS device_tokens;
DROP INDEX IF EXISTS sessions_effective_idx;
ALTER TABLE sessions DROP COLUMN IF EXISTS effective_principal_id;
-- +goose StatementEnd
