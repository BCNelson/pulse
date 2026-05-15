-- +goose Up
-- +goose StatementBegin

-- pgcrypto provides gen_random_bytes(), used by the typed-ID generator
-- below. Enabled here so every migration that uses gen_id() can rely on it.
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Health-check table. Plain bigserial — not a user-facing entity, so no
-- typed-ID needed.
CREATE TABLE IF NOT EXISTS app_health_checks (
  id BIGSERIAL PRIMARY KEY,
  checked_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ---------- Typed Crockford ID generators ----------
--
-- Every user-facing entity stores its primary key as a structured bigint:
--
--   bit 63       sign (always 0)
--   bits 62..60  padding (always 0)
--   bits 59..55  kind index (5 bits — matches a Crockford-base32 char)
--   bits 54..0   random body (55 bits)
--
-- The wire form (URLs, GraphQL IDs, federation URIs) is the bottom 60 bits
-- Crockford-encoded MSB-first as 12 chars: the first char is the kind
-- letter, the remaining 11 chars encode the body. The kind table is
-- maintained in lockstep with services/api/pkg/ids/kinds.go.

CREATE OR REPLACE FUNCTION gen_id(kind smallint) RETURNS bigint
LANGUAGE plpgsql AS $$
DECLARE
  bytes bytea;
  body bigint;
BEGIN
  IF kind < 0 OR kind > 31 THEN
    RAISE EXCEPTION 'gen_id: kind must be in 0..31, got %', kind;
  END IF;
  LOOP
    bytes := gen_random_bytes(7);  -- 56 bits; mask top bit for 55
    body := ((get_byte(bytes,0)::bigint & 127) << 48)
          | (get_byte(bytes,1)::bigint << 40)
          | (get_byte(bytes,2)::bigint << 32)
          | (get_byte(bytes,3)::bigint << 24)
          | (get_byte(bytes,4)::bigint << 16)
          | (get_byte(bytes,5)::bigint <<  8)
          |  get_byte(bytes,6)::bigint;
    IF body <> 0 THEN
      RETURN (kind::bigint << 55) | body;
    END IF;
  END LOOP;
END $$;

-- Per-kind convenience wrappers so column DEFAULTs read cleanly.
-- The Crockford index for each kind is the value of its letter
-- in the Crockford alphabet (0..31 -> 0123456789ABCDEFGHJKMNPQRSTVWXYZ).
CREATE OR REPLACE FUNCTION gen_id_attachment()    RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(10::smallint) $$;  -- 'A'
CREATE OR REPLACE FUNCTION gen_id_comment()       RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(12::smallint) $$;  -- 'C'
CREATE OR REPLACE FUNCTION gen_id_device()        RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(13::smallint) $$;  -- 'D'
CREATE OR REPLACE FUNCTION gen_id_message()       RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(16::smallint) $$;  -- 'G'
CREATE OR REPLACE FUNCTION gen_id_job()           RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(18::smallint) $$;  -- 'J'
CREATE OR REPLACE FUNCTION gen_id_task()          RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(19::smallint) $$;  -- 'K'
CREATE OR REPLACE FUNCTION gen_id_impersonation() RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(20::smallint) $$;  -- 'M'
CREATE OR REPLACE FUNCTION gen_id_notification()  RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(21::smallint) $$;  -- 'N'
CREATE OR REPLACE FUNCTION gen_id_post()          RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(22::smallint) $$;  -- 'P'
CREATE OR REPLACE FUNCTION gen_id_room()          RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(24::smallint) $$;  -- 'R'
CREATE OR REPLACE FUNCTION gen_id_session()       RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(25::smallint) $$;  -- 'S'
CREATE OR REPLACE FUNCTION gen_id_tag()           RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(26::smallint) $$;  -- 'T'
CREATE OR REPLACE FUNCTION gen_id_user()          RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(27::smallint) $$;  -- 'V'
CREATE OR REPLACE FUNCTION gen_id_workspace()     RETURNS bigint LANGUAGE sql AS $$ SELECT gen_id(28::smallint) $$;  -- 'W'

-- ---------- Wire-form conversion helpers ----------
--
-- id_to_str(n) returns the 12-char Crockford wire form for a packed bigint.
-- Pure SQL, IMMUTABLE STRICT — Postgres inlines it into queries so a
-- "SELECT id_to_str(id), title FROM posts" pays only the per-row alphabet
-- lookup cost.
CREATE OR REPLACE FUNCTION id_to_str(n bigint) RETURNS text
LANGUAGE sql IMMUTABLE STRICT AS $$
  -- Mask before cast: a 60-bit bigint overflows int4 if cast first.
  SELECT
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 55) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 50) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 45) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 40) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 35) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 30) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 25) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 20) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 15) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >> 10) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', (((n >>  5) & 31)::int) + 1, 1) ||
    substr('0123456789ABCDEFGHJKMNPQRSTVWXYZ', ((n & 31)::int) + 1, 1)
$$;

-- str_to_id(s) parses a 12-char wire form into its packed bigint. Accepts
-- upper/lowercase plus the standard Crockford substitutions (I/L → 1,
-- O → 0). Raises on malformed input.
CREATE OR REPLACE FUNCTION str_to_id(s text) RETURNS bigint
LANGUAGE plpgsql IMMUTABLE STRICT AS $$
DECLARE
  alphabet text := '0123456789ABCDEFGHJKMNPQRSTVWXYZ';
  n bigint := 0;
  ch char;
  v int;
  i int;
BEGIN
  IF length(s) <> 12 THEN
    RAISE EXCEPTION 'str_to_id: expected 12 chars, got %', length(s);
  END IF;
  FOR i IN 1..12 LOOP
    ch := upper(substr(s, i, 1));
    IF ch = 'I' OR ch = 'L' THEN
      ch := '1';
    ELSIF ch = 'O' THEN
      ch := '0';
    END IF;
    v := position(ch in alphabet) - 1;
    IF v < 0 THEN
      RAISE EXCEPTION 'str_to_id: invalid char % in %', ch, s;
    END IF;
    n := (n << 5) | v;
  END LOOP;
  RETURN n;
END $$;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP FUNCTION IF EXISTS str_to_id(text);
DROP FUNCTION IF EXISTS id_to_str(bigint);
DROP FUNCTION IF EXISTS gen_id_workspace();
DROP FUNCTION IF EXISTS gen_id_user();
DROP FUNCTION IF EXISTS gen_id_tag();
DROP FUNCTION IF EXISTS gen_id_session();
DROP FUNCTION IF EXISTS gen_id_room();
DROP FUNCTION IF EXISTS gen_id_post();
DROP FUNCTION IF EXISTS gen_id_notification();
DROP FUNCTION IF EXISTS gen_id_impersonation();
DROP FUNCTION IF EXISTS gen_id_task();
DROP FUNCTION IF EXISTS gen_id_job();
DROP FUNCTION IF EXISTS gen_id_message();
DROP FUNCTION IF EXISTS gen_id_device();
DROP FUNCTION IF EXISTS gen_id_comment();
DROP FUNCTION IF EXISTS gen_id_attachment();
DROP FUNCTION IF EXISTS gen_id(smallint);
DROP TABLE IF EXISTS app_health_checks;
-- pgcrypto intentionally left enabled; downgrade does not unprovision shared extensions.
-- +goose StatementEnd
