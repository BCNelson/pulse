# Pulse operations

This is the runbook side of the architecture. Backups, retention,
online migrations, redaction, observability — what an operator needs
to keep a Pulse install healthy.

## Backups

Pulse keeps everything in two places: Postgres + an S3-compatible
bucket. Both have well-known backup paths.

### Postgres

Use `pg_basebackup` for a base + WAL archiving for point-in-time
recovery. A minimal scripted setup:

```bash
# postgresql.conf
wal_level = replica
archive_mode = on
archive_command = 'aws s3 cp %p s3://pulse-wal/%f --no-progress'
max_wal_senders = 3
```

```bash
# Daily base backup (cron, on the DB host)
#!/usr/bin/env bash
set -euo pipefail
DEST=/var/backups/pulse/base-$(date +%Y%m%dT%H%M%SZ)
pg_basebackup --pgdata="$DEST" --format=tar --gzip --progress --label="pulse-$(date -Iseconds)"
aws s3 sync "$DEST" "s3://pulse-base/$(basename "$DEST")"
find /var/backups/pulse -mindepth 1 -maxdepth 1 -mtime +14 -exec rm -rf {} +
```

Restore: `pg_basebackup` extract → `recovery.signal` → set
`restore_command` to pull from `s3://pulse-wal/`. Standard Postgres
PITR — no Pulse-specific steps.

### Attachments bucket

Bucket-native versioning + lifecycle rules carry the load:

- Enable versioning on the attachments bucket.
- Lifecycle rule: tombstoned/deleted versions expire after the
  workspace retention window + 7 days (retention sweep removes the
  rows past that window; the lifecycle rule trims the bytes shortly
  after).
- Cross-region replication if your deployment requires it.

The Pulse server itself never deletes bucket bytes — the row's
`state='tombstoned'` is the soft-delete marker, the lifecycle rule
finalizes.

## Retention sweep

The retention sweep is a worker job (`retention.sweep`) that
hard-deletes soft-deleted content past
`workspace_config.retention_window_days`. Tunable per install:

```sql
UPDATE workspace_config SET retention_window_days = 365 WHERE id = 1;
```

Defaults to 365 days. The scheduler in `--mode=worker` enqueues a
sweep at boot and daily thereafter; multi-replica deployments should
pick a single scheduler replica (set
`PULSE_DISABLE_RETENTION_SCHEDULE=true` on the others) or move the
schedule to an external cron.

What gets purged on each sweep:

- `posts`/`comments`/`messages`/`tasks` with `deleted_at` past cutoff
- `attachments` rows with `state='tombstoned'` past cutoff (bytes
  reclaimed by the bucket lifecycle rule)
- `notifications` with `read_at` past cutoff (unread are kept — we
  never silently drop unread)

Audit, perm grants, and structural rows are never touched.

## Redaction

The `redact_principal` operation overwrites identifying fields on a
principal and their authored content. Distinct from soft-delete:
soft-delete *hides*, redaction *sanitizes*. Run this when legal asks
"forget this user".

Effects:

- `principals.display_name` → `[redacted]`
- `principals.email` → NULL
- `principals.status` → `tombstoned`
- All authored posts/comments/messages/tasks → body becomes
  `[redacted by retention policy]`
- All sessions revoked, bot keys revoked, tag grants/subscriptions
  dropped, device tokens removed
- One audit row stamps the action with the caller (workspace admin)
  and the reason

The structural graph stays intact — comment threads still resolve,
reaction counts are preserved. Only the identifying text changes.

GraphQL surface is intentionally absent: redaction is a sensitive
operation that should be performed via direct SQL or a dedicated CLI
under operator authorization. M5+ may add an admin-only mutation if a
self-serve flow is desired.

## Online migrations

Three patterns cover most v1 needs.

### Pattern 1: additive column with default

`ALTER TABLE` with a constant default in Postgres 11+ is metadata-only
and instantaneous. Use directly.

```sql
ALTER TABLE posts ADD COLUMN priority INT NOT NULL DEFAULT 0;
```

### Pattern 2: index without locking

`CREATE INDEX CONCURRENTLY` builds without taking a write lock. Always
prefer this on production tables.

```sql
CREATE INDEX CONCURRENTLY posts_decision_idx ON posts (decision_status)
  WHERE decision_status IS NOT NULL;
```

### Pattern 3: expand-contract for breaking changes

Worked example: renaming `posts.body` to `posts.content`.

```sql
-- Migration N: expand. Add the new column, dual-write in app code.
ALTER TABLE posts ADD COLUMN content TEXT;
UPDATE posts SET content = body WHERE content IS NULL; -- backfill
-- Optional: trigger keeps them in sync until the cut-over.

-- Migration N+1: cut-over. Switch reads to the new column. Old code
-- keeps writing both via dual-write logic. Deploy.

-- Migration N+2: contract. Drop dual-write code. Drop old column
-- after one full release window.
ALTER TABLE posts DROP COLUMN body;
```

For very large tables consider `pg_repack` to reclaim space without a
full table lock; it's a separate tool but pairs cleanly with
expand-contract.

## Observability

The API exposes:

- **`GET /healthz`** — pings Postgres, returns 200/503. No auth.
- **`GET /metrics`** — Prometheus exposition format. Default Go +
  process collectors plus Pulse-specific counters (`pulse_*`). v1
  ships without auth on the endpoint; deploy behind a private network
  or a basic-auth proxy.

Metrics worth alerting on:

- `pulse_jobs_failed_total{kind=...}` rate — climbing means a job kind
  is exhausting retries.
- `pulse_realtime_dropped_total` rate — slow subscribers; LISTEN/NOTIFY
  ceiling.
- `pulse_subscriptions_active` — track against the scale boundary
  (low thousands per DB instance).

OpenTelemetry traces are produced by `gqlgen`'s instrumentation hook
when `OTEL_EXPORTER_OTLP_ENDPOINT` is set. Standard environment
variables apply (`OTEL_RESOURCE_ATTRIBUTES`, `OTEL_SERVICE_NAME`).

## Push notifications

Two providers ship in M6: FCM (Android, web) and APNs (iOS).
Configuration is purely environmental — see
`deploy/systemd/pulse.env.example`. With both unset, Pulse falls back
to the `LogProvider` stub that just logs each push (useful for dev).

## Federation

`internal/federation` holds the URI mapping helpers and a
perm-service extension point flagged for v2. v1 is single-instance;
the federation seam keeps that future open without paying for it
today.
