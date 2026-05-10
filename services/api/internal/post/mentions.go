package post

import "regexp"

// mentionPattern matches @<slug-or-path> tokens at word boundaries. The
// slug grammar is alphanumeric, `_`, `-`, plus `/` for nested tag paths
// and `~` for user-tag prefixes (per the architecture's addressing scheme).
// The matcher returns the raw text of every match — resolution to a
// principal id is the caller's job, since slug-to-principal lookup needs
// DB access.
var mentionPattern = regexp.MustCompile(`(?:^|[^\w])@([a-zA-Z0-9_~/-]+)`)

// ExtractMentionSlugs scans body for @-mentions and returns the raw slugs
// (without the leading @). Duplicates are de-duped while preserving first-
// occurrence order so audit/notification ordering is stable.
func ExtractMentionSlugs(body string) []string {
	matches := mentionPattern.FindAllStringSubmatch(body, -1)
	if len(matches) == 0 {
		return nil
	}
	seen := make(map[string]struct{}, len(matches))
	out := make([]string, 0, len(matches))
	for _, m := range matches {
		s := m[1]
		if _, ok := seen[s]; ok {
			continue
		}
		seen[s] = struct{}{}
		out = append(out, s)
	}
	return out
}
