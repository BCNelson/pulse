-- +goose Up
-- +goose StatementBegin

-- Trigram index support — used by M2 fuzzy tag-name search. Enabling early
-- so the prerequisite is in place when those indexes are added.
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Singleton workspace configuration (per the single-tenant invariant).
CREATE TABLE workspace_config (
  id                    INT PRIMARY KEY DEFAULT 1 CHECK (id = 1),
  display_name          TEXT NOT NULL DEFAULT 'Pulse',
  retention_window_days INT  NOT NULL DEFAULT 365,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO workspace_config (id) VALUES (1) ON CONFLICT DO NOTHING;

-- principals: every actor in the system. home_tag_id and bound_principal
-- form a cycle with tags, so the FK is added after both tables exist.
CREATE TABLE principals (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind          TEXT NOT NULL CHECK (kind IN ('user', 'bot')),
  home_tag_id   UUID,                               -- FK added below
  status        TEXT NOT NULL DEFAULT 'active'
                 CHECK (status IN ('active', 'tombstoned')),
  global_uri    TEXT NOT NULL UNIQUE,
  display_name  TEXT NOT NULL,
  email         TEXT,                               -- users only; null for bots
  tombstoned_at TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX principals_status_idx ON principals (status);
CREATE UNIQUE INDEX principals_email_idx ON principals (lower(email))
  WHERE email IS NOT NULL AND status = 'active';

-- tags: hierarchy via adjacency list (parent_id) plus a closure table.
CREATE TABLE tags (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_id       UUID REFERENCES tags(id),
  slug            TEXT NOT NULL,
  display_name    TEXT NOT NULL,
  root_kind       TEXT NOT NULL CHECK (root_kind IN ('org', 'user')),
  bound_principal UUID REFERENCES principals(id),    -- only for user-tag roots
  defaults        JSONB NOT NULL DEFAULT '{}',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  archived_at     TIMESTAMPTZ,
  CHECK (
    (parent_id IS NULL AND root_kind = 'user' AND bound_principal IS NOT NULL) OR
    (parent_id IS NULL AND root_kind = 'org'  AND bound_principal IS NULL)     OR
    (parent_id IS NOT NULL)
  )
);

-- A non-root tag has unique slug within its parent.
CREATE UNIQUE INDEX tags_parent_slug_idx
  ON tags (parent_id, slug)
  WHERE parent_id IS NOT NULL;

-- A root tag has unique slug within its root_kind.
CREATE UNIQUE INDEX tags_root_kind_slug_idx
  ON tags (root_kind, slug)
  WHERE parent_id IS NULL;

-- One home tag per principal (the user-tag root).
CREATE UNIQUE INDEX tags_bound_principal_idx
  ON tags (bound_principal)
  WHERE bound_principal IS NOT NULL;

-- Now close the cycle: principals.home_tag_id -> tags.id.
ALTER TABLE principals
  ADD CONSTRAINT principals_home_tag_fkey
  FOREIGN KEY (home_tag_id) REFERENCES tags(id);

-- tag_closure: ancestor/descendant pairs. depth=0 for self, 1 for direct
-- parent, etc. Maintained transactionally by the application; never via
-- triggers. Indexed both directions because permission and subscription
-- queries traverse from descendant to ancestor.
CREATE TABLE tag_closure (
  ancestor_id   UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  descendant_id UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  depth         INT  NOT NULL CHECK (depth >= 0),
  PRIMARY KEY (ancestor_id, descendant_id)
);
CREATE INDEX tag_closure_descendant_depth_idx
  ON tag_closure (descendant_id, depth);

-- user_credentials: password + optional TOTP. Revocation is independent of
-- principal tombstoning so admin tooling can revoke without losing
-- attribution.
CREATE TABLE user_credentials (
  principal_id  UUID PRIMARY KEY REFERENCES principals(id) ON DELETE CASCADE,
  password_hash TEXT,
  totp_secret   TEXT,
  revoked_at    TIMESTAMPTZ,
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- bot_credentials: API keys. owner_principal_id captures who owns the bot
-- (a person), distinct from the principal_id (the bot itself).
CREATE TABLE bot_credentials (
  principal_id        UUID PRIMARY KEY REFERENCES principals(id) ON DELETE CASCADE,
  api_key_hash        TEXT NOT NULL,
  owner_principal_id  UUID REFERENCES principals(id),
  revoked_at          TIMESTAMPTZ,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX bot_credentials_owner_idx ON bot_credentials (owner_principal_id);

-- tag_grants: principal -> tag membership and bundle. cascade=true means the
-- grant applies to every descendant tag; cascade=false confines it to depth 0.
CREATE TABLE tag_grants (
  tag_id        UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  principal_id  UUID NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  bundle        TEXT NOT NULL CHECK (bundle IN ('viewer', 'contributor', 'moderator', 'owner')),
  extra_perms   TEXT[] NOT NULL DEFAULT '{}',
  cascade       BOOLEAN NOT NULL DEFAULT TRUE,
  granted_by    UUID REFERENCES principals(id),
  granted_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (tag_id, principal_id)
);
CREATE INDEX tag_grants_principal_idx ON tag_grants (principal_id);

-- subscriptions: principal -> tag firehose preference. Same closure-join
-- shape as grants for "is principal P subscribed to tag T?".
CREATE TABLE subscriptions (
  principal_id   UUID NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  tag_id         UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  cascade        BOOLEAN NOT NULL DEFAULT TRUE,
  urgency        TEXT NOT NULL DEFAULT 'normal'
                  CHECK (urgency IN ('high', 'normal', 'low', 'mute')),
  reason_filter  TEXT[] NOT NULL DEFAULT '{}',
  PRIMARY KEY (principal_id, tag_id)
);

-- audit_events: every mutation writes here. acting_id and effective_id are
-- the same except during impersonation. diff is action-specific JSON.
CREATE TABLE audit_events (
  id            BIGSERIAL PRIMARY KEY,
  acting_id     UUID NOT NULL REFERENCES principals(id),
  effective_id  UUID NOT NULL REFERENCES principals(id),
  action        TEXT NOT NULL,
  target_type   TEXT NOT NULL,
  target_id     UUID NOT NULL,
  diff          JSONB,
  reason        TEXT,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX audit_events_target_idx
  ON audit_events (target_type, target_id, created_at DESC);
CREATE INDEX audit_events_acting_idx
  ON audit_events (acting_id, created_at DESC);
CREATE INDEX audit_events_effective_idx
  ON audit_events (effective_id, created_at DESC);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS audit_events;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS tag_grants;
DROP TABLE IF EXISTS bot_credentials;
DROP TABLE IF EXISTS user_credentials;
DROP TABLE IF EXISTS tag_closure;
ALTER TABLE principals DROP CONSTRAINT IF EXISTS principals_home_tag_fkey;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS principals;
DROP TABLE IF EXISTS workspace_config;
-- pg_trgm intentionally left enabled; downgrade does not unprovision shared extensions.
-- +goose StatementEnd
