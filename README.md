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

`devenv up` starts PostgreSQL, applies any pending Goose migrations, and then starts the Go API. The API listens on `http://127.0.0.1:8080/graphql`.

Run the Flutter app from another shell:

```sh
devenv shell
cd apps/mobile
flutter create .            # one-time, creates platform folders (gitignored)
dart run build_runner build # ferry codegen for GraphQL operations
mobile
```

Other commands available in the dev shell:

```sh
devenv test         # run go tests
dbshell             # psql against the local pulse database
migrate up          # apply pending migrations (also: down, status, create NAME sql)
```

The Go API embeds Goose and applies pending migrations on startup, so `migrate up` is only needed when iterating on migrations outside of an API restart.

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
