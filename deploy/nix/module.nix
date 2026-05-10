# NixOS module for Pulse. Drop into /etc/nixos/modules/ and enable via:
#
#   { imports = [ ./pulse.nix ]; services.pulse.enable = true; }
#
# Or as a flake module passed alongside the rest of the system. Builds
# pulse-api from this repo's services/api directory; for production use
# an out-of-tree pin via `services.pulse.package = inputs.pulse.packages.${pkgs.system}.pulse-api;`.

{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.pulse;
  envFile = pkgs.writeText "pulse.env" ''
    DATABASE_URL=${cfg.databaseUrl}
    API_ADDR=${cfg.apiAddr}
    PULSE_MODE=${cfg.mode}
    GOOSE_MIGRATION_DIR=${cfg.migrationsDir}
    S3_ENDPOINT=${cfg.s3.endpoint}
    S3_REGION=${cfg.s3.region}
    S3_BUCKET=${cfg.s3.bucket}
    S3_ACCESS_KEY=${cfg.s3.accessKey}
    S3_SECRET_KEY=${cfg.s3.secretKey}
    S3_PATH_STYLE=${if cfg.s3.pathStyle then "true" else "false"}
  '';
in
{
  options.services.pulse = {
    enable = lib.mkEnableOption "Pulse workplace communication platform";

    package = lib.mkOption {
      type = lib.types.package;
      description = "Pulse server package providing pulse-api and pulse-bootstrap.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "pulse";
      description = "System user to run Pulse as.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "pulse";
      description = "System group.";
    };

    apiAddr = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1:8080";
      description = "API bind address.";
    };

    mode = lib.mkOption {
      type = lib.types.enum [
        "api"
        "worker"
        "both"
      ];
      default = "both";
      description = "Process mode.";
    };

    databaseUrl = lib.mkOption {
      type = lib.types.str;
      description = "Postgres DSN. Use a password-manager-rendered fragment.";
    };

    migrationsDir = lib.mkOption {
      type = lib.types.str;
      default = "${cfg.package}/share/pulse/migrations";
      description = "Path containing goose migration files.";
    };

    s3 = {
      endpoint = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      region = lib.mkOption {
        type = lib.types.str;
        default = "us-east-1";
      };
      bucket = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      accessKey = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      secretKey = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Prefer secrets manager via systemd LoadCredential.";
      };
      pathStyle = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = "/var/lib/pulse";
      createHome = true;
    };
    users.groups.${cfg.group} = { };

    systemd.services.pulse = {
      description = "Pulse API + worker";
      wantedBy = [ "multi-user.target" ];
      after = [
        "network-online.target"
        "postgresql.service"
      ];
      requires = [ "postgresql.service" ];
      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}/bin/pulse-api -mode ${cfg.mode}";
        EnvironmentFile = envFile;
        Restart = "on-failure";
        RestartSec = 5;
        LimitNOFILE = 65536;
        StateDirectory = "pulse";
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ReadWritePaths = [ "/var/lib/pulse" ];
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_INET"
          "AF_INET6"
        ];
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        RestrictRealtime = true;
        SystemCallArchitectures = "native";
      };
    };
  };
}
