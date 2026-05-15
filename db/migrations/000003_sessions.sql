-- +goose Up
-- +goose StatementBegin

-- sessions: stateful auth tokens. Cookie (web) or bearer (native) — same
-- table backs both. token_hash is sha256(token) so the secret never lives
-- on disk. Stateful sessions (rather than JWTs) buy us logout-everywhere
-- and let M5's impersonation flow pin a session to an acting principal.
CREATE TABLE sessions (
  id            BIGINT PRIMARY KEY DEFAULT gen_id_session(),
  principal_id  BIGINT NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  token_hash    TEXT NOT NULL UNIQUE,
  user_agent    TEXT,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at    TIMESTAMPTZ NOT NULL,
  revoked_at    TIMESTAMPTZ
);
CREATE INDEX sessions_principal_idx ON sessions (principal_id);
CREATE INDEX sessions_expires_idx ON sessions (expires_at)
  WHERE revoked_at IS NULL;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS sessions;
-- +goose StatementEnd
