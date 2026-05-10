package graphql

import (
	"context"
	"errors"
	"fmt"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"

	"github.com/bcnelson/pulse/services/api/internal/graphql/model"
	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// loadUser fetches a User principal by id. Returns nil, nil when the
// principal isn't a user or doesn't exist.
func (r *Resolver) loadUser(ctx context.Context, id uuid.UUID) (*model.User, error) {
	var (
		kind        string
		status      string
		displayName string
		email       *string
		homeTagID   *uuid.UUID
	)
	err := r.DB.QueryRow(ctx, `
        SELECT kind, status, display_name, email, home_tag_id
        FROM principals
        WHERE id = $1
    `, id).Scan(&kind, &status, &displayName, &email, &homeTagID)
	if errors.Is(err, pgx.ErrNoRows) {
		return nil, nil
	}
	if err != nil {
		return nil, fmt.Errorf("load principal: %w", err)
	}
	if kind != "user" {
		return nil, nil
	}

	out := &model.User{
		ID:          id.String(),
		GlobalURI:   ids.URI("principals", id),
		Kind:        model.PrincipalKindUser,
		Status:      mapStatusDBToGQL(status),
		DisplayName: displayName,
		Email:       email,
	}
	if homeTagID != nil {
		ht, err := r.loadTagShallow(ctx, *homeTagID)
		if err != nil {
			return nil, err
		}
		out.HomeTag = ht
	}
	return out, nil
}

func mapStatusDBToGQL(s string) model.PrincipalStatus {
	switch s {
	case "active":
		return model.PrincipalStatusActive
	case "tombstoned":
		return model.PrincipalStatusTombstoned
	}
	return ""
}
