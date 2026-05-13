// Seed CLI: produces a populated demo workspace for local development.
// Idempotent — re-running is a no-op once the demo set is in place. Pass
// -fresh to delete the demo data first (admin and the org root tag are
// preserved). Run after `devenv up` has booted Postgres; the CLI applies
// migrations itself, so it works against an empty database too.
//
// Bootstrap admin: admin@pulse.dev / pulse-dev (override via PULSE_BOOTSTRAP_*).
// Demo users: alice@pulse.dev, bob@pulse.dev, charlie@pulse.dev (password "pulse-dev").
// Demo tags: engineering, product (under the org root).
// Demo posts + comments: a small thread under each sub-tag.
//
// When S3_ENDPOINT and S3_BUCKET are set the bucket is created if missing
// and a single demo attachment is uploaded + recorded.
package main

import (
	"bytes"
	"context"
	"errors"
	"flag"
	"fmt"
	"os"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	awsconfig "github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	s3types "github.com/aws/aws-sdk-go-v2/service/s3/types"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/bootstrap"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	pulsedb "github.com/bcnelson/pulse/services/api/internal/db"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/tag"
)

const (
	demoPassword       = "pulse-dev"
	demoEmailDomain    = "@pulse.dev"
	defaultAdminEmail  = "admin@pulse.dev"
	defaultAdminName   = "Admin"
	defaultOrgSlug     = "org"
	defaultOrgName     = "Org"
	demoAttachmentKey  = "demo/welcome.txt"
	demoAttachmentMime = "text/plain"
)

var demoAttachmentBody = []byte("Welcome to Pulse!\n")

type demoUser struct {
	Email       string
	DisplayName string
}

var demoUsers = []demoUser{
	{Email: "alice@pulse.dev", DisplayName: "Alice"},
	{Email: "bob@pulse.dev", DisplayName: "Bob"},
	{Email: "charlie@pulse.dev", DisplayName: "Charlie"},
}

type demoTag struct {
	Slug        string
	DisplayName string
	// Members is the demo users granted contributor on this tag.
	Members []string
}

var demoTags = []demoTag{
	{Slug: "engineering", DisplayName: "Engineering", Members: []string{"alice@pulse.dev", "bob@pulse.dev"}},
	{Slug: "product", DisplayName: "Product", Members: []string{"bob@pulse.dev", "charlie@pulse.dev"}},
}

type demoPost struct {
	TagSlug  string
	Author   string // email; falls back to admin if empty
	Title    string
	Body     string
	Comments []demoComment
}

type demoComment struct {
	Author string // email
	Body   string
	// Key is an optional local id so child comments can reference this one
	// via ParentKey. Empty means this comment cannot be referenced.
	Key string
	// ParentKey is the Key of another comment in the same post. Empty means
	// this is a top-level (root) comment. Parents must appear earlier in
	// the slice than their children.
	ParentKey string
}

var demoPosts = []demoPost{
	{
		TagSlug: "engineering",
		Author:  "alice@pulse.dev",
		Title:   "Welcome to Pulse Engineering",
		Body:    "This is a seeded post. Use it to poke at posts, comments, reactions.",
		Comments: []demoComment{
			{Author: "bob@pulse.dev", Body: "Hello from Bob!"},
			{Author: defaultAdminEmail, Body: "Looks good — let's iterate."},
		},
	},
	{
		TagSlug: "product",
		Author:  "charlie@pulse.dev",
		Title:   "Roadmap discussion",
		Body:    "Drafting Q3 themes here. Replies welcome.",
		Comments: []demoComment{
			{Author: "bob@pulse.dev", Body: "Could we link the spec doc?"},
		},
	},
	// A deeply-threaded post for exercising the spine-rendered comment view
	// in the mobile client. Layout:
	//   - Root A: 12-deep primary thread (spine) with off-spine branches
	//     at depths 0, 2, 5, 7, 9 — including one 7-deep off-spine subtree
	//     that exercises the relativeDepth clamp when expanded.
	//   - Root B: shorter spine + one off-spine branch.
	//   - Root C: standalone single-comment thread (no hairline).
	//   - Root D: medium spine with sibling stubs.
	{
		TagSlug: "engineering",
		Author:  "alice@pulse.dev",
		Title:   "Threaded: v1 rollout discussion",
		Body:    "Use this post to poke at the spine-threaded comment view. Plenty of nesting below.",
		Comments: []demoComment{
			// Root A: 12-deep primary thread.
			{Key: "A", Author: "alice@pulse.dev", Body: "What's the best way to ship the v1 rollout?"},
			{Key: "A1", ParentKey: "A", Author: "bob@pulse.dev", Body: "I'd start by gating it behind a workspace flag."},
			{Key: "A2", ParentKey: "A1", Author: "charlie@pulse.dev", Body: "Agree. What's the default state of the flag?"},
			{Key: "A3", ParentKey: "A2", Author: "alice@pulse.dev", Body: "Off. We'll flip it per workspace once metrics look healthy."},
			{Key: "A4", ParentKey: "A3", Author: "bob@pulse.dev", Body: "How are we monitoring those metrics?"},
			{Key: "A5", ParentKey: "A4", Author: "charlie@pulse.dev", Body: "I'll wire a Grafana board off the audit log next week."},
			{Key: "A6", ParentKey: "A5", Author: "alice@pulse.dev", Body: "Make sure error rate and p99 are on it."},
			{Key: "A7", ParentKey: "A6", Author: "bob@pulse.dev", Body: "Should we alert if either crosses a threshold?"},
			{Key: "A8", ParentKey: "A7", Author: "charlie@pulse.dev", Body: "Yes. Page on-call if p99 > 2s for 5 min."},
			{Key: "A9", ParentKey: "A8", Author: "alice@pulse.dev", Body: "Add a separate alert for sustained 5xx > 1%."},
			{Key: "A10", ParentKey: "A9", Author: "bob@pulse.dev", Body: "Will do. Both fire to the #oncall room."},
			{Key: "A11", ParentKey: "A10", Author: "charlie@pulse.dev", Body: "Great — let's ship it Monday."},

			// Off-spine at A (depth 0): nested two deep.
			{Key: "S1", ParentKey: "A", Author: defaultAdminEmail, Body: "Have we considered a percentage rollout instead?"},
			{Key: "S1a", ParentKey: "S1", Author: "bob@pulse.dev", Body: "Could, but workspaces are coarser and easier to reason about."},
			{Key: "S1b", ParentKey: "S1a", Author: defaultAdminEmail, Body: "Fair. Workspace flag it is."},

			// Off-spine at A (depth 0): a Y-shaped branch (two leaves under one root).
			{Key: "T1", ParentKey: "A", Author: "charlie@pulse.dev", Body: "Out of curiosity, what does v1 actually include?"},
			{Key: "T1a", ParentKey: "T1", Author: "alice@pulse.dev", Body: "Posts, comments, reactions, tags, basic search."},
			{Key: "T1b", ParentKey: "T1", Author: "bob@pulse.dev", Body: "Notifications too, but only in-app for v1."},

			// Off-spine at A2 (depth 2): a deep 7-level chain that exercises
			// the indent clamp on ExpandedBranchRow (clamp kicks in at depth 6+).
			{Key: "U1", ParentKey: "A2", Author: defaultAdminEmail, Body: "Side note — what about org-level overrides?"},
			{Key: "U2", ParentKey: "U1", Author: "alice@pulse.dev", Body: "Out of scope for v1. Filed a separate ticket."},
			{Key: "U3", ParentKey: "U2", Author: defaultAdminEmail, Body: "Ticket number?"},
			{Key: "U4", ParentKey: "U3", Author: "alice@pulse.dev", Body: "ENG-422."},
			{Key: "U5", ParentKey: "U4", Author: defaultAdminEmail, Body: "Linking from the rollout doc."},
			{Key: "U6", ParentKey: "U5", Author: "alice@pulse.dev", Body: "Thanks."},
			{Key: "U7", ParentKey: "U6", Author: "bob@pulse.dev", Body: "(Indent should be visibly clamped from here on down.)"},

			// Off-spine at A5 (depth 5): three sibling leaves — multiple
			// collapsed stubs at the same parent.
			{Key: "V1", ParentKey: "A5", Author: "bob@pulse.dev", Body: "Tangent: can we backfill Grafana data?"},
			{Key: "V2", ParentKey: "A5", Author: "alice@pulse.dev", Body: "Tangent: who owns the Grafana folder permissions?"},
			{Key: "V3", ParentKey: "A5", Author: defaultAdminEmail, Body: "Tangent: are we paying for Grafana Cloud or self-hosting?"},

			// Off-spine at A7 (depth 7): short branch.
			{Key: "W1", ParentKey: "A7", Author: defaultAdminEmail, Body: "Will the alert link back to a runbook?"},
			{Key: "W2", ParentKey: "W1", Author: "charlie@pulse.dev", Body: "Yes, the runbook lives in /docs/oncall/v1."},

			// Off-spine at A9 (depth 9): single leaf.
			{Key: "X1", ParentKey: "A9", Author: "alice@pulse.dev", Body: "Add a 4xx-rate panel too while you're in there."},

			// Root B: short spine + one branch.
			{Key: "B", Author: "bob@pulse.dev", Body: "Where are we tracking the migration tasks?"},
			{Key: "B1", ParentKey: "B", Author: "alice@pulse.dev", Body: "There's a Linear project — link is in the docs."},
			{Key: "B2", ParentKey: "B1", Author: "charlie@pulse.dev", Body: "Subscribed."},
			{Key: "BS1", ParentKey: "B", Author: defaultAdminEmail, Body: "Aside: should we mirror to GitHub issues for visibility?"},
			{Key: "BS2", ParentKey: "BS1", Author: "alice@pulse.dev", Body: "Not for v1 — too much noise."},

			// Root C: single comment with no replies (tests the no-hairline case).
			{Author: defaultAdminEmail, Body: "Reminder: feature freeze starts Thursday."},

			// Root D: medium spine.
			{Key: "D", Author: "charlie@pulse.dev", Body: "Quick poll — release on Friday or punt to Monday?"},
			{Key: "D1", ParentKey: "D", Author: "alice@pulse.dev", Body: "Monday. No one wants a weekend page."},
			{Key: "D2", ParentKey: "D1", Author: "bob@pulse.dev", Body: "+1 Monday."},
			{Key: "D3", ParentKey: "D2", Author: defaultAdminEmail, Body: "Monday it is."},
			// One sibling stub off D1.
			{Key: "DS1", ParentKey: "D1", Author: defaultAdminEmail, Body: "What's the actual window — morning or afternoon?"},
		},
	},
}

func main() {
	fresh := flag.Bool("fresh", false, "delete demo data (users/tags/posts/comments/attachments) before seeding; admin and org root are preserved")
	flag.Parse()

	cfg := configFromEnv()
	ctx := context.Background()

	if err := pulsedb.Migrate(ctx, cfg.databaseURL, cfg.migrationsDir); err != nil {
		fail("migrate: %v", err)
	}
	pool, err := pulsedb.NewPool(ctx, cfg.databaseURL)
	if err != nil {
		fail("pool: %v", err)
	}
	defer pool.Close()

	// Bootstrap admin first so the seed has an authoritative user to attribute
	// audit/posts to. Idempotent: skipped if any active user already exists.
	bootRes, err := bootstrap.Run(ctx, pool, bootstrap.Input{
		Email:       cfg.adminEmail,
		DisplayName: cfg.adminName,
		Password:    cfg.adminPassword,
		OrgSlug:     cfg.orgSlug,
		OrgName:     cfg.orgName,
	})
	if err != nil {
		fail("bootstrap: %v", err)
	}
	if bootRes.AlreadyDone {
		fmt.Println("seed: admin already present, skipping bootstrap")
	} else {
		fmt.Printf("seed: created admin %s and org tag %s\n", bootRes.PrincipalID, bootRes.OrgTagID)
	}

	adminID, orgTagID, err := lookupAdminAndOrg(ctx, pool, cfg.adminEmail)
	if err != nil {
		fail("lookup admin/org: %v", err)
	}

	if *fresh {
		if err := wipeDemo(ctx, pool, adminID); err != nil {
			fail("wipe demo: %v", err)
		}
		fmt.Println("seed: cleared previous demo data")
	}

	users, err := ensureDemoUsers(ctx, pool)
	if err != nil {
		fail("seed users: %v", err)
	}
	tags, err := ensureDemoTags(ctx, pool, orgTagID, users)
	if err != nil {
		fail("seed tags: %v", err)
	}
	postIDs, err := ensureDemoPosts(ctx, pool, adminID, users, tags)
	if err != nil {
		fail("seed posts: %v", err)
	}

	if cfg.s3Configured() {
		if err := ensureDemoAttachment(ctx, pool, cfg, adminID, postIDs); err != nil {
			fail("seed attachment: %v", err)
		}
	} else {
		fmt.Println("seed: S3 not configured, skipping attachment seed")
	}

	fmt.Println("seed: done")
}

// ---------- config ----------

type seedConfig struct {
	databaseURL   string
	migrationsDir string

	adminEmail    string
	adminName     string
	adminPassword string
	orgSlug       string
	orgName       string

	s3Endpoint  string
	s3Region    string
	s3Bucket    string
	s3AccessKey string
	s3SecretKey string
	s3PathStyle bool
}

func (c seedConfig) s3Configured() bool {
	return c.s3Endpoint != "" && c.s3Bucket != ""
}

func configFromEnv() seedConfig {
	return seedConfig{
		databaseURL:   envOr("DATABASE_URL", "postgres://pulse:pulse@127.0.0.1:5432/pulse?sslmode=disable"),
		migrationsDir: envOr("GOOSE_MIGRATION_DIR", "db/migrations"),

		adminEmail:    envOr("PULSE_BOOTSTRAP_EMAIL", defaultAdminEmail),
		adminName:     envOr("PULSE_BOOTSTRAP_NAME", defaultAdminName),
		adminPassword: envOr("PULSE_BOOTSTRAP_PASSWORD", demoPassword),
		orgSlug:       envOr("PULSE_BOOTSTRAP_ORG_SLUG", defaultOrgSlug),
		orgName:       envOr("PULSE_BOOTSTRAP_ORG_NAME", defaultOrgName),

		s3Endpoint:  envOr("S3_ENDPOINT", ""),
		s3Region:    envOr("S3_REGION", "us-east-1"),
		s3Bucket:    envOr("S3_BUCKET", ""),
		s3AccessKey: envOr("S3_ACCESS_KEY", ""),
		s3SecretKey: envOr("S3_SECRET_KEY", ""),
		s3PathStyle: envOr("S3_PATH_STYLE", "true") == "true",
	}
}

// ---------- domain seeding ----------

func lookupAdminAndOrg(ctx context.Context, pool *pgxpool.Pool, adminEmail string) (uuid.UUID, uuid.UUID, error) {
	var adminID uuid.UUID
	if err := pool.QueryRow(ctx,
		`SELECT id FROM principals WHERE kind = 'user' AND lower(email) = lower($1)`, adminEmail).
		Scan(&adminID); err != nil {
		return uuid.Nil, uuid.Nil, fmt.Errorf("find admin %q: %w", adminEmail, err)
	}
	var orgID uuid.UUID
	if err := pool.QueryRow(ctx,
		`SELECT id FROM tags WHERE parent_id IS NULL AND root_kind = 'org' ORDER BY created_at LIMIT 1`).
		Scan(&orgID); err != nil {
		return uuid.Nil, uuid.Nil, fmt.Errorf("find org root: %w", err)
	}
	return adminID, orgID, nil
}

// ensureDemoUsers creates the demo users that are missing and returns the
// full email->id map (covering both freshly-created and pre-existing rows).
func ensureDemoUsers(ctx context.Context, pool *pgxpool.Pool) (map[string]uuid.UUID, error) {
	hash, err := auth.HashPassword(demoPassword)
	if err != nil {
		return nil, fmt.Errorf("hash demo password: %w", err)
	}

	out := map[string]uuid.UUID{}
	for _, u := range demoUsers {
		var id uuid.UUID
		err := pool.QueryRow(ctx,
			`SELECT id FROM principals WHERE kind = 'user' AND lower(email) = lower($1)`, u.Email).
			Scan(&id)
		if err == nil {
			out[u.Email] = id
			continue
		}
		if !errors.Is(err, pgx.ErrNoRows) {
			return nil, fmt.Errorf("lookup %s: %w", u.Email, err)
		}
		id, err = createUser(ctx, pool, u, hash)
		if err != nil {
			return nil, fmt.Errorf("create %s: %w", u.Email, err)
		}
		out[u.Email] = id
		fmt.Printf("seed: created user %s\n", u.Email)
	}
	return out, nil
}

func createUser(ctx context.Context, pool *pgxpool.Pool, u demoUser, hash string) (uuid.UUID, error) {
	id := uuid.New()
	tx, err := pool.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return uuid.Nil, err
	}
	defer func() { _ = tx.Rollback(ctx) }()

	uri := "local://principals/" + id.String()
	if _, err := tx.Exec(ctx, `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, $3, $4)
    `, id, uri, u.DisplayName, strings.ToLower(u.Email)); err != nil {
		return uuid.Nil, fmt.Errorf("insert principal: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        INSERT INTO user_credentials (principal_id, password_hash) VALUES ($1, $2)
    `, id, hash); err != nil {
		return uuid.Nil, fmt.Errorf("insert credential: %w", err)
	}
	if err := tx.Commit(ctx); err != nil {
		return uuid.Nil, err
	}
	return id, nil
}

// ensureDemoTags creates the demo sub-tags (under org root) if missing and
// returns the slug->id map. Member grants are inserted idempotently.
func ensureDemoTags(ctx context.Context, pool *pgxpool.Pool, orgTagID uuid.UUID, users map[string]uuid.UUID) (map[string]uuid.UUID, error) {
	tagSvc := &tag.Service{DB: pool}
	out := map[string]uuid.UUID{}
	for _, t := range demoTags {
		var id uuid.UUID
		err := pool.QueryRow(ctx,
			`SELECT id FROM tags WHERE parent_id = $1 AND slug = $2`, orgTagID, t.Slug).
			Scan(&id)
		if errors.Is(err, pgx.ErrNoRows) {
			id, err = tagSvc.Create(ctx, tag.CreateInput{
				ParentID:    &orgTagID,
				Slug:        t.Slug,
				DisplayName: t.DisplayName,
				RootKind:    tag.RootKindOrg,
			})
			if err != nil {
				return nil, fmt.Errorf("create tag %s: %w", t.Slug, err)
			}
			fmt.Printf("seed: created tag %s\n", t.Slug)
		} else if err != nil {
			return nil, fmt.Errorf("lookup tag %s: %w", t.Slug, err)
		}
		out[t.Slug] = id

		for _, email := range t.Members {
			pid, ok := users[email]
			if !ok {
				continue
			}
			if _, err := pool.Exec(ctx, `
                INSERT INTO tag_grants (tag_id, principal_id, bundle, cascade)
                VALUES ($1, $2, 'contributor', TRUE)
                ON CONFLICT (tag_id, principal_id) DO NOTHING
            `, id, pid); err != nil {
				return nil, fmt.Errorf("grant %s on %s: %w", email, t.Slug, err)
			}
		}
	}
	return out, nil
}

// ensureDemoPosts creates the demo posts (and their comments) if missing,
// keyed by title within the post's tag. Returns the title->id map.
func ensureDemoPosts(ctx context.Context, pool *pgxpool.Pool, adminID uuid.UUID, users, tags map[string]uuid.UUID) (map[string]uuid.UUID, error) {
	postSvc := &post.Service{DB: pool}
	commentSvc := &comment.Service{DB: pool}
	out := map[string]uuid.UUID{}

	for _, p := range demoPosts {
		tagID, ok := tags[p.TagSlug]
		if !ok {
			return nil, fmt.Errorf("tag %s missing from seed map", p.TagSlug)
		}
		authorID := principalFor(p.Author, adminID, users)

		var id uuid.UUID
		err := pool.QueryRow(ctx, `
            SELECT p.id FROM posts p
            JOIN post_tags pt ON pt.post_id = p.id
            WHERE pt.tag_id = $1 AND p.title = $2 AND p.deleted_at IS NULL
            LIMIT 1
        `, tagID, p.Title).Scan(&id)
		if errors.Is(err, pgx.ErrNoRows) {
			id, err = postSvc.Create(ctx, post.CreateInput{
				AuthorID: authorID,
				Title:    p.Title,
				Body:     p.Body,
				Tags: []post.TagAttachment{{
					TagID:        tagID,
					ViewRole:     true,
					InteractRole: true,
					ModerateRole: true,
				}},
			})
			if err != nil {
				return nil, fmt.Errorf("create post %q: %w", p.Title, err)
			}
			fmt.Printf("seed: created post %q under %s\n", p.Title, p.TagSlug)
		} else if err != nil {
			return nil, fmt.Errorf("lookup post %q: %w", p.Title, err)
		}
		out[p.Title] = id

		idByKey := map[string]uuid.UUID{}
		for _, c := range p.Comments {
			var parentID *uuid.UUID
			if c.ParentKey != "" {
				pid, ok := idByKey[c.ParentKey]
				if !ok {
					return nil, fmt.Errorf("comment on %q references unknown ParentKey %q (parents must appear before children)", p.Title, c.ParentKey)
				}
				parentID = &pid
			}

			var existingID uuid.UUID
			err := pool.QueryRow(ctx,
				`SELECT id FROM comments WHERE post_id = $1 AND body = $2 LIMIT 1`, id, c.Body).
				Scan(&existingID)
			if err == nil {
				if c.Key != "" {
					idByKey[c.Key] = existingID
				}
				continue
			}
			if !errors.Is(err, pgx.ErrNoRows) {
				return nil, fmt.Errorf("lookup comment on %q: %w", p.Title, err)
			}

			authorID := principalFor(c.Author, adminID, users)
			newID, err := commentSvc.Create(ctx, comment.CreateInput{
				PostID:   id,
				ParentID: parentID,
				AuthorID: authorID,
				Body:     c.Body,
			})
			if err != nil {
				return nil, fmt.Errorf("create comment on %q: %w", p.Title, err)
			}
			if c.Key != "" {
				idByKey[c.Key] = newID
			}
		}
	}
	return out, nil
}

func principalFor(email string, adminID uuid.UUID, users map[string]uuid.UUID) uuid.UUID {
	if email == "" || strings.EqualFold(email, defaultAdminEmail) {
		return adminID
	}
	if id, ok := users[email]; ok {
		return id
	}
	return adminID
}

// ---------- attachments ----------

func ensureDemoAttachment(ctx context.Context, pool *pgxpool.Pool, cfg seedConfig, adminID uuid.UUID, postIDs map[string]uuid.UUID) error {
	if len(postIDs) == 0 {
		return nil
	}
	client, err := newS3Client(ctx, cfg)
	if err != nil {
		return fmt.Errorf("s3 client: %w", err)
	}
	if err := ensureBucket(ctx, client, cfg.s3Bucket); err != nil {
		return err
	}
	if _, err := client.PutObject(ctx, &s3.PutObjectInput{
		Bucket:      aws.String(cfg.s3Bucket),
		Key:         aws.String(demoAttachmentKey),
		Body:        bytes.NewReader(demoAttachmentBody),
		ContentType: aws.String(demoAttachmentMime),
	}); err != nil {
		return fmt.Errorf("put object: %w", err)
	}

	// Pick a stable post to attach to: the first demo post by title order.
	var firstID uuid.UUID
	var firstTitle string
	for _, p := range demoPosts {
		if id, ok := postIDs[p.Title]; ok {
			firstID = id
			firstTitle = p.Title
			break
		}
	}
	if firstID == uuid.Nil {
		return nil
	}

	cmd, err := pool.Exec(ctx, `
        INSERT INTO attachments
            (owner_type, owner_id, uploader_id, storage_key, filename, mime_type, size_bytes, state, ready_at)
        VALUES ('post', $1, $2, $3, $4, $5, $6, 'ready', now())
        ON CONFLICT (storage_key) DO NOTHING
    `, firstID, adminID, demoAttachmentKey, "welcome.txt", demoAttachmentMime, len(demoAttachmentBody))
	if err != nil {
		return fmt.Errorf("insert attachment: %w", err)
	}
	if cmd.RowsAffected() > 0 {
		fmt.Printf("seed: attached %s to post %q\n", demoAttachmentKey, firstTitle)
	}
	return nil
}

func newS3Client(ctx context.Context, cfg seedConfig) (*s3.Client, error) {
	loadOpts := []func(*awsconfig.LoadOptions) error{awsconfig.WithRegion(cfg.s3Region)}
	if cfg.s3AccessKey != "" && cfg.s3SecretKey != "" {
		loadOpts = append(loadOpts, awsconfig.WithCredentialsProvider(
			credentials.NewStaticCredentialsProvider(cfg.s3AccessKey, cfg.s3SecretKey, ""),
		))
	}
	awsCfg, err := awsconfig.LoadDefaultConfig(ctx, loadOpts...)
	if err != nil {
		return nil, err
	}
	return s3.NewFromConfig(awsCfg, func(o *s3.Options) {
		if cfg.s3Endpoint != "" {
			o.BaseEndpoint = &cfg.s3Endpoint
		}
		o.UsePathStyle = cfg.s3PathStyle
	}), nil
}

func ensureBucket(ctx context.Context, client *s3.Client, bucket string) error {
	_, err := client.CreateBucket(ctx, &s3.CreateBucketInput{Bucket: aws.String(bucket)})
	if err == nil {
		fmt.Printf("seed: created bucket %s\n", bucket)
		return nil
	}
	var owned *s3types.BucketAlreadyOwnedByYou
	var exists *s3types.BucketAlreadyExists
	if errors.As(err, &owned) || errors.As(err, &exists) {
		return nil
	}
	return fmt.Errorf("create bucket %s: %w", bucket, err)
}

// ---------- fresh wipe ----------

// wipeDemo deletes the demo data (users at demoEmailDomain except admin,
// their posts/comments/attachments, and the demoTags rows) so a subsequent
// seed pass can recreate them. Order matters: posts first (cascades into
// post_tags/post_mentions/post_reactions/post_edits/principal_post_read),
// then attachments (no cascade from principals), then tag_grants and
// tag_closure rows for the demo sub-tags, finally principals.
func wipeDemo(ctx context.Context, pool *pgxpool.Pool, adminID uuid.UUID) error {
	tx, err := pool.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return err
	}
	defer func() { _ = tx.Rollback(ctx) }()

	// Demo principals = users in @pulse.dev except admin.
	if _, err := tx.Exec(ctx, `
        DELETE FROM posts
        WHERE author_id IN (
            SELECT id FROM principals
            WHERE kind = 'user' AND lower(email) LIKE '%' || $1 AND id <> $2
        )
    `, demoEmailDomain, adminID); err != nil {
		return fmt.Errorf("delete demo posts: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        DELETE FROM comments
        WHERE author_id IN (
            SELECT id FROM principals
            WHERE kind = 'user' AND lower(email) LIKE '%' || $1 AND id <> $2
        )
    `, demoEmailDomain, adminID); err != nil {
		return fmt.Errorf("delete demo comments: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        DELETE FROM attachments
        WHERE uploader_id IN (
            SELECT id FROM principals
            WHERE kind = 'user' AND lower(email) LIKE '%' || $1 AND id <> $2
        )
           OR storage_key = $3
    `, demoEmailDomain, adminID, demoAttachmentKey); err != nil {
		return fmt.Errorf("delete demo attachments: %w", err)
	}

	// Demo sub-tags. tag_grants and tag_closure cascade from tags.
	demoSlugs := make([]string, 0, len(demoTags))
	for _, t := range demoTags {
		demoSlugs = append(demoSlugs, t.Slug)
	}
	if _, err := tx.Exec(ctx, `
        DELETE FROM tags
        WHERE parent_id IS NOT NULL
          AND slug = ANY($1::text[])
    `, demoSlugs); err != nil {
		return fmt.Errorf("delete demo tags: %w", err)
	}

	if _, err := tx.Exec(ctx, `
        DELETE FROM principals
        WHERE kind = 'user' AND lower(email) LIKE '%' || $1 AND id <> $2
    `, demoEmailDomain, adminID); err != nil {
		return fmt.Errorf("delete demo principals: %w", err)
	}
	return tx.Commit(ctx)
}

// ---------- helpers ----------

func envOr(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}

func fail(format string, args ...any) {
	fmt.Fprintf(os.Stderr, format+"\n", args...)
	os.Exit(1)
}
