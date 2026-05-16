// Seed CLI: produces a populated demo workspace for local development.
// Idempotent — re-running is a no-op once the demo set is in place. Pass
// -fresh to delete the demo data first (admin and the org root tag are
// preserved). Run after `devenv up` has booted Postgres; the CLI applies
// migrations itself, so it works against an empty database too.
//
// Bootstrap admin: admin@pulse.dev / pulse-dev (override via PULSE_BOOTSTRAP_*).
// Demo users: alice@pulse.dev, bob@pulse.dev, charlie@pulse.dev, plus generated
// teammates (password "pulse-dev").
// Demo tags: engineering, product, plus a generated catalog under the org root.
// Demo posts + comments: hand-authored threads plus hundreds of generated posts
// with varied comment counts and a few high-volume threads.
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
	"math"
	"os"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	awsconfig "github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	s3types "github.com/aws/aws-sdk-go-v2/service/s3/types"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/bcnelson/pulse/services/api/internal/auth"
	"github.com/bcnelson/pulse/services/api/internal/bootstrap"
	"github.com/bcnelson/pulse/services/api/internal/chat"
	"github.com/bcnelson/pulse/services/api/internal/comment"
	pulsedb "github.com/bcnelson/pulse/services/api/internal/db"
	"github.com/bcnelson/pulse/services/api/internal/mentions"
	"github.com/bcnelson/pulse/services/api/internal/post"
	"github.com/bcnelson/pulse/services/api/internal/tag"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
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

var baseDemoUsers = []demoUser{
	{Email: "alice@pulse.dev", DisplayName: "Alice"},
	{Email: "bob@pulse.dev", DisplayName: "Bob"},
	{Email: "charlie@pulse.dev", DisplayName: "Charlie"},
}

var demoUsers = buildDemoUsers()

type demoTag struct {
	Slug        string
	DisplayName string
	// ParentSlug nests this tag below another demo tag. Empty means org root.
	ParentSlug string
	// Members is the demo users granted contributor on this tag.
	Members []string
}

var baseDemoTags = []demoTag{
	{Slug: "engineering", DisplayName: "Engineering", Members: []string{"alice@pulse.dev", "bob@pulse.dev"}},
	{Slug: "product", DisplayName: "Product", Members: []string{"bob@pulse.dev", "charlie@pulse.dev"}},
}

var demoTags = buildDemoTags()

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

var baseDemoPosts = []demoPost{
	{
		TagSlug: "engineering",
		Author:  "alice@pulse.dev",
		Title:   "Welcome to Pulse Engineering",
		Body:    "This is a seeded post under [#org/engineering](pulse-tag:org/engineering). [@bob](pulse-user:bob), [@charlie](pulse-user:charlie) — use it to poke at posts, comments, reactions.",
		Comments: []demoComment{
			{Author: "bob@pulse.dev", Body: "Hello from Bob! Thanks for the heads up, [@alice](pulse-user:alice)."},
			{Author: defaultAdminEmail, Body: "Looks good — let's iterate. Should we cross-post to [#org/product](pulse-tag:org/product)?"},
		},
	},
	{
		TagSlug: "product",
		Author:  "charlie@pulse.dev",
		Title:   "Roadmap discussion",
		Body:    "Drafting Q3 themes here under [#org/product](pulse-tag:org/product). [@alice](pulse-user:alice), [@bob](pulse-user:bob) — replies welcome.",
		Comments: []demoComment{
			{Author: "bob@pulse.dev", Body: "Could we link the spec doc? Also looping in [@admin](pulse-user:admin)."},
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
		Body:    "Use this post to poke at the spine-threaded comment view. Plenty of nesting below. [@bob](pulse-user:bob), [@charlie](pulse-user:charlie) — paging you for input.",
		Comments: []demoComment{
			// Root A: 12-deep primary thread.
			{Key: "A", Author: "alice@pulse.dev", Body: "What's the best way to ship the v1 rollout?"},
			{Key: "A1", ParentKey: "A", Author: "bob@pulse.dev", Body: "[@alice](pulse-user:alice) I'd start by gating it behind a workspace flag."},
			{Key: "A2", ParentKey: "A1", Author: "charlie@pulse.dev", Body: "Agree. What's the default state of the flag?"},
			{Key: "A3", ParentKey: "A2", Author: "alice@pulse.dev", Body: "Off. We'll flip it per workspace once metrics look healthy."},
			{Key: "A4", ParentKey: "A3", Author: "bob@pulse.dev", Body: "How are we monitoring those metrics?"},
			{Key: "A5", ParentKey: "A4", Author: "charlie@pulse.dev", Body: "I'll wire a Grafana board off the audit log next week."},
			{Key: "A6", ParentKey: "A5", Author: "alice@pulse.dev", Body: "Make sure error rate and p99 are on it."},
			{Key: "A7", ParentKey: "A6", Author: "bob@pulse.dev", Body: "Should we alert if either crosses a threshold?"},
			{Key: "A8", ParentKey: "A7", Author: "charlie@pulse.dev", Body: "Yes. Page on-call if p99 > 2s for 5 min."},
			{Key: "A9", ParentKey: "A8", Author: "alice@pulse.dev", Body: "Add a separate alert for sustained 5xx > 1%."},
			{Key: "A10", ParentKey: "A9", Author: "bob@pulse.dev", Body: "Will do. Both fire to the [#org/engineering](pulse-tag:org/engineering) on-call room."},
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

var demoPosts = buildDemoPosts()

func buildDemoUsers() []demoUser {
	generated := []string{
		"Jordan Lee",
		"Morgan Patel",
		"Riley Chen",
		"Taylor Kim",
		"Casey Nguyen",
		"Avery Brooks",
		"Quinn Rivera",
		"Sam Morgan",
		"Jamie Stone",
		"Drew Harper",
		"Cameron Ellis",
		"Parker Singh",
		"Reese Turner",
		"Skyler Woods",
		"Hayden Price",
		"Emerson Reed",
		"Finley Cox",
		"Kendall Flores",
		"Rowan Bennett",
		"Blair Foster",
		"Devon Hayes",
		"Marley Ross",
		"Alexis Ward",
		"Remy Torres",
		"Sage Murphy",
		"Robin Gray",
		"Harper Diaz",
		"Logan Perry",
		"Micah Bell",
		"Shawn Powell",
		"Addison Long",
		"Bailey Simmons",
		"Dakota Hughes",
		"Elliot Ramirez",
		"Frankie Coleman",
		"Kai Griffin",
		"Lane Jenkins",
		"Phoenix Bryant",
		"River Sullivan",
		"Tatum Russell",
		"Winter Cooper",
		"Zion Morris",
	}

	out := append([]demoUser{}, baseDemoUsers...)
	for _, name := range generated {
		out = append(out, demoUser{
			Email:       emailForDisplayName(name),
			DisplayName: name,
		})
	}
	return out
}

func demoUserEmails() []string {
	emails := make([]string, 0, len(demoUsers))
	for _, u := range demoUsers {
		emails = append(emails, u.Email)
	}
	return emails
}

func demoMemberRotations() [][]string {
	emails := demoUserEmails()
	rotations := make([][]string, 0, 9)
	for start := 0; start < 9; start++ {
		groupSize := 4 + start%4
		group := make([]string, 0, groupSize)
		for offset := 0; offset < groupSize; offset++ {
			group = append(group, emails[(start*5+offset*3)%len(emails)])
		}
		rotations = append(rotations, group)
	}
	return rotations
}

func emailForDisplayName(name string) string {
	return strings.ToLower(strings.ReplaceAll(name, " ", ".")) + demoEmailDomain
}

// userSlugFromEmail maps a @pulse.dev email to the matching user-tag root
// slug. Mirrors what `userSlugFromDisplayName` produces from the display
// name — e.g. "jordan.lee@pulse.dev" → "jordan-lee" — so seeded mention
// links can address users without going through a separate lookup.
func userSlugFromEmail(email string) string {
	local := strings.TrimSuffix(strings.ToLower(email), demoEmailDomain)
	return strings.ReplaceAll(local, ".", "-")
}

// userMentionMarkdown builds the canonical [@slug](pulse-user:slug) form
// for an email. Empty email returns "".
func userMentionMarkdown(email string) string {
	slug := userSlugFromEmail(email)
	if slug == "" {
		return ""
	}
	return fmt.Sprintf("[@%s](pulse-user:%s)", slug, slug)
}

// demoTagSlugPath returns the full root-to-leaf slug path for a demo tag,
// joined by "/" and prefixed with the org root slug. Used for inline
// [#path](pulse-tag:path) references in generated content.
func demoTagSlugPath(slug string) string {
	segments := []string{slug}
	cursor := slug
	for {
		var parent string
		for _, t := range demoTags {
			if t.Slug == cursor {
				parent = t.ParentSlug
				break
			}
		}
		if parent == "" {
			break
		}
		segments = append([]string{parent}, segments...)
		cursor = parent
	}
	return defaultOrgSlug + "/" + strings.Join(segments, "/")
}

// tagRefMarkdown builds the canonical [#path](pulse-tag:path) form.
func tagRefMarkdown(path string) string {
	if path == "" {
		return ""
	}
	return fmt.Sprintf("[#%s](pulse-tag:%s)", path, path)
}

func buildDemoTags() []demoTag {
	generated := []struct {
		Slug string
		Name string
	}{
		{"platform", "Platform"},
		{"infra", "Infrastructure"},
		{"security", "Security"},
		{"mobile", "Mobile"},
		{"web", "Web"},
		{"data", "Data"},
		{"design", "Design"},
		{"research", "Research"},
		{"support", "Support"},
		{"sales", "Sales"},
		{"marketing", "Marketing"},
		{"success", "Customer Success"},
		{"ops", "Operations"},
		{"finance", "Finance"},
		{"legal", "Legal"},
		{"people", "People"},
		{"qa", "Quality Assurance"},
		{"devrel", "Developer Relations"},
		{"integrations", "Integrations"},
		{"analytics", "Analytics"},
		{"growth", "Growth"},
		{"billing", "Billing"},
		{"onboarding", "Onboarding"},
		{"reliability", "Reliability"},
		{"api", "API"},
		{"workflow", "Workflow"},
		{"docs", "Documentation"},
		{"community", "Community"},
		{"experiments", "Experiments"},
		{"release", "Release"},
		{"compliance", "Compliance"},
		{"automation", "Automation"},
		{"moderation", "Moderation"},
		{"localization", "Localization"},
		{"accessibility", "Accessibility"},
		{"partnerships", "Partnerships"},
	}
	nested := []struct {
		ParentSlug string
		Slug       string
		Name       string
	}{
		{"platform", "platform-runtime", "Runtime"},
		{"platform-runtime", "platform-runtime-workers", "Workers"},
		{"platform-runtime-workers", "platform-runtime-workers-queues", "Queues"},
		{"platform-runtime-workers-queues", "platform-runtime-workers-queues-dead-letter", "Dead Letter Queues"},
		{"platform-runtime-workers-queues-dead-letter", "platform-runtime-workers-queues-dead-letter-alerts", "Dead Letter Alerts"},

		{"support", "support-enterprise", "Enterprise"},
		{"support-enterprise", "support-enterprise-onboarding", "Onboarding"},
		{"support-enterprise-onboarding", "support-enterprise-onboarding-migrations", "Migrations"},
		{"support-enterprise-onboarding-migrations", "support-enterprise-onboarding-migrations-imports", "Imports"},
		{"support-enterprise-onboarding-migrations-imports", "support-enterprise-onboarding-migrations-imports-validation", "Validation"},

		{"release", "release-trains", "Trains"},
		{"release-trains", "release-trains-mobile", "Mobile"},
		{"release-trains-mobile", "release-trains-mobile-beta", "Beta"},
		{"release-trains-mobile-beta", "release-trains-mobile-beta-ios", "iOS"},
		{"release-trains-mobile-beta-ios", "release-trains-mobile-beta-ios-crash-review", "Crash Review"},
	}
	memberRotations := demoMemberRotations()

	out := append([]demoTag{}, baseDemoTags...)
	for i, t := range generated {
		out = append(out, demoTag{
			Slug:        t.Slug,
			DisplayName: t.Name,
			Members:     memberRotations[i%len(memberRotations)],
		})
	}
	for i, t := range nested {
		out = append(out, demoTag{
			Slug:        t.Slug,
			DisplayName: t.Name,
			ParentSlug:  t.ParentSlug,
			Members:     memberRotations[(len(generated)+i)%len(memberRotations)],
		})
	}
	return out
}

func buildDemoPosts() []demoPost {
	out := append([]demoPost{}, baseDemoPosts...)

	commentCounts := []int{0, 1, 2, 3, 5, 8, 13}
	themes := []string{
		"planning",
		"incident review",
		"customer feedback",
		"launch readiness",
		"metrics check-in",
		"handoff notes",
		"design critique",
		"weekly update",
	}
	authors := demoUserEmails()

	for tagIndex, t := range demoTags {
		if t.Slug == "engineering" || t.Slug == "product" {
			continue
		}
		for postIndex, theme := range themes {
			sequence := tagIndex*len(themes) + postIndex + 1
			author := authors[(tagIndex+postIndex)%len(authors)]
			out = append(out, demoPost{
				TagSlug:  t.Slug,
				Author:   author,
				Title:    fmt.Sprintf("%s %s %03d", t.DisplayName, titleCase(theme), sequence),
				Body:     generatedPostBody(t.DisplayName, t.Slug, theme, sequence, author, authors),
				Comments: generatedComments(t.Slug, theme, sequence, commentCounts[(tagIndex+postIndex)%len(commentCounts)], authors),
			})
		}
	}

	heavyThreads := []struct {
		TagSlug    string
		Author     string
		Title      string
		Theme      string
		CommentNum int
	}{
		{TagSlug: "platform", Author: "alice@pulse.dev", Title: "Platform mega thread: launch checklist", Theme: "launch checklist", CommentNum: 48},
		{TagSlug: "support", Author: "bob@pulse.dev", Title: "Support mega thread: customer escalations", Theme: "customer escalations", CommentNum: 96},
		{TagSlug: "release", Author: "charlie@pulse.dev", Title: "Release mega thread: final readiness", Theme: "final readiness", CommentNum: 160},
	}
	for i, thread := range heavyThreads {
		out = append(out, demoPost{
			TagSlug: thread.TagSlug,
			Author:  thread.Author,
			Title:   thread.Title,
			Body: fmt.Sprintf(
				"Generated high-volume demo post with %d comments for exercising long discussion loading, pagination, and nested thread rendering.",
				thread.CommentNum,
			),
			Comments: generatedHeavyThreadComments(thread.TagSlug, thread.Theme, i+1, thread.CommentNum, authors),
		})
	}
	return out
}

func generatedPostBody(tagName, tagSlug, theme string, sequence int, author string, authors []string) string {
	base := fmt.Sprintf(
		"Generated demo post %03d for %s. Topic: %s. This gives local feeds, tag pages, search, and pagination enough volume to feel realistic.",
		sequence,
		tagName,
		theme,
	)
	tagRef := tagRefMarkdown(demoTagSlugPath(tagSlug))
	// Pick two co-authors that aren't the post's own author, deterministic
	// in `sequence` so reruns produce the same demo data.
	primary := pickOtherAuthor(authors, author, sequence)
	secondary := pickOtherAuthor(authors, author, sequence+1)
	primaryMention := userMentionMarkdown(primary)
	secondaryMention := userMentionMarkdown(secondary)
	return fmt.Sprintf(
		"%s %s and %s — flagging this in %s for visibility.",
		base, primaryMention, secondaryMention, tagRef,
	)
}

// pickOtherAuthor returns an author from `authors` that is not `exclude`,
// chosen deterministically by the salt. Falls back to "" if the slice has
// no other entries (which only happens in pathological test setups).
func pickOtherAuthor(authors []string, exclude string, salt int) string {
	if len(authors) == 0 {
		return ""
	}
	for i := 0; i < len(authors); i++ {
		candidate := authors[(salt+i)%len(authors)]
		if candidate != exclude {
			return candidate
		}
	}
	return authors[0]
}

func generatedComments(tagSlug, theme string, sequence, count int, authors []string) []demoComment {
	comments := make([]demoComment, 0, count)
	for i := 0; i < count; i++ {
		key := fmt.Sprintf("g-%s-%03d-%02d", tagSlug, sequence, i)
		parentKey := ""
		switch {
		case i == 0:
			parentKey = ""
		case i%4 == 1:
			parentKey = fmt.Sprintf("g-%s-%03d-%02d", tagSlug, sequence, 0)
		case i%4 == 2:
			parentKey = fmt.Sprintf("g-%s-%03d-%02d", tagSlug, sequence, i-1)
		}
		author := authors[(sequence+i)%len(authors)]
		comments = append(comments, demoComment{
			Key:       key,
			ParentKey: parentKey,
			Author:    author,
			Body:      generatedCommentBody(tagSlug, theme, sequence, i, author, authors),
		})
	}
	return comments
}

func generatedCommentBody(tagSlug, theme string, sequence, index int, author string, authors []string) string {
	targetWords := normallyDistributedWordCount(sequence, index, 55, 36, 2, 190)
	body := generatedCommentText(theme, sequence, index, targetWords)
	// Salt the modulus with the tag too, so two posts in different tags
	// don't end up with identically-positioned mentions.
	saltSum := 0
	for _, ch := range tagSlug {
		saltSum += int(ch)
	}
	pattern := (sequence + index + saltSum) % 3
	switch pattern {
	case 0:
		// ~33% — direct @-mention reply to another contributor.
		other := pickOtherAuthor(authors, author, sequence+index)
		return userMentionMarkdown(other) + " " + body
	case 1:
		// ~33% — tag reference at the end for visibility on tag feeds.
		return body + " " + tagRefMarkdown(demoTagSlugPath(tagSlug))
	default:
		// ~33% — no mention.
		return body
	}
}

func generatedHeavyThreadComments(tagSlug, theme string, sequence, count int, authors []string) []demoComment {
	comments := make([]demoComment, 0, count)
	for i := 0; i < count; i++ {
		key := fmt.Sprintf("heavy-%s-%02d-%03d", tagSlug, sequence, i)
		parentKey := ""
		switch {
		case i == 0 || i%12 == 0:
			parentKey = ""
		case i%5 == 0:
			parentKey = fmt.Sprintf("heavy-%s-%02d-%03d", tagSlug, sequence, i-5)
		case i%3 == 0:
			parentKey = fmt.Sprintf("heavy-%s-%02d-%03d", tagSlug, sequence, i-2)
		default:
			parentKey = fmt.Sprintf("heavy-%s-%02d-%03d", tagSlug, sequence, i-1)
		}
		author := authors[(sequence+i)%len(authors)]
		comments = append(comments, demoComment{
			Key:       key,
			ParentKey: parentKey,
			Author:    author,
			Body:      generatedHeavyThreadCommentBody(tagSlug, theme, count, i, author, authors),
		})
	}
	return comments
}

func generatedHeavyThreadCommentBody(tagSlug, theme string, count, index int, author string, authors []string) string {
	targetWords := normallyDistributedWordCount(count, index, 70, 48, 2, 260)
	body := generatedCommentText(theme, count, index, targetWords)
	// Heavy threads see a mention every other reply so notification UI
	// has plenty to surface.
	if index%2 == 0 {
		other := pickOtherAuthor(authors, author, count+index)
		return userMentionMarkdown(other) + " " + body
	}
	if index%3 == 0 {
		return body + " " + tagRefMarkdown(demoTagSlugPath(tagSlug))
	}
	return body
}

func normallyDistributedWordCount(seedA, seedB, mean, stddev, min, max int) int {
	u1 := deterministicUnit(seedA, seedB, 1)
	u2 := deterministicUnit(seedA, seedB, 2)
	z := math.Sqrt(-2*math.Log(u1)) * math.Cos(2*math.Pi*u2)
	words := int(math.Round(float64(mean) + z*float64(stddev)))
	if words < min {
		return min
	}
	if words > max {
		return max
	}
	return words
}

func deterministicUnit(a, b, salt int) float64 {
	x := uint64(a+1)*0x9e3779b185ebca87 ^ uint64(b+1)*0xc2b2ae3d27d4eb4f ^ uint64(salt)*0x165667b19e3779f9
	x ^= x >> 30
	x *= 0xbf58476d1ce4e5b9
	x ^= x >> 27
	x *= 0x94d049bb133111eb
	x ^= x >> 31
	return (float64(x%1_000_000) + 1) / 1_000_001
}

func generatedCommentText(theme string, sequence, index, targetWords int) string {
	short := []string{
		"+1",
		"LGTM.",
		"Done.",
		"Ship it.",
		"Same concern here.",
		"Can we split this out?",
		"Please link the doc.",
	}
	if targetWords <= 6 {
		return short[(sequence+index)%len(short)]
	}

	sentences := []string{
		fmt.Sprintf("Tracking this for %s item %03d.", theme, sequence),
		"The current plan looks workable, but the owner should write down the next checkpoint before this moves forward.",
		"I want to make sure the rollout leaves enough room for review, iteration, and a clean handoff.",
		"The main open question is whether the first milestone is narrow enough to validate without creating extra coordination work.",
		"If the timeline changes, we should call that out early so support and release notes stay aligned.",
		"This seeded reply is intentionally varied so local clients render mixed comment heights, line wrapping, and scroll positions.",
		"The decision history matters here because someone joining later needs to understand the rejected alternatives.",
		"A smaller first pass would let us catch confusing wording, slow screens, and missing notifications before the broader audience sees it.",
		"I also want a clear follow-up owner because long discussions get hard to scan once replies start branching.",
		"Nothing here needs to block the whole effort, but the risk should be visible in the thread.",
	}

	var parts []string
	words := 0
	for words < targetWords {
		sentence := sentences[(sequence+index+len(parts))%len(sentences)]
		parts = append(parts, sentence)
		words += len(strings.Fields(sentence))
	}
	return strings.Join(parts, " ")
}

func titleCase(s string) string {
	parts := strings.Fields(s)
	for i, part := range parts {
		if part == "" {
			continue
		}
		parts[i] = strings.ToUpper(part[:1]) + part[1:]
	}
	return strings.Join(parts, " ")
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
		fmt.Printf("seed: created admin %s and org tag %s\n", ids.FormatID(bootRes.PrincipalID), ids.FormatID(bootRes.OrgTagID))
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
	if err := ensureUserTagRoots(ctx, pool, adminID, users); err != nil {
		fail("seed user tag roots: %v", err)
	}
	tags, err := ensureDemoTags(ctx, pool, orgTagID, users)
	if err != nil {
		fail("seed tags: %v", err)
	}
	postIDs, err := ensureDemoPosts(ctx, pool, adminID, users, tags)
	if err != nil {
		fail("seed posts: %v", err)
	}
	if err := ensureDemoChat(ctx, pool, adminID, users, tags); err != nil {
		fail("seed chat: %v", err)
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

func lookupAdminAndOrg(ctx context.Context, pool *pgxpool.Pool, adminEmail string) (int64, int64, error) {
	var adminID int64
	if err := pool.QueryRow(ctx,
		`SELECT id FROM principals WHERE kind = 'user' AND lower(email) = lower($1)`, adminEmail).
		Scan(&adminID); err != nil {
		return int64(0), int64(0), fmt.Errorf("find admin %q: %w", adminEmail, err)
	}
	var orgID int64
	if err := pool.QueryRow(ctx,
		`SELECT id FROM tags WHERE parent_id IS NULL AND root_kind = 'org' ORDER BY created_at LIMIT 1`).
		Scan(&orgID); err != nil {
		return int64(0), int64(0), fmt.Errorf("find org root: %w", err)
	}
	return adminID, orgID, nil
}

// ensureDemoUsers creates the demo users that are missing and returns the
// full email->id map (covering both freshly-created and pre-existing rows).
func ensureDemoUsers(ctx context.Context, pool *pgxpool.Pool) (map[string]int64, error) {
	hash, err := auth.HashPassword(demoPassword)
	if err != nil {
		return nil, fmt.Errorf("hash demo password: %w", err)
	}

	out := map[string]int64{}
	for _, u := range demoUsers {
		var id int64
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

// ensureUserTagRoots gives admin + every demo user a user-tag root with a
// slug derived from their display name and links it to principals.home_tag_id.
// Required for `[@slug](pulse-user:slug)` mention resolution and for the
// /feed/t/<user-slug>/... routes that mention chips link to. Idempotent.
func ensureUserTagRoots(ctx context.Context, pool *pgxpool.Pool, adminID int64, users map[string]int64) error {
	// Admin first.
	var adminName string
	if err := pool.QueryRow(ctx,
		`SELECT display_name FROM principals WHERE id = $1`, adminID).Scan(&adminName); err != nil {
		return fmt.Errorf("load admin display name: %w", err)
	}
	if err := ensureUserTagRoot(ctx, pool, adminID, userSlugFromDisplayName(adminName), adminName); err != nil {
		return fmt.Errorf("admin user-tag root: %w", err)
	}
	// Demo users.
	for _, u := range demoUsers {
		pid, ok := users[u.Email]
		if !ok {
			continue
		}
		if err := ensureUserTagRoot(ctx, pool, pid, userSlugFromDisplayName(u.DisplayName), u.DisplayName); err != nil {
			return fmt.Errorf("user-tag root for %s: %w", u.Email, err)
		}
	}
	return nil
}

// ensureUserTagRoot inserts a user-tag root for the given principal if one
// does not already exist and updates principals.home_tag_id. Touches three
// tables (tags, tag_closure, principals) in one transaction so a partial
// failure doesn't leave a half-linked user.
func ensureUserTagRoot(ctx context.Context, pool *pgxpool.Pool, principalID int64, slug, displayName string) error {
	var existing int64
	err := pool.QueryRow(ctx, `
        SELECT id FROM tags
        WHERE parent_id IS NULL AND root_kind = 'user' AND bound_principal = $1
    `, principalID).Scan(&existing)
	if err == nil {
		// Already provisioned — ensure principal points at it.
		if _, err := pool.Exec(ctx,
			`UPDATE principals SET home_tag_id = $1 WHERE id = $2 AND home_tag_id IS DISTINCT FROM $1`,
			existing, principalID); err != nil {
			return fmt.Errorf("relink home_tag: %w", err)
		}
		return nil
	}
	if !errors.Is(err, pgx.ErrNoRows) {
		return fmt.Errorf("lookup user-tag root: %w", err)
	}

	tx, err := pool.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return err
	}
	defer func() { _ = tx.Rollback(ctx) }()

	tagID := ids.New(ids.KindTag)
	if _, err := tx.Exec(ctx, `
        INSERT INTO tags (id, parent_id, slug, display_name, root_kind, bound_principal, defaults)
        VALUES ($1, NULL, $2, $3, 'user', $4, '{}')
    `, tagID, slug, displayName, principalID); err != nil {
		return fmt.Errorf("insert user-tag root: %w", err)
	}
	if _, err := tx.Exec(ctx,
		`INSERT INTO tag_closure (ancestor_id, descendant_id, depth) VALUES ($1, $1, 0)`,
		tagID); err != nil {
		return fmt.Errorf("insert closure: %w", err)
	}
	if _, err := tx.Exec(ctx,
		`UPDATE principals SET home_tag_id = $1 WHERE id = $2`,
		tagID, principalID); err != nil {
		return fmt.Errorf("link home_tag: %w", err)
	}
	if err := tx.Commit(ctx); err != nil {
		return err
	}
	fmt.Printf("seed: created user-tag root @%s for principal %s\n", slug, ids.FormatID(principalID))
	return nil
}

// userSlugFromDisplayName converts a display name to a tag-slug-compatible
// form: lowercase, spaces → hyphens, characters outside [a-z0-9-] dropped.
// Mirrors the regex constraint on `tags.slug`.
func userSlugFromDisplayName(name string) string {
	var b strings.Builder
	b.Grow(len(name))
	for _, r := range strings.ToLower(name) {
		switch {
		case r >= 'a' && r <= 'z', r >= '0' && r <= '9':
			b.WriteRune(r)
		case r == ' ' || r == '-' || r == '_' || r == '.':
			b.WriteByte('-')
		}
	}
	s := b.String()
	for strings.HasPrefix(s, "-") {
		s = s[1:]
	}
	for strings.HasSuffix(s, "-") {
		s = s[:len(s)-1]
	}
	return s
}

func createUser(ctx context.Context, pool *pgxpool.Pool, u demoUser, hash string) (int64, error) {
	id := ids.New(ids.KindUser)
	tx, err := pool.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return int64(0), err
	}
	defer func() { _ = tx.Rollback(ctx) }()

	uri := "local://principals/" + ids.FormatID(id)
	if _, err := tx.Exec(ctx, `
        INSERT INTO principals (id, kind, status, global_uri, display_name, email)
        VALUES ($1, 'user', 'active', $2, $3, $4)
    `, id, uri, u.DisplayName, strings.ToLower(u.Email)); err != nil {
		return int64(0), fmt.Errorf("insert principal: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        INSERT INTO user_credentials (principal_id, password_hash) VALUES ($1, $2)
    `, id, hash); err != nil {
		return int64(0), fmt.Errorf("insert credential: %w", err)
	}
	if err := tx.Commit(ctx); err != nil {
		return int64(0), err
	}
	return id, nil
}

// ensureDemoTags creates the demo sub-tags (under org root) if missing and
// returns the slug->id map. Member grants are inserted idempotently.
func ensureDemoTags(ctx context.Context, pool *pgxpool.Pool, orgTagID int64, users map[string]int64) (map[string]int64, error) {
	tagSvc := &tag.Service{DB: pool}
	out := map[string]int64{}
	for _, t := range demoTags {
		parentID := orgTagID
		parentLabel := "org"
		if t.ParentSlug != "" {
			id, ok := out[t.ParentSlug]
			if !ok {
				return nil, fmt.Errorf("tag %s references unknown ParentSlug %q (parents must appear before children)", t.Slug, t.ParentSlug)
			}
			parentID = id
			parentLabel = t.ParentSlug
		}

		var id int64
		err := pool.QueryRow(ctx,
			`SELECT id FROM tags WHERE parent_id = $1 AND slug = $2`, parentID, t.Slug).
			Scan(&id)
		if errors.Is(err, pgx.ErrNoRows) {
			id, err = tagSvc.Create(ctx, tag.CreateInput{
				ParentID:    &parentID,
				Slug:        t.Slug,
				DisplayName: t.DisplayName,
				RootKind:    tag.RootKindOrg,
			})
			if err != nil {
				return nil, fmt.Errorf("create tag %s: %w", t.Slug, err)
			}
			fmt.Printf("seed: created tag %s under %s\n", t.Slug, parentLabel)
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
func ensureDemoPosts(ctx context.Context, pool *pgxpool.Pool, adminID int64, users, tags map[string]int64) (map[string]int64, error) {
	postSvc := &post.Service{DB: pool}
	commentSvc := &comment.Service{DB: pool}
	out := map[string]int64{}

	for _, p := range demoPosts {
		tagID, ok := tags[p.TagSlug]
		if !ok {
			return nil, fmt.Errorf("tag %s missing from seed map", p.TagSlug)
		}
		authorID := principalFor(p.Author, adminID, users)

		var id int64
		err := pool.QueryRow(ctx, `
            SELECT p.id FROM posts p
            JOIN post_tags pt ON pt.post_id = p.id
            WHERE pt.tag_id = $1 AND p.title = $2 AND p.deleted_at IS NULL
            LIMIT 1
        `, tagID, p.Title).Scan(&id)
		if errors.Is(err, pgx.ErrNoRows) {
			mentionIDs, err := resolveSeedMentions(ctx, pool, p.Body)
			if err != nil {
				return nil, fmt.Errorf("resolve mentions on %q: %w", p.Title, err)
			}
			tagRefIDs, err := resolveSeedTagRefs(ctx, pool, p.Body)
			if err != nil {
				return nil, fmt.Errorf("resolve tag refs on %q: %w", p.Title, err)
			}
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
				Mentions: mentionIDs,
				TagRefs:  tagRefIDs,
			})
			if err != nil {
				return nil, fmt.Errorf("create post %q: %w", p.Title, err)
			}
			fmt.Printf("seed: created post %q under %s\n", p.Title, p.TagSlug)
		} else if err != nil {
			return nil, fmt.Errorf("lookup post %q: %w", p.Title, err)
		}
		out[p.Title] = id

		idByKey := map[string]int64{}
		for _, c := range p.Comments {
			var parentID *int64
			if c.ParentKey != "" {
				pid, ok := idByKey[c.ParentKey]
				if !ok {
					return nil, fmt.Errorf("comment on %q references unknown ParentKey %q (parents must appear before children)", p.Title, c.ParentKey)
				}
				parentID = &pid
			}

			var existingID int64
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

			mentionIDs, err := resolveSeedMentions(ctx, pool, c.Body)
			if err != nil {
				return nil, fmt.Errorf("resolve mentions on comment of %q: %w", p.Title, err)
			}
			tagRefIDs, err := resolveSeedTagRefs(ctx, pool, c.Body)
			if err != nil {
				return nil, fmt.Errorf("resolve tag refs on comment of %q: %w", p.Title, err)
			}
			authorID := principalFor(c.Author, adminID, users)
			newID, err := commentSvc.Create(ctx, comment.CreateInput{
				PostID:   id,
				ParentID: parentID,
				AuthorID: authorID,
				Body:     c.Body,
				Mentions: mentionIDs,
				TagRefs:  tagRefIDs,
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

// demoChatRoom is the in-memory shape for a seeded chat room. The seed
// either creates the room (idempotent by participant set + tag) or finds
// the existing one and ensures every named message is present.
type demoChatRoom struct {
	Label        string // human-readable, only for log lines
	TagSlug      string // empty for a DM
	Participants []string
	Messages     []demoMessage
}

type demoMessage struct {
	Author string
	Body   string
}

// demoChatRooms is the seeded chat content. The Engineering huddle is a
// team room tagged with `engineering`; the second entry is a 1:1 DM
// between alice and bob. Bodies use the canonical mention/tag-ref form
// so the new junctions get populated end-to-end.
var demoChatRooms = []demoChatRoom{
	{
		Label:        "engineering huddle",
		TagSlug:      "engineering",
		Participants: []string{"alice@pulse.dev", "bob@pulse.dev", defaultAdminEmail},
		Messages: []demoMessage{
			{Author: "alice@pulse.dev", Body: "morning [@bob](pulse-user:bob), did the [#org/engineering](pulse-tag:org/engineering) deploy land?"},
			{Author: "bob@pulse.dev", Body: "[@alice](pulse-user:alice) yes — pushed at 9:12. holding rollout until [@admin](pulse-user:admin) green-lights the cutover."},
			{Author: defaultAdminEmail, Body: "thumbs up. [@alice](pulse-user:alice) [@bob](pulse-user:bob) — please file a follow-up in [#org/engineering](pulse-tag:org/engineering) once metrics settle."},
			{Author: "alice@pulse.dev", Body: "will do. [@charlie](pulse-user:charlie) might want eyes on the [#org/product](pulse-tag:org/product) thread too."},
			{Author: "bob@pulse.dev", Body: "looping in [@charlie](pulse-user:charlie) now."},
		},
	},
	{
		Label:        "alice <> bob DM",
		TagSlug:      "",
		Participants: []string{"alice@pulse.dev", "bob@pulse.dev"},
		Messages: []demoMessage{
			{Author: "alice@pulse.dev", Body: "hey [@bob](pulse-user:bob) — got a sec to look at the retry logic?"},
			{Author: "bob@pulse.dev", Body: "yep. send the PR, [@alice](pulse-user:alice)."},
			{Author: "alice@pulse.dev", Body: "linked in the [#org/engineering](pulse-tag:org/engineering) thread. ping if anything looks off."},
			{Author: "bob@pulse.dev", Body: "reading now."},
		},
	},
}

// ensureDemoChat seeds the chat rooms in `demoChatRooms`. Each room is
// looked up by tag attachment + participant set; messages are inserted
// only if a row with the exact same author+body isn't already present,
// so re-runs are idempotent. Mentions and tag refs flow through the
// regular chat.SendMessage path so the message_mentions and
// message_tag_refs junctions populate.
func ensureDemoChat(ctx context.Context, pool *pgxpool.Pool, adminID int64, users, tags map[string]int64) error {
	chatSvc := &chat.Service{DB: pool, Posts: &post.Service{DB: pool}}
	for _, room := range demoChatRooms {
		var tagID int64
		if room.TagSlug != "" {
			id, ok := tags[room.TagSlug]
			if !ok {
				return fmt.Errorf("chat room %q references unknown tag %q", room.Label, room.TagSlug)
			}
			tagID = id
		}

		participantIDs := make([]int64, 0, len(room.Participants))
		for _, email := range room.Participants {
			participantIDs = append(participantIDs, principalFor(email, adminID, users))
		}

		roomID, err := findOrCreateChatRoom(ctx, pool, chatSvc, room.Label, tagID, participantIDs)
		if err != nil {
			return fmt.Errorf("ensure chat room %q: %w", room.Label, err)
		}

		for _, m := range room.Messages {
			var existing int64
			err := pool.QueryRow(ctx,
				`SELECT id FROM messages WHERE chat_room_id = $1 AND body = $2 LIMIT 1`,
				roomID, m.Body).Scan(&existing)
			if err == nil {
				continue
			}
			if !errors.Is(err, pgx.ErrNoRows) {
				return fmt.Errorf("lookup chat message in %q: %w", room.Label, err)
			}
			mentionIDs, err := resolveSeedMentions(ctx, pool, m.Body)
			if err != nil {
				return fmt.Errorf("resolve mentions in %q: %w", room.Label, err)
			}
			tagRefIDs, err := resolveSeedTagRefs(ctx, pool, m.Body)
			if err != nil {
				return fmt.Errorf("resolve tag refs in %q: %w", room.Label, err)
			}
			if _, err := chatSvc.SendMessage(ctx, chat.SendInput{
				RoomID:   roomID,
				AuthorID: principalFor(m.Author, adminID, users),
				Body:     m.Body,
				Mentions: mentionIDs,
				TagRefs:  tagRefIDs,
			}); err != nil {
				return fmt.Errorf("send chat message in %q: %w", room.Label, err)
			}
		}
		fmt.Printf("seed: chat room %q ready (%d messages, %d participants)\n",
			room.Label, len(room.Messages), len(participantIDs))
	}
	return nil
}

// findOrCreateChatRoom looks for a room with the requested tag (or no
// tag, for DMs) whose participant set exactly matches the supplied ids,
// and creates one if none exists. This lets re-running the seed land on
// the same room each time.
func findOrCreateChatRoom(ctx context.Context, pool *pgxpool.Pool, chatSvc *chat.Service, label string, tagID int64, participantIDs []int64) (int64, error) {
	// Look for any room whose active participants are exactly the
	// requested set. For team rooms we also require the named tag to be
	// attached. For DMs we require no tag attachments.
	var roomID int64
	var err error
	if tagID == 0 {
		err = pool.QueryRow(ctx, `
            SELECT cr.id FROM chat_rooms cr
            WHERE NOT EXISTS (SELECT 1 FROM chat_room_tags WHERE chat_room_id = cr.id)
              AND (
                SELECT array_agg(principal_id ORDER BY principal_id)
                FROM chat_room_participants
                WHERE chat_room_id = cr.id AND left_at IS NULL
              ) = (SELECT array_agg(x ORDER BY x) FROM unnest($1::bigint[]) AS x)
            LIMIT 1
        `, participantIDs).Scan(&roomID)
	} else {
		err = pool.QueryRow(ctx, `
            SELECT cr.id FROM chat_rooms cr
            JOIN chat_room_tags crt ON crt.chat_room_id = cr.id AND crt.tag_id = $1
            WHERE (
                SELECT array_agg(principal_id ORDER BY principal_id)
                FROM chat_room_participants
                WHERE chat_room_id = cr.id AND left_at IS NULL
              ) = (SELECT array_agg(x ORDER BY x) FROM unnest($2::bigint[]) AS x)
            LIMIT 1
        `, tagID, participantIDs).Scan(&roomID)
	}
	if err == nil {
		return roomID, nil
	}
	if !errors.Is(err, pgx.ErrNoRows) {
		return 0, fmt.Errorf("lookup chat room: %w", err)
	}

	// Build the room via the service so is_dm gets recomputed correctly.
	in := chat.CreateRoomInput{
		Participants: make([]chat.ParticipantInput, 0, len(participantIDs)),
	}
	if tagID != 0 {
		in.Tags = []int64{tagID}
	}
	for _, pid := range participantIDs {
		in.Participants = append(in.Participants, chat.ParticipantInput{PrincipalID: pid})
	}
	id, err := chatSvc.CreateRoom(ctx, in)
	if err != nil {
		return 0, fmt.Errorf("create chat room: %w", err)
	}
	fmt.Printf("seed: created chat room %q\n", label)
	return id, nil
}

// resolveSeedMentions runs the same extraction + lookup the GraphQL
// resolver does, but inlined here so the seed CLI doesn't need a full
// Resolver instance. Unknown slugs are silently dropped — matches the
// production behaviour of leaving the link text in the body.
func resolveSeedMentions(ctx context.Context, pool *pgxpool.Pool, body string) ([]int64, error) {
	slugs := mentions.ExtractUsers(body)
	if len(slugs) == 0 {
		return nil, nil
	}
	rows, err := pool.Query(ctx, `
        SELECT p.id
        FROM principals p
        JOIN tags t ON t.id = p.home_tag_id
        WHERE p.status = 'active'
          AND t.parent_id IS NULL
          AND t.root_kind = 'user'
          AND t.slug = ANY($1::text[])
    `, slugs)
	if err != nil {
		return nil, fmt.Errorf("query mentions: %w", err)
	}
	defer rows.Close()
	seen := make(map[int64]struct{}, len(slugs))
	out := make([]int64, 0, len(slugs))
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		if _, dup := seen[id]; dup {
			continue
		}
		seen[id] = struct{}{}
		out = append(out, id)
	}
	return out, rows.Err()
}

// resolveSeedTagRefs walks each `pulse-tag:` slug path through the tags
// table, paralleling the GraphQL resolver. Skips unresolved paths.
func resolveSeedTagRefs(ctx context.Context, pool *pgxpool.Pool, body string) ([]int64, error) {
	paths := mentions.ExtractTagPaths(body)
	if len(paths) == 0 {
		return nil, nil
	}
	seen := make(map[int64]struct{}, len(paths))
	out := make([]int64, 0, len(paths))
	for _, path := range paths {
		var id int64
		err := pool.QueryRow(ctx, `
            WITH RECURSIVE walk(id, depth) AS (
              SELECT id, 0
              FROM tags
              WHERE parent_id IS NULL AND slug = ($1::text[])[1]
              UNION ALL
              SELECT t.id, walk.depth + 1
              FROM tags t
              JOIN walk ON t.parent_id = walk.id
              WHERE t.slug = ($1::text[])[walk.depth + 2]
            )
            SELECT id FROM walk WHERE depth = array_length($1::text[], 1) - 1
        `, path).Scan(&id)
		if errors.Is(err, pgx.ErrNoRows) {
			continue
		}
		if err != nil {
			return nil, fmt.Errorf("resolve tag path %v: %w", path, err)
		}
		if _, dup := seen[id]; dup {
			continue
		}
		seen[id] = struct{}{}
		out = append(out, id)
	}
	return out, nil
}

func principalFor(email string, adminID int64, users map[string]int64) int64 {
	if email == "" || strings.EqualFold(email, defaultAdminEmail) {
		return adminID
	}
	if id, ok := users[email]; ok {
		return id
	}
	return adminID
}

// ---------- attachments ----------

func ensureDemoAttachment(ctx context.Context, pool *pgxpool.Pool, cfg seedConfig, adminID int64, postIDs map[string]int64) error {
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
	var firstID int64
	var firstTitle string
	for _, p := range demoPosts {
		if id, ok := postIDs[p.Title]; ok {
			firstID = id
			firstTitle = p.Title
			break
		}
	}
	if firstID == int64(0) {
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
func wipeDemo(ctx context.Context, pool *pgxpool.Pool, adminID int64) error {
	tx, err := pool.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return err
	}
	defer func() { _ = tx.Rollback(ctx) }()

	// Demo principals = users in @pulse.dev except admin. Wipe their
	// chat rooms first; chat_rooms cascades into messages, participants,
	// tags, and the new mention/tag-ref junctions.
	if _, err := tx.Exec(ctx, `
        DELETE FROM chat_rooms
        WHERE id IN (
            SELECT chat_room_id FROM chat_room_participants
            WHERE principal_id IN (
                SELECT id FROM principals
                WHERE kind = 'user' AND lower(email) LIKE '%' || $1 AND id <> $2
            )
        )
    `, demoEmailDomain, adminID); err != nil {
		return fmt.Errorf("delete demo chat rooms (by participant): %w", err)
	}
	// Also drop the engineering huddle, which has admin as a participant
	// — without this pass that room would survive a -fresh because its
	// non-admin members are about to be deleted but the room itself isn't.
	if _, err := tx.Exec(ctx, `
        DELETE FROM chat_rooms
        WHERE id IN (
            SELECT cr.id FROM chat_rooms cr
            JOIN chat_room_participants crp ON crp.chat_room_id = cr.id
            WHERE crp.principal_id = $1
        )
    `, adminID); err != nil {
		return fmt.Errorf("delete demo chat rooms (admin): %w", err)
	}
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

	// Unlink home_tag_id on demo principals so the user-tag root deletes
	// don't trip the principals.home_tag_id FK, then drop the roots.
	if _, err := tx.Exec(ctx, `
        UPDATE principals SET home_tag_id = NULL
        WHERE kind = 'user' AND lower(email) LIKE '%' || $1 AND id <> $2
    `, demoEmailDomain, adminID); err != nil {
		return fmt.Errorf("unlink demo home_tag: %w", err)
	}
	if _, err := tx.Exec(ctx, `
        DELETE FROM tags
        WHERE parent_id IS NULL AND root_kind = 'user'
          AND bound_principal IN (
            SELECT id FROM principals
            WHERE kind = 'user' AND lower(email) LIKE '%' || $1 AND id <> $2
          )
    `, demoEmailDomain, adminID); err != nil {
		return fmt.Errorf("delete demo user-tag roots: %w", err)
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
