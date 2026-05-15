package graphql

import (
	"context"
	"fmt"
)

// resolveMentionSlugs maps @-token slugs to principal ids. M2 strategy is
// case-insensitive match against display_name first, falling back to
// email. Slugs that match nothing are silently dropped — mention text
// itself remains in the body. M5 introduces a proper user-handle column
// derived from the user-tag root slug for unambiguous lookups.
func (r *Resolver) resolveMentionSlugs(ctx context.Context, slugs []string) ([]int64, error) {
	if len(slugs) == 0 {
		return nil, nil
	}
	out := make([]int64, 0, len(slugs))
	for _, s := range slugs {
		var id int64
		err := r.DB.QueryRow(ctx, `
            SELECT id FROM principals
            WHERE status = 'active' AND (
                lower(display_name) = lower($1) OR
                lower(email)        = lower($1)
            )
            LIMIT 1
        `, s).Scan(&id)
		if err == nil {
			out = append(out, id)
			continue
		}
		// Match miss is not an error — clients see the mention text;
		// notification fan-out (M4) just doesn't ping anyone.
		if err.Error() == "no rows in result set" {
			continue
		}
		// pgx returns its own ErrNoRows; recheck loosely so we don't import
		// the package just for this string compare.
		if isNoRows(err) {
			continue
		}
		return nil, fmt.Errorf("resolve mention %q: %w", s, err)
	}
	return out, nil
}

func isNoRows(err error) bool {
	return err != nil && err.Error() == "no rows in result set"
}
