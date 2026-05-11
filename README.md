# Pulse

Pulse is set up as a Flutter client, Go GraphQL API, and local PostgreSQL database managed by `devenv`.

## Requirements

- Nix with flakes enabled
- `devenv`
- `direnv`, optional but recommended

## Development

```sh
devenv shell
devenv up
```

`devenv up` starts PostgreSQL, RustFS (a local S3-compatible server, run via Docker), and the Go API. The API watches its source tree via `air` and restarts on save. It listens on `http://127.0.0.1:8080/graphql`.

After the first `devenv up`, populate the workspace from another shell:

```sh
devenv shell
seed                # bootstraps admin@pulse.dev / pulse-dev plus demo users, tags, posts, comments
```

Run the Flutter app from another shell:

```sh
devenv shell
mobile-init         # one-time: flutter create + ferry codegen
mobile
```

Other commands available in the dev shell:

```sh
devenv test         # run go tests (requires a Docker daemon)
seed -fresh         # wipe the demo data (admin + org root preserved) and re-seed
reset-db            # drop the public schema, re-migrate, re-seed
mobile-codegen      # rerun build_runner once
mobile-watch        # run build_runner in watch mode
dbshell             # psql against the local pulse database
migrate up          # apply pending migrations (also: down, status, create NAME sql)
```

The Go API embeds Goose and applies pending migrations on startup, so `migrate up` is only needed when iterating on migrations outside of an API restart. The seed CLI also runs migrations before inserting, so `reset-db` returns a clean schema at current head.

RustFS comes up alongside Postgres under `devenv up`; the seed CLI creates the `pulse-attachments` bucket on its first run.

GraphQL schema and operations are codegen'd:

- API (Go): `cd services/api && go run github.com/99designs/gqlgen generate`
- Mobile (Dart): `cd apps/mobile && dart run build_runner build`

Generated files (`internal/graphql/generated.go`, `lib/**/__generated__/`) are committed.

## Environment overrides

`direnv` will automatically load `.env.dev` if it exists (see `.env.dev.example`). Use it for local-only overrides; defaults are baked into `devenv.nix` so the env works out of the box without it.

## Layout

- `apps/mobile`: Flutter app shell
- `services/api`: Go GraphQL API
- `db/migrations`: SQL migrations and schema history
