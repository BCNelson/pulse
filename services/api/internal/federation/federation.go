// Package federation is the v1 placeholder for v2 federation work.
// v1 deployments are single-instance; the federation seam keeps that
// future open without paying for it today.
//
// Two artifacts ship here:
//
//  1. URI mapping helpers: parse a federation-shaped URI
//     ("local://<kind>/<uuid>" or "<instance>/<kind>/<uuid>") and
//     decide whether it points at this instance or a remote one. The
//     ID format already has this shape (see pkg/ids); the parser
//     here lets callers branch on local vs remote without coupling
//     to URL parsing details.
//
//  2. AuthorityResolver — a Service-style hook the perm package can
//     consult before evaluating a remote-authoritative reference. v1
//     never returns a remote authority; the type exists so v2 can
//     plug in without touching every call site.
//
// Single-instance behavior is unchanged: every URI parses to a
// LocalRef, AuthorityResolver always returns LocalAuthority. The
// v2 escape hatch is to swap in a federation-aware Resolver that
// delegates to a remote-fetch + perm-check pipeline.
package federation

import (
	"errors"
	"fmt"
	"strings"

	"github.com/bcnelson/pulse/services/api/pkg/ids"
)

// LocalScheme is the URI scheme used when an entity belongs to this
// instance. v1 always emits this; v2 will introduce instance-named
// schemes for cross-deployment references.
const LocalScheme = "local"

// Ref describes a parsed federation-shaped URI.
type Ref struct {
	// IsLocal is true when the URI's authority is this instance.
	IsLocal bool
	// Instance is the authority part for non-local refs (e.g. an
	// origin-style host). Empty when IsLocal.
	Instance string
	// Kind names the entity type (principals, tags, posts, ...).
	Kind string
	// ID is the UUID of the entity.
	ID int64
}

// ErrInvalidURI is returned when a URI doesn't match the expected
// federation shape. Callers should treat the URI as opaque (not
// dereference it) when this surfaces.
var ErrInvalidURI = errors.New("federation: invalid URI")

// Parse decodes a federation-shaped URI. The two accepted forms are:
//
//	local://<kind>/<uuid>
//	<instance>://<kind>/<uuid>   (e.g. pulse.example.com://posts/<uuid>)
//
// v1 always emits local://; v2 adds the instance-named form.
func Parse(uri string) (*Ref, error) {
	idx := strings.Index(uri, "://")
	if idx < 0 {
		return nil, ErrInvalidURI
	}
	authority := uri[:idx]
	rest := uri[idx+3:]
	parts := strings.SplitN(rest, "/", 2)
	if len(parts) != 2 {
		return nil, ErrInvalidURI
	}
	kind := parts[0]
	id, _, err := ids.ParseAny(parts[1])
	if err != nil {
		return nil, fmt.Errorf("%w: bad id: %v", ErrInvalidURI, err)
	}
	if authority == "" || kind == "" {
		return nil, ErrInvalidURI
	}
	return &Ref{
		IsLocal:  authority == LocalScheme,
		Instance: authoritySafe(authority),
		Kind:     kind,
		ID:       id,
	}, nil
}

func authoritySafe(a string) string {
	if a == LocalScheme {
		return ""
	}
	return a
}

// Format produces a federation-shaped URI from its parts. Use
// LocalScheme for local refs; pass the instance host directly for
// remote ones.
func Format(authority, kind string, id int64) string {
	return fmt.Sprintf("%s://%s/%s", authority, kind, ids.FormatID(id))
}

// Authority describes who can authoritatively answer perm questions
// about a Ref. v1 always returns LocalAuthority; v2 will distinguish
// "remote authoritative — go ask the home instance" from
// "local mirror, may serve stale data".
type Authority int

const (
	// LocalAuthority means we can evaluate perms locally.
	LocalAuthority Authority = iota
	// RemoteAuthority means the home instance owns the truth and
	// must be consulted. v1 never returns this; v2 handlers do.
	RemoteAuthority
)

// AuthorityResolver decides which authority answers for a Ref. v1
// implementations are single-instance and always return Local.
//
// Why a Resolver and not a function: dependency-injection so v2 can
// substitute in a network-aware implementation without callers changing.
type AuthorityResolver interface {
	Resolve(ref *Ref) Authority
}

// LocalOnlyResolver is the v1 default: every ref is local.
type LocalOnlyResolver struct{}

func (LocalOnlyResolver) Resolve(_ *Ref) Authority { return LocalAuthority }
