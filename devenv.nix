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
    nixfmt
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
    GRAPHQL_ENDPOINT = "http://127.0.0.1:8080/graphql";
    GOCACHE = "${config.env.DEVENV_STATE}/go-cache";
    GOMODCACHE = "${config.env.DEVENV_STATE}/go-mod-cache";
    GOOSE_DBSTRING = "postgres://pulse:pulse@127.0.0.1:5432/pulse?sslmode=disable";
    GOOSE_DRIVER = "postgres";
    GOOSE_MIGRATION_DIR = "${config.devenv.root}/db/migrations";
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

  scripts.api.exec = ''
    go run ./services/api/cmd/api
  '';

  scripts.mobile.exec = ''
    cd "$DEVENV_ROOT/apps/mobile"
    flutter run --dart-define=GRAPHQL_ENDPOINT="$GRAPHQL_ENDPOINT" "$@"
  '';

  scripts.dbshell.exec = ''
    psql "$DATABASE_URL"
  '';

  scripts.migrate.exec = ''
    goose "$@"
  '';

  scripts.test.exec = ''
    go test ./services/api/...
  '';

  processes.api = {
    exec = "api";
    process-compose.depends_on.postgres.condition = "process_healthy";
  };

  enterShell = ''
    echo "Pulse dev shell"
    echo "Go $(go version | cut -d' ' -f3)"
    echo "  devenv up      # postgres + migrations + API"
    echo "  devenv test    # go tests"
    echo "  mobile         # flutter app"
    echo "  dbshell        # psql"
    echo "  migrate ...    # goose passthrough (up, down, create NAME sql)"
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
