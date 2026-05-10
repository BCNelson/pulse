# Workplace Communication Platform: Technical Architecture (v1 Draft)

This document specifies the v1 implementation architecture for the platform described in `product-architecture-v1.md` and the Q1–Q4 decision documents. It assumes those product decisions as inputs and addresses the technical "how."

## Stack

- **Frontend:** Flutter (mobile, desktop, web from one codebase)
- **API:** GraphQL over HTTPS (queries, mutations) and WebSocket (subscriptions)
- **Backend:** Go single-binary service
- **Datastore:** PostgreSQL (16+) — the *only* required backend dependency

No Redis, no Elasticsearch, no Kafka, no separate search service. Postgres carries durable storage, full-text search, pub/sub for real-time delivery, and the job queue. This constraint shapes a number of decisions below; where it costs us, that cost is called out.

**Single-tenant.** v1 hosts one workspace per deployment. There is no `workspace_id` discriminator on tables, no per-tenant routing layer, no schema-per-workspace. Workspace-level configuration is deployment configuration (env vars + a small singleton `workspace_config` table). Multi-workspace coexistence on shared infrastructure is a federation question, not a multi-tenancy question — and federation itself is v2. This simplifies the schema considerably: every table is implicitly scoped to "this workspace," so no query needs to carry a tenant predicate, no index needs a tenant prefix, and admin tooling doesn't need tenant context.

## Architectural Principles

1. **Postgres is the system of record and the coordination plane.** `LISTEN/NOTIFY` for real-time, `tsvector` for search, `SELECT ... FOR UPDATE SKIP LOCKED` for the job queue. We do not stand up a second datastore in v1.
2. **The data model mirrors the product model.** Tags, principals, and tag-typed fields are first-class. We do not collapse them into ad-hoc denormalizations that lose the unified mechanics.
3. **Permissions are evaluated centrally, not at each call site.** A single permission service is consulted by every resolver. Caching is per-request.
4. **Federation-shaped IDs from day one.** Internal UUIDs are paired with a globally addressable URI form. v1 deployments are single-instance, but content references don't bake in localhost assumptions.
5. **One binary, configurable role.** The Go service runs as `--mode=api`, `--mode=worker`, or both. Same code, same deployment artifact, different process flags.

---

## Data Layer (Postgres)

### Tag Hierarchy

Tags use an **adjacency list + closure table**:

```sql
CREATE TABLE tags (
  id              UUID PRIMARY KEY,
  parent_id       UUID REFERENCES tags(id),
  slug            TEXT NOT NULL,
  display_name    TEXT NOT NULL,
  root_kind       TEXT NOT NULL CHECK (root_kind IN ('org', 'user')),
  bound_principal UUID REFERENCES principals(id),  -- only for user-tag roots
  defaults        JSONB NOT NULL DEFAULT '{}',     -- privacy, sort, chat-on, notif
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  archived_at     TIMESTAMPTZ,
  UNIQUE (parent_id, slug)
);

CREATE TABLE tag_closure (
  ancestor_id   UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  descendant_id UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  depth         INT  NOT NULL,
  PRIMARY KEY (ancestor_id, descendant_id)
);
CREATE INDEX ON tag_closure (descendant_id, depth);
```

A tag is its own ancestor and descendant at depth 0. `tag_closure` is maintained transactionally on insert/move/delete (in the service layer, not via triggers — we want the logic explicit and testable).

Why this shape:
- **Permission cascading** (Q3) and **subscription cascading** are descendant queries against `tag_closure`. Indexed and fast.
- **Move** (Q1) is a closure-table rebuild of the moved subtree, executed inside a single transaction with a row lock on the source root. Adjacency `parent_id` makes the structural integrity invariants easy to assert.
- **Stable IDs** are first-class. Display path is computed by walking `parent_id` (cached on read) — never used as an identifier.

`ltree` was considered. It's elegant for the simple case but the tilde in `~alice` and the slash in `engineering/backend` need encoding, moves require global rewrites of stored paths, and we'd still need a closure-style structure for permission and subscription queries. Closure table is clearer for the operations that matter.

### Principals

```sql
CREATE TABLE principals (
  id            UUID PRIMARY KEY,
  kind          TEXT NOT NULL CHECK (kind IN ('user', 'bot')),
  home_tag_id   UUID REFERENCES tags(id),  -- the principal's bound tag
  status        TEXT NOT NULL CHECK (status IN ('active', 'tombstoned')),
  global_uri    TEXT NOT NULL UNIQUE,      -- e.g. 'local://principals/<uuid>' or '<instance>/principals/<uuid>'
  display_name  TEXT NOT NULL,
  email         TEXT,                       -- for users; null for bots
  tombstoned_at TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE user_credentials (
  principal_id UUID PRIMARY KEY REFERENCES principals(id),
  password_hash TEXT,
  totp_secret  TEXT,
  -- + provider-linked auth columns as needed
  revoked_at   TIMESTAMPTZ
);

CREATE TABLE bot_credentials (
  principal_id  UUID PRIMARY KEY REFERENCES principals(id),
  api_key_hash  TEXT NOT NULL,
  owner_principal_id UUID REFERENCES principals(id),
  revoked_at    TIMESTAMPTZ
);
```

Tombstoning is a status change, not a delete. Auth credentials get revoked separately (so admin tooling can revoke without tombstoning, and offboarding can tombstone without losing attribution).

### Permissions

```sql
CREATE TABLE tag_grants (
  tag_id        UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  principal_id  UUID NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  bundle        TEXT NOT NULL CHECK (bundle IN ('viewer', 'contributor', 'moderator', 'owner')),
  extra_perms   TEXT[] NOT NULL DEFAULT '{}',  -- additive overrides
  cascade       BOOLEAN NOT NULL DEFAULT TRUE,
  granted_by    UUID REFERENCES principals(id),
  granted_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (tag_id, principal_id)
);

CREATE INDEX ON tag_grants (principal_id);
```

Effective permission for principal P on tag T is computed by:

```sql
SELECT bundle, extra_perms, tag_id, depth
FROM tag_grants g
JOIN tag_closure c ON c.ancestor_id = g.tag_id
WHERE c.descendant_id = $T
  AND g.principal_id = $P
  AND (c.depth = 0 OR g.cascade = TRUE);
```

The result set is unioned (max bundle, union of `extra_perms`). The query is fully indexed and fast even on deep trees.

Q3's two-layer model (tag visibility + post tag-roles) is implemented by:
- The above for tag-level membership.
- A separate `post_tags` table carrying the per-post `view`/`interact`/`moderate` role flags.

The "max across all tags" rule is the union/maximum of the cross product.

### Subscriptions

```sql
CREATE TABLE subscriptions (
  principal_id   UUID NOT NULL REFERENCES principals(id) ON DELETE CASCADE,
  tag_id         UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  cascade        BOOLEAN NOT NULL DEFAULT TRUE,
  urgency        TEXT NOT NULL DEFAULT 'normal' CHECK (urgency IN ('high', 'normal', 'low', 'mute')),
  reason_filter  TEXT[] NOT NULL DEFAULT '{}',  -- empty = all reasons
  PRIMARY KEY (principal_id, tag_id)
);
```

Same closure-join shape for "is principal P subscribed to tag T?"

### Posts and Comments

```sql
CREATE TABLE posts (
  id              UUID PRIMARY KEY,
  title           TEXT NOT NULL,
  body            TEXT NOT NULL,
  body_tsv        tsvector GENERATED ALWAYS AS (
                    setweight(to_tsvector('english', coalesce(title,'')), 'A') ||
                    setweight(to_tsvector('english', coalesce(body,'')),  'B')
                  ) STORED,
  author_id       UUID NOT NULL REFERENCES principals(id),
  decision_status TEXT CHECK (decision_status IN ('decision', 'answer')),
  deny_flag       BOOLEAN NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  edited_at       TIMESTAMPTZ,
  deleted_at      TIMESTAMPTZ
);
CREATE INDEX posts_body_tsv_idx ON posts USING GIN (body_tsv);

CREATE TABLE post_tags (
  post_id        UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  tag_id         UUID NOT NULL REFERENCES tags(id),
  view_role      BOOLEAN NOT NULL DEFAULT TRUE,
  interact_role  BOOLEAN NOT NULL DEFAULT TRUE,
  moderate_role  BOOLEAN NOT NULL DEFAULT TRUE,
  added_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (post_id, tag_id)
);

CREATE TABLE post_mentions (
  post_id      UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  principal_id UUID NOT NULL REFERENCES principals(id),
  PRIMARY KEY (post_id, principal_id)
);

CREATE TABLE comments (
  id              UUID PRIMARY KEY,
  post_id         UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  parent_id       UUID REFERENCES comments(id),
  path            ltree NOT NULL,           -- materialized path for tree ordering
  author_id       UUID NOT NULL REFERENCES principals(id),
  body            TEXT NOT NULL,
  body_tsv        tsvector GENERATED ALWAYS AS (
                    to_tsvector('english', coalesce(body, ''))
                  ) STORED,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  edited_at       TIMESTAMPTZ,
  deleted_at      TIMESTAMPTZ
);
CREATE INDEX comments_path_idx     ON comments USING GIST (path);
CREATE INDEX comments_post_id_idx  ON comments (post_id);
CREATE INDEX comments_body_tsv_idx ON comments USING GIN (body_tsv);
```

Comments use `ltree` because, unlike tags, comments don't move and the depth/ancestor queries are simple. `path` is `<post_id>.<comment_uuid>.<comment_uuid>...` with the UUID hex stripped of dashes.

`reactions`, `post_views`, etc. follow the same shape — omitted here for length.

### Chat Rooms and Messages

```sql
CREATE TABLE chat_rooms (
  id          UUID PRIMARY KEY,
  defaults    JSONB NOT NULL DEFAULT '{}',
  is_dm       BOOLEAN NOT NULL DEFAULT FALSE,  -- denormalized; computed on participant change
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  archived_at TIMESTAMPTZ
);

CREATE TABLE chat_room_tags (
  chat_room_id UUID NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  tag_id       UUID NOT NULL REFERENCES tags(id),
  PRIMARY KEY (chat_room_id, tag_id)
);

CREATE TABLE chat_room_participants (
  chat_room_id UUID NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  principal_id UUID NOT NULL REFERENCES principals(id),
  role         TEXT NOT NULL DEFAULT 'member' CHECK (role IN ('member', 'admin')),
  joined_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  left_at      TIMESTAMPTZ,                  -- null = current; set = retains historical read access
  PRIMARY KEY (chat_room_id, principal_id)
);

CREATE TABLE messages (
  id              UUID PRIMARY KEY,
  chat_room_id    UUID NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  author_id       UUID NOT NULL REFERENCES principals(id),
  body            TEXT NOT NULL,
  body_tsv        tsvector GENERATED ALWAYS AS (to_tsvector('english', body)) STORED,
  reply_to        UUID REFERENCES messages(id),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  edited_at       TIMESTAMPTZ,
  deleted_at      TIMESTAMPTZ,
  promoted_to_post UUID REFERENCES posts(id)
);
CREATE INDEX messages_room_created_idx ON messages (chat_room_id, created_at DESC);
CREATE INDEX messages_body_tsv_idx     ON messages USING GIN (body_tsv);
```

DM rendering is derived from `is_dm` (set when all participants belong to user-tag roots and no org tag is attached). When an org tag is added (DM → team space promotion, per the product doc), `is_dm` is recomputed.

### Tasks

```sql
CREATE TABLE tasks (
  id                UUID PRIMARY KEY,
  title             TEXT NOT NULL,
  description       TEXT,
  status            TEXT NOT NULL DEFAULT 'open',
  due_at            TIMESTAMPTZ,
  linked_post_id    UUID REFERENCES posts(id),
  linked_comment_id UUID REFERENCES comments(id),
  created_by        UUID NOT NULL REFERENCES principals(id),
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at        TIMESTAMPTZ
);

CREATE TABLE task_tags     (task_id UUID, tag_id UUID, PRIMARY KEY (task_id, tag_id));
CREATE TABLE task_assignees(task_id UUID, principal_id UUID, PRIMARY KEY (task_id, principal_id));
CREATE TABLE task_watchers (task_id UUID, principal_id UUID, PRIMARY KEY (task_id, principal_id));
```

Q5/Q6/Q7/Q8 (task dependencies, standalone task threads, templates, custom workflow) are deferred — schema accommodates additions without migration pain.

### Tag-Typed Fields

`assignees`, `watchers`, `mentions`, `participants`, etc. are realized as join tables (above). We considered a polymorphic `entity_principal_role(entity_type, entity_id, principal_id, role)` but rejected it: typed FKs catch more bugs at the DB layer, and the per-relation tables index better.

The "tag-typed field" abstraction lives in the application layer: a registry that knows which join tables drive which notification reasons. New fields add a row to the registry; notification fan-out, audit, and discovery infrastructure pick them up automatically.

### Audit Log

```sql
CREATE TABLE audit_events (
  id              BIGSERIAL PRIMARY KEY,
  acting_id       UUID NOT NULL REFERENCES principals(id),
  effective_id    UUID NOT NULL REFERENCES principals(id),  -- equals acting except during impersonation
  action          TEXT NOT NULL,                            -- e.g. 'tag.move', 'post.delete'
  target_type     TEXT NOT NULL,
  target_id       UUID NOT NULL,
  diff            JSONB,
  reason          TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX ON audit_events (target_type, target_id, created_at DESC);
CREATE INDEX ON audit_events (acting_id, created_at DESC);
CREATE INDEX ON audit_events (effective_id, created_at DESC);
```

Tag moves (Q1) write an `action='tag.move'` event with the source path, destination path, and computed permission diff in `diff`. The diff is the set of (principal, gained|lost) computed at move time — historical lookups can consult these events but cannot reconstruct point-in-time permissions, which Q1 explicitly accepts.

### Notifications Inbox

```sql
CREATE TABLE notifications (
  id            UUID PRIMARY KEY,
  recipient_id  UUID NOT NULL REFERENCES principals(id),
  reason        TEXT NOT NULL CHECK (reason IN ('assignment','mention','watcher','tag_subscription','dm')),
  urgency       TEXT NOT NULL CHECK (urgency IN ('high','normal','low')),
  source_type   TEXT NOT NULL,
  source_id     UUID NOT NULL,
  source_tag_id UUID REFERENCES tags(id),
  read_at       TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX ON notifications (recipient_id, created_at DESC);
CREATE INDEX ON notifications (recipient_id, read_at) WHERE read_at IS NULL;
```

Notifications are written by background workers, not synchronously in the request path (see Job Queue).

### Job Queue

```sql
CREATE TABLE jobs (
  id           BIGSERIAL PRIMARY KEY,
  kind         TEXT NOT NULL,
  payload      JSONB NOT NULL,
  run_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  attempts     INT NOT NULL DEFAULT 0,
  max_attempts INT NOT NULL DEFAULT 5,
  locked_at    TIMESTAMPTZ,
  locked_by    TEXT,
  status       TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','running','done','failed')),
  last_error   TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX jobs_pending_idx ON jobs (run_at) WHERE status = 'pending';
```

Workers claim jobs with `SELECT ... FOR UPDATE SKIP LOCKED LIMIT 1` and update status atomically. Standard Postgres queue pattern. Adequate for tens of thousands of jobs/min on modest hardware; well above v1 needs.

Job kinds include: `notification.fanout`, `audit.write` (for async audit), `retention.sweep`, `tag.move.permission_diff`, `search.reindex`.

### Search

Full-text search is `tsvector + GIN` per entity. A unified search across posts, comments, messages, and tasks is a `UNION ALL` view that, at query time, joins through the relevant tag relations and applies the visibility filter (see Permission Layer below).

```sql
CREATE VIEW searchable_content AS
  SELECT 'post'    AS kind, id, body_tsv, ... FROM posts    WHERE deleted_at IS NULL
  UNION ALL
  SELECT 'comment' AS kind, id, body_tsv, ... FROM comments WHERE deleted_at IS NULL
  UNION ALL
  SELECT 'message' AS kind, id, body_tsv, ... FROM messages WHERE deleted_at IS NULL
  UNION ALL
  SELECT 'task'    AS kind, id, ...                            FROM tasks    WHERE deleted_at IS NULL;
```

Search ranking uses `ts_rank_cd` blended with recency. Trigram (`pg_trgm`) is enabled separately for fuzzy tag-name search (Q4).

Postgres FTS scales comfortably to tens of millions of rows on appropriate hardware. Beyond that, a dedicated search engine becomes worth introducing, but that's well past v1.

### Soft Deletes and Retention

Every user-content table has `deleted_at TIMESTAMPTZ`. Reads filter `WHERE deleted_at IS NULL` by default. A `retention.sweep` job hard-deletes rows older than the workspace-configured retention window.

Compliance redaction (the GDPR-style operation called out in product offboarding) is a separate `redact_principal` operation that overwrites identifying fields and writes an audit event — distinct from soft delete.

---

## Backend Service (Go)

### Package Layout

```
cmd/
  server/        # main entry, mode=api|worker|both
internal/
  auth/          # session, JWT, MFA, credential management
  principal/     # principal lifecycle, tombstoning
  tag/           # tag tree, closure maintenance, moves, creation requests
  perm/          # permission evaluation, the central authority
  post/          # posts, comments, reactions
  chat/          # rooms, messages, promotion to post
  task/          # tasks
  notification/  # inbox, fan-out logic
  search/        # query construction, ranking
  audit/         # audit event writes
  job/           # queue, worker pool, job kind registry
  realtime/      # LISTEN/NOTIFY dispatch, GraphQL subscription bridge
  graphql/       # gqlgen-generated server, resolvers, dataloaders
  db/            # pgx pool, migrations runner
  federation/    # placeholder; URI handling and outbound mapping
pkg/
  ids/           # UUID + global URI helpers
  errs/          # typed errors (PermissionDenied, NotFound, Conflict, ...)
```

### Key Libraries

- **HTTP / GraphQL:** `chi` router + `gqlgen` (schema-first, codegen)
- **Database:** `pgx/v5` connection pool
- **Migrations:** `goose` or `golang-migrate`
- **Real-time:** raw `pgx` `Listen`/`WaitForNotification`
- **Logging/tracing:** `slog` + OpenTelemetry
- **Config:** environment variables + a single typed config struct

### Permission Layer

A single `perm.Service` exposes:

```go
type Service interface {
    Can(ctx context.Context, p PrincipalID, action Action, target TargetRef) (bool, error)
    Filter(ctx context.Context, p PrincipalID, action Action, targets []TargetRef) ([]TargetRef, error)
    EffectiveOnTag(ctx context.Context, p PrincipalID, tag TagID) (Bundle, []string, error)
}
```

Every mutation resolver calls `Can` before doing work. Every query resolver either calls `Filter` on result sets or constructs queries that join through the visibility predicate. Per-request caching via context is mandatory — the same tag/principal pair is checked many times in a single request.

The visibility predicate, expressed as a Postgres `WHERE` fragment that the data layer composes into queries:

```sql
EXISTS (
  SELECT 1 FROM tag_grants g
  JOIN tag_closure c ON c.ancestor_id = g.tag_id
  WHERE c.descendant_id = <content_tag>
    AND g.principal_id = <viewer>
    AND (c.depth = 0 OR g.cascade = TRUE)
)
```

For posts (multi-tagged) the predicate is wrapped in `EXISTS (SELECT 1 FROM post_tags pt WHERE pt.post_id = p.id AND <visibility_predicate(pt.tag_id)>)` — Q3's "any tag visible → post visible."

### Real-Time Dispatch

A dedicated long-lived pgx connection per API instance runs `LISTEN` on a fixed set of channel prefixes. Application writes that should produce real-time events emit `pg_notify(channel, payload)` inside the same transaction as the write — atomic with the data change.

Channel naming:

| Channel | Payload |
|---|---|
| `chat.room.<room_id>` | `{message_id, author_id}` |
| `notif.<principal_id>` | `{notification_id}` |
| `posts.tag.<tag_id>` | `{post_id, kind: 'created'|'updated'}` |
| `tag.<tag_id>.structure` | `{kind: 'moved'|'renamed'|'archived'}` |

Payloads carry IDs only — `NOTIFY` has an 8KB limit and we don't want to leak content into a log-sized side channel. The receiving instance's resolver fetches the actual content and applies a permission check before forwarding to subscribed GraphQL clients.

A single API instance fans `NOTIFY` deliveries out to in-process GraphQL subscriptions through a topic-keyed broadcaster. Multiple instances each receive every `NOTIFY` and each filters to its own connected subscribers — no extra coordination needed.

**Scale boundary:** `LISTEN/NOTIFY` is fine for thousands of concurrent connections and modest message rates. It is not appropriate for tens of thousands of concurrent live chat connections per database. When v1 outgrows that ceiling, the migration path is logical replication into a dedicated fan-out service — a v2 concern.

### Background Workers

Worker mode runs the same binary with `--mode=worker`. A pool of goroutines polls the `jobs` table. Job kinds register handlers in a typed registry:

```go
job.Register("notification.fanout", func(ctx context.Context, p NotificationFanoutPayload) error { ... })
```

The notification fan-out handler is illustrative: on every post create, comment create, task assignment, mention, and chat message, an enqueueing call writes a `notification.fanout` job in the same transaction. The worker resolves "who should be notified" via tag-typed-field rules, tag subscriptions, and per-tag urgency overrides, and writes `notifications` rows + emits `notif.<principal_id>` `NOTIFY`s.

### Migrations

Migrations are SQL files run on startup, idempotently. The closure table is rebuilt from `parent_id` if a consistency check fails — never trusted as the sole source of truth.

---

## GraphQL API

### Schema Shape

```graphql
interface Principal {
  id: ID!
  globalUri: String!
  displayName: String!
  homeTag: Tag!
  status: PrincipalStatus!
}
type User implements Principal { email: String, ... }
type Bot  implements Principal { ownerPrincipal: Principal, ... }

type Tag {
  id: ID!
  slug: String!
  displayName: String!
  path: String!
  parent: Tag
  children(first: Int, after: String): TagConnection!
  rootKind: TagRootKind!
  defaults: TagDefaults!
  chatRoom: ChatRoom
  posts(first: Int, after: String, sort: PostSort): PostConnection!
  tasks(first: Int, after: String, status: TaskStatus): TaskConnection!
  myPermissions: TagPermissions!
  mySubscription: Subscription
}

type Post {
  id: ID!
  url: String!
  title: String!
  body: String!
  author: Principal!
  tags: [PostTag!]!         # tag + role flags per Q3
  comments(first: Int, after: String): CommentConnection!
  reactions: [Reaction!]!
  decisionStatus: DecisionStatus
  denyFlag: Boolean!
  myPermissions: PostPermissions!
  createdAt: Time!
  editedAt: Time
}

type ChatRoom { ... }
type Message  { ... }
type Task     { ... }
type Notification { ... }

type Query {
  viewer: User!
  tag(id: ID, path: String): Tag
  post(id: ID!): Post
  search(query: String!, kinds: [SearchKind!], first: Int, after: String): SearchConnection!
  notifications(first: Int, after: String, filter: NotificationFilter): NotificationConnection!
}

type Mutation {
  createPost(input: CreatePostInput!): CreatePostPayload!
  promoteMessageToPost(messageId: ID!): PromoteMessageToPostPayload!
  moveTag(tagId: ID!, newParentId: ID!): MoveTagPayload!
  proposeTag(parentId: ID!, slug: String!, displayName: String!): ProposeTagPayload!
  ratifyTagProposal(requestId: ID!): RatifyTagProposalPayload!
  setDenyFlag(postId: ID!, deny: Boolean!): SetDenyFlagPayload!
  ...
}

type Subscription {
  messageAdded(roomId: ID!): Message!
  notificationReceived: Notification!
  postChanged(tagId: ID!): PostChange!
  tagStructureChanged(tagId: ID!): TagStructureChange!
}
```

Notes:

- **`myPermissions` fields** expose Q3 effective permissions to the client without separate round trips. They're cheap if computed alongside the entity fetch.
- **Pagination is Relay-style** (`Connection`/`Edge`/`PageInfo`) for consistency.
- **Errors are returned as result-envelope unions** for expected cases (`PermissionDenied`, `NotFound`, `Conflict`, validation errors). Unexpected errors surface through standard GraphQL errors. The Flutter client distinguishes the two clearly.
- **Authorization** runs at the resolver level via the central `perm.Service` and within data loaders via the visibility predicate. Field-level auth (e.g., hiding `email` from non-self viewers) is enforced in field resolvers.

### N+1 and Dataloaders

Every list-of-entities resolver routes through dataloaders for related principals, tags, and reactions. The data layer offers batch APIs (`GetPostsByIDs`, `GetTagsByIDs`, etc.) keyed by ID. This is non-negotiable — naive resolution is an instant performance disaster on any feed view.

### Subscriptions

GraphQL subscriptions over WebSocket (graphql-transport-ws). Each subscription registers an in-process listener keyed by topic; the real-time dispatcher fans `LISTEN` events into matching subscriptions.

A subscription's authorization is rechecked on every event: a user who loses access to a tag mid-session stops receiving its events, even before reconnecting.

---

## Frontend (Flutter)

### Stack Choices

- **GraphQL client:** `ferry` — typed, codegen-driven, normalized cache. The codegen story pairs well with strict GraphQL schema discipline. `graphql_flutter` is simpler but less rigorous; we accept ferry's setup cost for the maintenance benefit.
- **State management:** Riverpod (v2). Less boilerplate than Bloc, better testability, plays well with ferry's streams.
- **Routing:** `go_router`. Stable, supports deep linking (essential for permanent post URLs).
- **Local storage:** `drift` (SQLite) — only for offline drafts and a local cache of starred/recent items. Not a mirror of the server.
- **WebSocket:** `web_socket_channel` for subscription transport.

### Architecture

Three layers in the client:

1. **Data layer.** Ferry GraphQL operations + a thin repository wrapper per domain (PostRepo, TagRepo, ChatRepo, …). Repositories expose typed Dart streams and futures.
2. **State layer.** Riverpod providers consume repositories. Application state (current tag focus, command palette state, selection, optimistic updates) lives here.
3. **UI layer.** Flutter widgets consume providers. Stateless where possible; `ConsumerWidget` for reactive views.

### Real-Time Handling

GraphQL subscriptions are wrapped in Riverpod stream providers. The normalized cache writes incoming entities by ID; any open view of that entity rerenders automatically.

Optimistic updates (sending a chat message, marking a notification read) write to the cache immediately and reconcile on server confirmation.

### Offline Behavior

v1 treats offline as graceful degradation, not a first-class mode:

- Read views serve from the normalized cache when offline, with a clear "offline" indicator.
- Composing posts, comments, and chat messages writes to a local `drift` outbox; the outbox flushes on reconnect.
- No offline conflict resolution — last-write-wins, with the option to view both versions if conflict is detected on flush.

### Command Palette

Cmd+K (desktop) / a prominent search button (mobile) opens a unified palette: typed input fans out to tag search (trigram), full-text search, and a small set of action shortcuts ("New post", "New DM"). Implemented as a Riverpod-driven overlay; keyboard-first.

---

## Cross-Cutting Concerns

### Authentication

- Session cookies for web, refreshable bearer tokens for native clients. Both back onto the same `principals` + `user_credentials` rows.
- Bot principals authenticate with API keys bound to a single bot principal, optionally scoped to act on behalf of a specific user (`acting_principal` ≠ `effective_principal`).
- MFA is supported but optional for v1; workspace policy can require it.

### Impersonation

The `acting_principal` / `effective_principal` split is implemented at the request-context level. An impersonation grant is a short-lived token tied to a session and a target principal. Every audit event records both. Write actions during impersonation require an `elevated_until` flag on the session and produce additional audit metadata.

The product doc requires "visually loud, time-bounded, audit-logged, reason-required." Server-side enforcement covers time-bounding, audit, and reason. Visual loudness is enforced client-side by a global banner driven by a `viewerImpersonationState` query.

### Tag Move Execution (Q1)

A single transaction:

1. Acquire row lock on the moving tag and the destination parent.
2. Authority check via `perm.Can(p, OwnerOnTag, src)` and `perm.Can(p, OwnerOnTag, dest)`.
3. Compute permission diff: for each principal, evaluate effective permissions on every descendant of `src` before and after.
4. Update `parent_id` on the moving tag.
5. Rebuild `tag_closure` rows for the moved subtree (delete old ancestor edges, insert new ones).
6. Write `audit_events` row with the diff.
7. Emit `tag.<id>.structure` `NOTIFY`.

The diff in step 3 is bounded by the size of the moved subtree × number of principals with grants on either side. For pathological cases (large subtree, many principals) the work is enqueued as a background job and the move blocks on its completion — but the diff computation is part of the move, not optional.

### Promotion Paths

- **Chat message → post:** transactional. New post row; new `post_tags` entries copied from the chat room's tags at default roles (Q3); `messages.promoted_to_post` set. Promoter becomes author.
- **DM → team space:** adding an org tag to the chat room's tags. Recompute `is_dm`. No structural rewrite needed.
- **Comment → task:** new task with `linked_comment_id` set; tags inherited from the post.
- **Post → task:** new task with `linked_post_id` set.

All promotions write audit events and emit appropriate `NOTIFY`s.

### Tag Discovery (Q4)

- Tag search (`Query.searchTags`) uses `pg_trgm` similarity against `slug` and `display_name`, joined through the visibility predicate.
- Browsable tree (`Query.tag(id).children`) uses normal pagination. The viewer sees only their accessible subtree.
- No cross-tree topic search in v1, per Q4.

---

## Deployment Topology (v1)

Reference deployment:

```
[Flutter clients] ──HTTPS/WSS──> [Load balancer]
                                   │
                                   ▼
                       [Go API instances] (N replicas, mode=api)
                                   │
                                   ▼
                          [PostgreSQL primary]
                                   ▲
                                   │
                       [Go worker instances] (M replicas, mode=worker)
```

- **API instances** are stateless. They hold open `LISTEN` connections to Postgres and route real-time events to in-process subscribers.
- **Worker instances** poll the `jobs` table.
- **Postgres** is the only stateful component. Read replicas are *not* required for v1; introduce them when read load justifies and rewrite hot read paths to tolerate replica lag.
- Backups: pg_basebackup + WAL archiving. Standard.

A single Go binary serves both modes — the `--mode` flag is purely a process-level configuration.

---

## Scale Boundaries

The Postgres-only constraint sets soft ceilings worth being explicit about:

- **Concurrent real-time connections:** comfortable in the low thousands per API instance, with the database fanning `NOTIFY` to ~10–20 instances. Tens of thousands of concurrent live chat connections per workspace would be the trigger to evaluate a dedicated fan-out service.
- **Search corpus:** Postgres FTS scales well into tens of millions of indexed documents. Beyond that, an external search engine is the conventional move.
- **Job throughput:** the `SELECT ... SKIP LOCKED` pattern handles tens of thousands of jobs per minute on modest hardware.
- **Tag tree depth and breadth:** closure table size is `O(nodes × average_depth)`. For sane hierarchies (depth < 10, nodes < 100k) this is comfortable. Pathological structures (very deep, very wide) would be the trigger to revisit.

None of these are v1 problems. They're v2+ triggers to watch for.

---

## Open Technical Questions

The following are not resolved and need further work before or during implementation. Numbering continues from the product architecture's open questions.

### Data Model

25. **Reactions schema.** Per-emoji counts plus per-user reactions, both queried on every post view. Likely a denormalized counter table refreshed by trigger or job. Needs design.
26. **Edit history.** Posts and comments have `edited_at` but no version table. Workplace context probably wants edit history visible. v1 scope?
27. **Attachments.** Product doc defers files-as-first-class to v2. v1 still needs basic attachments — store metadata in Postgres, blobs where? S3-compatible object store would violate the Postgres-only constraint; storing blobs in Postgres is workable up to ~moderate size. Decision needed.

### Real-Time

28. **Presence (online/typing).** Not in product v1 explicitly, but expected. `LISTEN/NOTIFY` for typing indicators is fine; presence aggregates are awkward without a key-value store. Possibly an in-memory per-API-instance presence map gossip-synced via `NOTIFY`. Needs design.
29. **Read receipts vs. read state.** Product doc disallows read receipts but a personal "unread" indicator is needed. Per-principal-per-entity last-read timestamps in Postgres — schema is straightforward, write volume is the concern.

### Search

30. **Semantic / vector search.** `pgvector` is a Postgres extension and would not violate the constraint. Worth evaluating for the "what was decided about X" use case raised in product Q22, but not v1.
31. **Cross-entity search ranking.** Blending posts, messages, and tasks in one ranked result list needs a scoring model that doesn't unfairly favor any one kind. Initial heuristic: weight by entity importance × recency × ts_rank. Needs validation.

### Permissions

32. **Permission cache invalidation.** Per-request caching is straightforward. Cross-request caching (a global "permission view") would be valuable for hot tags but invalidation on grant changes, tag moves, and subscription updates is non-trivial. v1 likely skips it; revisit if per-request evaluation becomes hot.
33. **Write authorization for federated content.** Out of v1 scope but the perm service needs an extension point for "remote home instance authoritative" content.

### Frontend

34. **Code-sharing across mobile / desktop / web.** Flutter handles platform abstraction well, but command palette UX, keyboard shortcuts, and dense list views differ meaningfully. Decide which surfaces are platform-specific.
35. **Push notifications on mobile.** APNs / FCM integration is conventional but the routing logic ("this notification is high-priority for this user, deliver via push") needs to be in the worker. Schema-ready (`notifications.urgency`); delivery mechanism needs work.

### Operations

36. **Migrations under load.** Schema changes that touch large tables (closure, posts, messages, audit_events) need an online-migration strategy. Standard pg_repack / lazy backfill techniques apply.

---

## Status

This is a v1 technical architecture draft, derived from the product architecture and Q1–Q4 decisions. Implementation will surface refinements; this document should be treated as the structural baseline, not the final shape.
