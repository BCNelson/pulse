# Pulse deployment

Three supported targets, all built from the same Go binary:

## OCI image + docker-compose (fastest demo)

```bash
# Latest main:
docker compose -f deploy/docker/docker-compose.yml up -d
# Or pin a release version:
PULSE_IMAGE_TAG=0.1.0 docker compose -f deploy/docker/docker-compose.yml up -d

docker compose -f deploy/docker/docker-compose.yml run --rm bootstrap \
  -e PULSE_BOOTSTRAP_EMAIL=admin@example.com \
  -e PULSE_BOOTSTRAP_PASSWORD=changeme
open http://localhost:8080/playground
```

The compose file boots Postgres 16, MinIO (S3-compatible), the API in
`--mode=both`, and a one-shot `bootstrap` profile container. Override
the bootstrap creds with environment variables.

Images are published to `ghcr.io/bcnelson/pulse`:

- `main` — latest commit on main branch (CI build)
- `sha-<short>` — every commit; immutable
- `0.1.0`, `0.1`, etc. — semver tags pushed when a `v0.1.0` git tag
  lands. These are retags of the corresponding `sha-*` image, so they
  are byte-identical to what main shipped.

## Plain binary + systemd (single-host self-host)

```bash
# Build a static binary on a build host:
cd services/api && CGO_ENABLED=0 go build -o pulse-api ./cmd/api
cd services/api && CGO_ENABLED=0 go build -o pulse-bootstrap ./cmd/bootstrap

# On the target host (as root):
useradd --system --home /var/lib/pulse --shell /usr/sbin/nologin pulse
install -d -o pulse -g pulse /var/lib/pulse /usr/share/pulse/migrations
install -m 0755 pulse-api /usr/local/bin/
install -m 0755 pulse-bootstrap /usr/local/bin/
cp -r db/migrations/* /usr/share/pulse/migrations/
install -m 0644 deploy/systemd/pulse-api.service /etc/systemd/system/
install -d -o root -g pulse -m 0750 /etc/pulse
install -m 0640 -o root -g pulse deploy/systemd/pulse.env.example /etc/pulse/pulse.env
# Edit /etc/pulse/pulse.env: DATABASE_URL, S3_*, etc.
systemctl daemon-reload
systemctl enable --now pulse-api
sudo -u pulse /usr/local/bin/pulse-bootstrap -email you@example.com -name You -password 'Sup3r-secret'
```

## NixOS module

`deploy/nix/module.nix` exposes `services.pulse.*`. Pin a package built
from this flake (or vendor `nix/pulse-api.nix`) and:

```nix
{ ... }: {
  imports = [ ./modules/pulse.nix ];
  services.pulse = {
    enable = true;
    package = inputs.pulse.packages.${pkgs.system}.pulse-api;
    databaseUrl = "postgres://pulse:CHANGE_ME@127.0.0.1/pulse?sslmode=disable";
    s3.bucket = "pulse-attachments";
    s3.accessKey = "...";
    s3.secretKey = "...";
  };
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "pulse" ];
    ensureUsers = [{ name = "pulse"; ensureDBOwnership = true; }];
  };
}
```

For production secret handling use `systemd.services.pulse.serviceConfig.LoadCredential`
and reference the credential paths from your env file via systemd
substitution (`${CREDENTIALS_DIRECTORY}/secret.txt`).

## Backups

Pulse keeps everything in Postgres + a bucket. Both have well-known
backup paths:

- **Postgres**: `pg_basebackup` for a base + WAL archiving for PITR.
  See `docs/operations.md` for the example script.
- **Attachments**: bucket-native versioning + lifecycle rules. The
  attachment table has a `state` column that distinguishes pending /
  ready / tombstoned; the retention sweep deletes rows past
  `workspace_config.retention_window`, and the lifecycle rule on the
  bucket deletes the bytes shortly after.

## Operations docs

- [`docs/operations.md`](../docs/operations.md) — backups, retention,
  online migrations, redaction, observability.
- [`docs/technical-architecture-v1.md`](../docs/technical-architecture-v1.md)
  — the original v1 design.
