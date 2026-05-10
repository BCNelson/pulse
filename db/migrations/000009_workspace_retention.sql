-- +goose Up
-- +goose StatementBegin

-- workspace_config existed since M1; ensure the retention column does
-- too. Default is 365 days — operators tune via UPDATE workspace_config.
ALTER TABLE workspace_config
  ADD COLUMN IF NOT EXISTS retention_window_days INT NOT NULL DEFAULT 365;

-- Make sure the singleton row is present (M1 migration created the
-- table; some deployments may not have seeded the row yet).
INSERT INTO workspace_config (id) VALUES (1)
  ON CONFLICT (id) DO NOTHING;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE workspace_config DROP COLUMN IF EXISTS retention_window_days;
-- +goose StatementEnd
