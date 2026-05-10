package graphql

import (
	"context"

	"github.com/google/uuid"

	"github.com/bcnelson/pulse/services/api/internal/graphql/model"
)

// impersonationStateForSession reads the post-mutation session row and
// builds the ImpersonationState model. Lives in its own file so gqlgen
// regen doesn't strip it as orphan helper code.
func (r *Resolver) impersonationStateForSession(ctx context.Context, sessionID uuid.UUID) (*model.ImpersonationState, error) {
	var actingID uuid.UUID
	var effective *uuid.UUID
	if err := r.DB.QueryRow(ctx,
		`SELECT principal_id, effective_principal_id FROM sessions WHERE id = $1`,
		sessionID).Scan(&actingID, &effective); err != nil {
		return nil, err
	}
	out := &model.ImpersonationState{IsImpersonating: effective != nil}
	if out.IsImpersonating {
		acting, _ := r.loadPrincipalIface(ctx, actingID)
		out.Acting = acting
		eff, _ := r.loadPrincipalIface(ctx, *effective)
		out.Effective = eff
	}
	return out, nil
}

func mapDevicePlatformGQLToDB(p model.DevicePlatform) string {
	switch p {
	case model.DevicePlatformIos:
		return "ios"
	case model.DevicePlatformAndroid:
		return "android"
	case model.DevicePlatformWeb:
		return "web"
	}
	return ""
}
