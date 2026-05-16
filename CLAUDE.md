# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Stack

Go 1.26 GraphQL API (`gqlgen`, `chi`, `pgx`) + Flutter client (`ferry`, `riverpod`, `drift`, `go_router`). Single-tenant. Postgres 16 is the entire backend — no Redis, Kafka, or Elasticsearch. Development environment is `devenv` + `direnv` (Nix).

## Commands

`devenv shell` first; all scripts below are defined in `devenv.nix`. The README lists them all — these are the ones you'll reach for most:

- `devenv up` — Postgres + RustFS (S3) + API with `air` hot reload on `services/api/{*.go,*.graphql,*.sql}`.
- `seed` / `seed -fresh` / `reset-db` — populate, wipe-and-repopulate, or full schema reset.
- `devenv test` — Go tests. **Requires a Docker daemon** (testcontainers spin up Postgres + RustFS).
- Single Go test: `go test ./services/api/internal/<pkg> -run TestName -race`.
- `mobile`, `mobile-b` — run Flutter (devA / devB instance IDs for side-by-side clients). `mobile-codegen` / `mobile-watch` for `build_runner`. `mobile-init` is the one-time bootstrap.
- `migrate up|down|status|create NAME sql`, `dbshell` — Goose / psql passthrough. The API also runs migrations on startup, so a normal restart is usually enough.
- GraphQL codegen: `cd services/api && go run github.com/99designs/gqlgen generate` (server); `cd apps/mobile && dart run build_runner build` (client).
- `flutter analyze` from `apps/mobile/` for Dart lint.

## Architecture

**Monorepo.** `services/api` is a single Go binary; `apps/mobile` is one Flutter app for mobile/desktop/web. Tied together by `go.work`. There are no microservices.

**Dual-mode binary.** The API runs as `--mode=api` (request handler) or `--mode=worker` (polls `jobs` table via `SELECT … FOR UPDATE SKIP LOCKED`). Same binary, same image — deployment chooses the mode.

**Postgres-only.** This is a deliberate constraint:
- Real-time: native `LISTEN/NOTIFY` → per-instance broadcaster → GraphQL WebSocket subscriptions. Payloads carry IDs only (8 KB NOTIFY cap); clients refetch.
- Job queue: skip-locked polling, no broker.
- Search: built-in FTS.
- Migrations: embedded Goose, auto-applied on binary startup. Closure-table consistency is checked/rebuilt on startup.

**Central permission service.** `services/api/internal/perm` is consulted by every resolver via `Can(ctx, principal, action, target)` — there is no per-domain authz logic to copy from. Tag-based cascading grants use a closure table. **Visibility is enforced as SQL predicates in the data layer, never as post-fetch filtering.** When adding queries, follow the existing pattern of composing the visibility predicate into the SQL, not wrapping results in a filter.

**Mobile is offline-first.** Reads come from the ferry normalized cache; writes (posts, comments, chat) go through a `drift` SQLite outbox and flush on reconnect with last-write-wins reconciliation. Treat SQLite as outbox + cache only — it is not a server mirror.

**Federation-shaped, single-tenant today.** IDs and URIs (`local://principals/<id>`) are already federation-shaped for a future v2. Don't strip the URI shape "because it's not needed yet"; it is load-bearing for v2 prep.

## Conventions worth knowing

- **"v1" in `docs/technical-architecture-v1.md` is the architecture spec version, not the release version.** Release semver is independent (currently v0.1.x). Don't conflate them.
- **Docker release pattern.** Branch CI builds `ghcr.io/bcnelson/pulse:sha-<hash>`. A `git tag v*` push retags that *existing* image with semver — it never rebuilds. The bytes shipped to main are the bytes in the release.
- **Generated code is committed.** `services/api/internal/graphql/generated.go` (gqlgen) and `apps/mobile/lib/**/__generated__/` (ferry/`build_runner`). Regenerate and commit when changing `.graphql` files. Exception: `packages/pulse_devtools/extension/devtools/build/` is intentionally gitignored — run `mobile-devtools-build` locally.
- **Git hooks** (gofmt, govet, golangci-lint, nixfmt) are installed by devenv. Don't bypass with `--no-verify`; fix the issue.
- **Two-client testing.** `mobile` (devA) and `mobile-b` (devB, Linux desktop only) get independent prefs/keychain/sqlite via `PULSE_INSTANCE_ID`. Use them when you need to see real-time or chat round-trips.
- **Testing uses real dependencies, not mocks.** API tests boot a testcontainer Postgres + RustFS via `internal/pgtest`. Client tests use in-memory `drift` (`NativeDatabase.memory()`) and `ProviderScope` overrides. Do not introduce `mockito`/`gomock`/etc. New packages and new feature screens need at least one test.

## Tooling

- For nixpkgs/option lookups, use the **`nix` MCP server** rather than `nix search` — it's faster and current.
- For Flutter/Dart work, prefer the **`dart-mcp-server` MCP tools** (hot reload, analyze, format, widget tree) over raw shell `flutter`/`dart` invocations.
