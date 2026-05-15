package ids

// Kind is the entity-kind tag carried in the top 5 bits of every ID. Each
// registered kind's index is the Crockford-base32 value of its kind letter,
// so the first character of any encoded ID is the kind letter itself.
//
// Unregistered indices (0..9, 11, 14..17, 23, 29..31) are reserved for
// future entity kinds; Parse rejects them.
type Kind uint8

const (
	KindAttachment    Kind = 10 // 'A'
	KindComment       Kind = 12 // 'C'
	KindDevice        Kind = 13 // 'D'
	KindMessage       Kind = 16 // 'G' — chat messaGe ('M' is taken by Impersonation)
	KindJob           Kind = 18 // 'J'
	KindTask          Kind = 19 // 'K' — taK; T is taken by Tag
	KindImpersonation Kind = 20 // 'M' — iMpersonation
	KindNotification  Kind = 21 // 'N'
	KindPost          Kind = 22 // 'P'
	KindRoom          Kind = 24 // 'R'
	KindSession       Kind = 25 // 'S'
	KindTag           Kind = 26 // 'T'
	KindUser          Kind = 27 // 'V' — Crockford excludes U
	KindWorkspace     Kind = 28 // 'W'
)

// kindNames maps registered Kind values to their plural URI segment used
// in globalUri (`local://posts/...`, `local://tags/...`).
var kindNames = map[Kind]string{
	KindAttachment:    "attachments",
	KindComment:       "comments",
	KindDevice:        "devices",
	KindMessage:       "messages",
	KindJob:           "jobs",
	KindTask:          "tasks",
	KindImpersonation: "impersonations",
	KindNotification:  "notifications",
	KindPost:          "posts",
	KindRoom:          "chat_rooms",
	KindSession:       "sessions",
	KindTag:           "tags",
	KindUser:          "principals",
	KindWorkspace:     "workspaces",
}

// IsRegistered reports whether k is one of the known entity kinds. Parse
// uses this to reject IDs whose first letter is a Crockford char that
// hasn't been assigned to any entity.
func (k Kind) IsRegistered() bool {
	_, ok := kindNames[k]
	return ok
}

// Letter returns the single uppercase Crockford char that every encoded ID
// of this kind begins with. Panics for unregistered kinds — callers should
// only pass values from the Kind constants above.
func (k Kind) Letter() byte {
	if !k.IsRegistered() {
		panic("ids: Letter() called on unregistered kind")
	}
	return alphabet[k]
}

// Name returns the plural URI segment for k (`posts`, `tags`, …). Panics
// for unregistered kinds.
func (k Kind) Name() string {
	name, ok := kindNames[k]
	if !ok {
		panic("ids: Name() called on unregistered kind")
	}
	return name
}
