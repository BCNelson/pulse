// Package mentions extracts the canonical Markdown-link mention forms
// from a body string. Pulse mentions are not bare `@slug` / `#slug`
// tokens — those are ambiguous with emails, URL fragments, and prose.
// Instead, the composer emits unambiguous CommonMark links with custom
// URL schemes:
//
//	[@alice](pulse-user:alice)
//	[#eng/backend](pulse-tag:eng/backend)
//
// Only those link forms count as mentions. A bare `@foo` typed without
// the composer's typeahead stays plain text and is never extracted.
package mentions

import (
	"regexp"
	"strings"
)

// slugSegment matches a single tag slug segment. Tag slugs in the DB are
// constrained `^[a-z0-9][a-z0-9-]*$`, but we accept any case here and
// lower on resolve so users typing `#Eng` still match the `eng` tag.
const slugSegment = `[a-zA-Z0-9][a-zA-Z0-9-]*`

// User mention: [@<label>](pulse-user:<slug>). The label text is not
// constrained (typeahead writes the same slug as the label, but an edit
// could change the display label without breaking resolution). Only the
// URL slug counts.
var userPattern = regexp.MustCompile(
	`\[@[^\]]+\]\(pulse-user:(` + slugSegment + `)\)`,
)

// Tag reference: [#<label>](pulse-tag:<slug-path>). The label is free-form;
// only the URL path is authoritative.
var tagPattern = regexp.MustCompile(
	`\[#[^\]]+\]\(pulse-tag:(` + slugSegment + `(?:/` + slugSegment + `)*)\)`,
)

// UserURLScheme and TagURLScheme are the canonical URL schemes the
// renderer and composer agree on. Exposed so callers building links
// programmatically don't drift from the regex above.
const (
	UserURLScheme = "pulse-user:"
	TagURLScheme  = "pulse-tag:"
)

// ExtractUsers scans body for canonical user-mention links and returns
// the captured slugs, lowercased, deduped, in first-occurrence order.
func ExtractUsers(body string) []string {
	matches := userPattern.FindAllStringSubmatch(body, -1)
	if len(matches) == 0 {
		return nil
	}
	seen := make(map[string]struct{}, len(matches))
	out := make([]string, 0, len(matches))
	for _, m := range matches {
		s := strings.ToLower(m[1])
		if _, ok := seen[s]; ok {
			continue
		}
		seen[s] = struct{}{}
		out = append(out, s)
	}
	return out
}

// ExtractTagPaths scans body for canonical tag-reference links and
// returns each path split into its slug segments, lowercased, deduped
// by joined-key, in first-occurrence order.
func ExtractTagPaths(body string) [][]string {
	matches := tagPattern.FindAllStringSubmatch(body, -1)
	if len(matches) == 0 {
		return nil
	}
	seen := make(map[string]struct{}, len(matches))
	out := make([][]string, 0, len(matches))
	for _, m := range matches {
		path := strings.ToLower(m[1])
		if _, ok := seen[path]; ok {
			continue
		}
		seen[path] = struct{}{}
		out = append(out, strings.Split(path, "/"))
	}
	return out
}
