{ pkgs, config, ... }:

{
  devenv.root =
    let
      devenvRoot = builtins.getEnv "DEVENV_ROOT";
    in
    if devenvRoot != "" then devenvRoot else builtins.toString ./.;

  packages = with pkgs; [
    air
    curl
    git
    golangci-lint
    goose
    jq
    libsecret
    nixfmt
    sqlite
  ];

  languages.go = {
    enable = true;
    package = pkgs.go_1_26;
    lsp.enable = true;
  };

  android = {
    enable = true;
    flutter.enable = true;
  };

  env = {
    APP_ENV = "development";
    API_ADDR = "127.0.0.1:8080";
    DATABASE_URL = "postgres://pulse:pulse@127.0.0.1:5432/pulse?sslmode=disable";
    GOCACHE = "${config.env.DEVENV_STATE}/go-cache";
    GOMODCACHE = "${config.env.DEVENV_STATE}/go-mod-cache";
    GOOSE_DBSTRING = "postgres://pulse:pulse@127.0.0.1:5432/pulse?sslmode=disable";
    GOOSE_DRIVER = "postgres";
    GOOSE_MIGRATION_DIR = "${config.devenv.root}/db/migrations";

    # Local S3-compatible storage (RustFS, runs as a docker process — see
    # processes.rustfs below). Matches the test harness in
    # services/api/internal/pgtest/s3.go so attachments behave the same in
    # dev as in tests.
    S3_ENDPOINT = "http://127.0.0.1:9000";
    S3_REGION = "us-east-1";
    S3_BUCKET = "pulse-attachments";
    S3_ACCESS_KEY = "pulse-dev";
    S3_SECRET_KEY = "pulse-dev-secret";
    S3_PATH_STYLE = "true";

    # Flutter Linux desktop dlopens libsqlite3.so at runtime (drift/sqlite3
    # plugin). Nix doesn't put package libs on the loader path automatically.
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.sqlite ];

    # Flutter hardcodes `google-chrome` for auto-opening DevTools and the
    # web target. Point it at a shim that hands the URL to xdg-open, which
    # respects the user's default browser.
    CHROME_EXECUTABLE = toString (
      pkgs.writeShellScript "flutter-open-url" ''
        exec ${pkgs.xdg-utils}/bin/xdg-open "$@"
      ''
    );
  };

  services.postgres = {
    enable = true;
    package = pkgs.postgresql_16;
    listen_addresses = "127.0.0.1";
    port = 5432;
    initialDatabases = [
      {
        name = "pulse";
        user = "pulse";
        pass = "pulse";
      }
    ];
  };

  # Escalating shutdown: SIGINT (fast shutdown, clean checkpoint) → SIGQUIT
  # (immediate, no checkpoint, WAL recovery on next start) → SIGKILL. Default
  # process-compose sends one signal then SIGKILLs on timeout, which has hung
  # in the past when an orphan client held a connection open.
  processes.postgres.process-compose.shutdown = {
    command = toString (
      pkgs.writeShellScript "pulse-pg-shutdown" ''
        pid=$(head -n1 "$PGDATA/postmaster.pid" 2>/dev/null) || exit 0
        kill -INT "$pid" 2>/dev/null || exit 0
        for _ in $(seq 1 15); do
          kill -0 "$pid" 2>/dev/null || exit 0
          sleep 1
        done
        kill -QUIT "$pid" 2>/dev/null || exit 0
        for _ in $(seq 1 5); do
          kill -0 "$pid" 2>/dev/null || exit 0
          sleep 1
        done
        kill -KILL "$pid" 2>/dev/null || true
      ''
    );
    timeout_seconds = 30;
  };

  scripts.api.exec = ''
    go run ./services/api/cmd/api
  '';

  scripts.seed.exec = ''
    go run ./services/api/cmd/seed "$@"
  '';

  scripts.reset-db.exec = ''
    set -euo pipefail
    echo "Dropping and recreating public schema in $DATABASE_URL"
    psql "$DATABASE_URL" -v ON_ERROR_STOP=1 \
      -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'
    go run ./services/api/cmd/seed
  '';

  scripts.mobile.exec = ''
    cd "$DEVENV_ROOT/apps/mobile"
    # Default client uses PULSE_INSTANCE_ID=devA so its prefs/keychain/sqlite
    # don't collide with a second client launched via `mobile-b`. Override per
    # invocation: PULSE_SERVER_URL=https://staging.example.com mobile
    flutter run \
      --dart-define=PULSE_INSTANCE_ID=devA \
      --dart-define=PULSE_SERVER_URL="''${PULSE_SERVER_URL:-http://127.0.0.1:8080}" \
      "$@"
  '';

  scripts.mobile-b.exec = ''
    cd "$DEVENV_ROOT/apps/mobile"
    # Second concurrent client. Pinned to -d linux because side-by-side
    # desktop is the explicit use case; a separate PULSE_INSTANCE_ID gives it
    # its own SharedPreferences keys, libsecret entries, and outbox sqlite.
    flutter run -d linux \
      --dart-define=PULSE_INSTANCE_ID=devB \
      --dart-define=PULSE_SERVER_URL="''${PULSE_SERVER_URL:-http://127.0.0.1:8080}" \
      "$@"
  '';

  scripts.mobile-init.exec = ''
    set -euo pipefail
    cd "$DEVENV_ROOT/apps/mobile"
    flutter create .
    flutter pub get
    dart run build_runner build --delete-conflicting-outputs
  '';

  scripts.mobile-codegen.exec = ''
    cd "$DEVENV_ROOT/apps/mobile"
    dart run build_runner build --delete-conflicting-outputs
  '';

  scripts.mobile-watch.exec = ''
    cd "$DEVENV_ROOT/apps/mobile"
    dart run build_runner watch --delete-conflicting-outputs
  '';

  scripts.dbshell.exec = ''
    psql "$DATABASE_URL"
  '';

  scripts.migrate.exec = ''
    goose "$@"
  '';

  scripts.test.exec = ''
    # Tests start their own Postgres + RustFS testcontainers; a Docker
    # daemon must be reachable (DOCKER_HOST or the local socket).
    go test ./services/api/...
  '';

  processes.api = {
    # air watches services/api/{*.go,*.graphql,*.sql}, rebuilds, and
    # restarts the binary on every save. Config in services/api/.air.toml.
    exec = ''cd "$DEVENV_ROOT/services/api" && air'';
    process-compose.depends_on = {
      postgres.condition = "process_healthy";
      rustfs.condition = "process_started";
    };
  };

  # RustFS is the same S3-compatible server the integration tests use
  # (services/api/internal/pgtest/s3.go). Not packaged in nixpkgs, so we
  # run it via docker — `devenv test` already requires a docker daemon, so
  # this adds no new prerequisite. The seed CLI creates the bucket on
  # first run; running `seed` once after `devenv up` is the recommended
  # first step.
  processes.rustfs.exec = ''
    docker rm -f pulse-rustfs >/dev/null 2>&1 || true
    exec docker run --rm --name pulse-rustfs \
      -p 9000:9000 \
      -e RUSTFS_ACCESS_KEY=pulse-dev \
      -e RUSTFS_SECRET_KEY=pulse-dev-secret \
      rustfs/rustfs:latest
  '';

  enterShell = ''
    echo "Pulse dev shell"
    echo "Go $(go version | cut -d' ' -f3)"
    echo "  devenv up         # postgres + rustfs + API (with hot reload)"
    echo "  seed              # populate demo workspace (admin, users, tags, posts)"
    echo "  reset-db          # drop schema, re-migrate, re-seed"
    echo "  devenv test       # go tests (requires a Docker daemon)"
    echo "  mobile-init       # one-time flutter create + codegen"
    echo "  mobile-codegen    # rerun ferry / build_runner codegen"
    echo "  mobile            # flutter run"
    echo "  dbshell           # psql"
    echo "  migrate ...       # goose passthrough (up, down, create NAME sql)"
  '';

  enterTest = ''
    go test ./services/api/...
  '';

  git-hooks.hooks = {
    gofmt.enable = true;
    govet.enable = true;
    golangci-lint.enable = true;
    nixfmt.enable = true;
  };
}
