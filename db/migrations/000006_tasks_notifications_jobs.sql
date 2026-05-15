-- +goose Up
-- +goose StatementBegin

-- ----- jobs -----
-- Standard Postgres queue: workers claim with FOR UPDATE SKIP LOCKED.
-- locked_at + locked_by tracked so a crash recovery sweep can release
-- abandoned in-flight jobs. Bigserial id — internal queue, not user-facing.
CREATE TABLE jobs (
  id           BIGSERIAL PRIMARY KEY,
  kind         TEXT NOT NULL,
  payload      JSONB NOT NULL,
  run_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  attempts     INT NOT NULL DEFAULT 0,
  max_attempts INT NOT NULL DEFAULT 5,
  locked_at    TIMESTAMPTZ,
  locked_by    TEXT,
  status       TEXT NOT NULL DEFAULT 'pending'
                CHECK (status IN ('pending','running','done','failed')),
  last_error   TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX jobs_pending_idx ON jobs (run_at) WHERE status = 'pending';
CREATE INDEX jobs_running_idx ON jobs (locked_at) WHERE status = 'running';

-- ----- tasks -----
-- linked_post_id / linked_comment_id capture the "promote" provenance:
-- a task hoisted from a post or comment retains the back-reference so
-- the source content can show "tracked as task #..." links.
CREATE TABLE tasks (
  id                BIGINT PRIMARY KEY DEFAULT gen_id_task(),
  title             TEXT NOT NULL,
  description       TEXT,
  body_tsv          tsvector GENERATED ALWAYS AS (
                      setweight(to_tsvector('english', coalesce(title, '')),       'A') ||
                      setweight(to_tsvector('english', coalesce(description, '')), 'B')
                    ) STORED,
  status            TEXT NOT NULL DEFAULT 'open'
                      CHECK (status IN ('open','in_progress','blocked','done','cancelled')),
  due_at            TIMESTAMPTZ,
  linked_post_id    BIGINT REFERENCES posts(id),
  linked_comment_id BIGINT REFERENCES comments(id),
  created_by        BIGINT NOT NULL REFERENCES principals(id),
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  edited_at         TIMESTAMPTZ,
  deleted_at        TIMESTAMPTZ
);
CREATE INDEX tasks_body_tsv_idx ON tasks USING GIN (body_tsv);
CREATE INDEX tasks_active_idx   ON tasks (created_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX tasks_status_idx   ON tasks (status, created_at DESC)
  WHERE deleted_at IS NULL;
CREATE INDEX tasks_creator_idx  ON tasks (created_by, created_at DESC);

-- task_tags carries the same Q3 "two-layer" model as post_tags. Tag-level
-- grants give visibility into the tag; the role booleans here decide
-- whether a tag-bundle confers view/interact/moderate against THIS task.
CREATE TABLE task_tags (
  task_id        BIGINT NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  tag_id         BIGINT NOT NULL REFERENCES tags(id),
  view_role      BOOLEAN NOT NULL DEFAULT TRUE,
  interact_role  BOOLEAN NOT NULL DEFAULT TRUE,
  moderate_role  BOOLEAN NOT NULL DEFAULT TRUE,
  added_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (task_id, tag_id)
);
CREATE INDEX task_tags_tag_idx ON task_tags (tag_id);

CREATE TABLE task_assignees (
  task_id      BIGINT NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  principal_id BIGINT NOT NULL REFERENCES principals(id),
  assigned_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  assigned_by  BIGINT REFERENCES principals(id),
  PRIMARY KEY (task_id, principal_id)
);
CREATE INDEX task_assignees_principal_idx ON task_assignees (principal_id);

CREATE TABLE task_watchers (
  task_id      BIGINT NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  principal_id BIGINT NOT NULL REFERENCES principals(id),
  added_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (task_id, principal_id)
);
CREATE INDEX task_watchers_principal_idx ON task_watchers (principal_id);

-- ----- notifications -----
-- Written by the notification.fanout worker, never synchronously in the
-- request path. recipient_id + read_at partial index drives the
-- "unread inbox" query, which is the hot path for badges.
-- source_id is a polymorphic typed-ID — kind is implicit in the high bits.
CREATE TABLE notifications (
  id            BIGINT PRIMARY KEY DEFAULT gen_id_notification(),
  recipient_id  BIGINT NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  reason        TEXT NOT NULL
                  CHECK (reason IN ('assignment','mention','watcher','tag_subscription','dm')),
  urgency       TEXT NOT NULL DEFAULT 'normal'
                  CHECK (urgency IN ('high','normal','low')),
  source_type   TEXT NOT NULL,
  source_id     BIGINT NOT NULL,
  source_tag_id BIGINT REFERENCES tags(id),
  read_at       TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX notifications_recipient_idx ON notifications (recipient_id, created_at DESC);
CREATE INDEX notifications_unread_idx    ON notifications (recipient_id, created_at DESC)
  WHERE read_at IS NULL;

-- Extend searchable_content to include tasks. CREATE OR REPLACE keeps the
-- migration cheap; the M3 view definition is supplanted in full.
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
  WHERE m.deleted_at IS NULL
  UNION ALL
  SELECT
    'task'::TEXT       AS kind,
    t.id               AS id,
    t.body_tsv         AS tsv,
    t.title            AS title,
    t.description      AS body,
    t.created_by       AS author_id,
    t.created_at       AS created_at
  FROM tasks t
  WHERE t.deleted_at IS NULL;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP VIEW IF EXISTS searchable_content;
CREATE OR REPLACE VIEW searchable_content AS
  SELECT 'post'::TEXT AS kind, p.id, p.body_tsv AS tsv, p.title, p.body, p.author_id, p.created_at
  FROM posts p WHERE p.deleted_at IS NULL
  UNION ALL
  SELECT 'comment'::TEXT, c.id, c.body_tsv, NULL::TEXT, c.body, c.author_id, c.created_at
  FROM comments c WHERE c.deleted_at IS NULL
  UNION ALL
  SELECT 'message'::TEXT, m.id, m.body_tsv, NULL::TEXT, m.body, m.author_id, m.created_at
  FROM messages m WHERE m.deleted_at IS NULL;

DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS task_watchers;
DROP TABLE IF EXISTS task_assignees;
DROP TABLE IF EXISTS task_tags;
DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS jobs;
-- +goose StatementEnd
