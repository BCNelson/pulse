package ids

import (
	"database/sql/driver"
	"encoding/json"
	"fmt"
)

// Per-entity typed ID wrappers. Each wraps int64 under the hood so it
// scans/values transparently against bigint columns via pgx/database-sql,
// but the distinct named type prevents passing a PostID where a CommentID
// is expected. JSON marshaling renders the wire form (12-char Crockford
// string); JSON unmarshaling accepts the wire form and asserts the kind.
//
// Resolvers build GraphQL model structs by calling ids.FormatID(id); arguments
// arriving as strings should be validated with ids.ParseAs(KindFoo, raw)
// and then handled as int64 within the DB layer (or wrapped in the
// per-entity type as needed).

type (
	PostID          int64
	CommentID       int64
	TagID           int64
	RoomID          int64
	UserID          int64
	TaskID          int64
	MessageID       int64
	ImpersonationID int64
	NotificationID  int64
	JobID           int64
	SessionID       int64
	DeviceID        int64
	AttachmentID    int64
	WorkspaceID     int64
)

// String returns the 12-char wire form. Implemented per type so callers
// get type safety at the call site.
func (p PostID) String() string          { return FormatID(int64(p)) }
func (p CommentID) String() string       { return FormatID(int64(p)) }
func (p TagID) String() string           { return FormatID(int64(p)) }
func (p RoomID) String() string          { return FormatID(int64(p)) }
func (p UserID) String() string          { return FormatID(int64(p)) }
func (p TaskID) String() string          { return FormatID(int64(p)) }
func (p MessageID) String() string       { return FormatID(int64(p)) }
func (p ImpersonationID) String() string { return FormatID(int64(p)) }
func (p NotificationID) String() string  { return FormatID(int64(p)) }
func (p JobID) String() string           { return FormatID(int64(p)) }
func (p SessionID) String() string       { return FormatID(int64(p)) }
func (p DeviceID) String() string        { return FormatID(int64(p)) }
func (p AttachmentID) String() string    { return FormatID(int64(p)) }
func (p WorkspaceID) String() string     { return FormatID(int64(p)) }

// Kind reports the entity kind that the typed ID represents.
func (PostID) Kind() Kind          { return KindPost }
func (CommentID) Kind() Kind       { return KindComment }
func (TagID) Kind() Kind           { return KindTag }
func (RoomID) Kind() Kind          { return KindRoom }
func (UserID) Kind() Kind          { return KindUser }
func (TaskID) Kind() Kind          { return KindTask }
func (MessageID) Kind() Kind       { return KindMessage }
func (ImpersonationID) Kind() Kind { return KindImpersonation }
func (NotificationID) Kind() Kind  { return KindNotification }
func (JobID) Kind() Kind           { return KindJob }
func (SessionID) Kind() Kind       { return KindSession }
func (DeviceID) Kind() Kind        { return KindDevice }
func (AttachmentID) Kind() Kind    { return KindAttachment }
func (WorkspaceID) Kind() Kind     { return KindWorkspace }

// MarshalJSON / UnmarshalJSON: wire form on the wire.
//
// JSON-side serialization defers to a shared helper so each method body
// stays a one-liner — the only knob per type is which Kind to assert.

func (p PostID) MarshalJSON() ([]byte, error)          { return marshalIDJSON(int64(p)) }
func (p CommentID) MarshalJSON() ([]byte, error)       { return marshalIDJSON(int64(p)) }
func (p TagID) MarshalJSON() ([]byte, error)           { return marshalIDJSON(int64(p)) }
func (p RoomID) MarshalJSON() ([]byte, error)          { return marshalIDJSON(int64(p)) }
func (p UserID) MarshalJSON() ([]byte, error)          { return marshalIDJSON(int64(p)) }
func (p TaskID) MarshalJSON() ([]byte, error)          { return marshalIDJSON(int64(p)) }
func (p MessageID) MarshalJSON() ([]byte, error)       { return marshalIDJSON(int64(p)) }
func (p ImpersonationID) MarshalJSON() ([]byte, error) { return marshalIDJSON(int64(p)) }
func (p NotificationID) MarshalJSON() ([]byte, error)  { return marshalIDJSON(int64(p)) }
func (p JobID) MarshalJSON() ([]byte, error)           { return marshalIDJSON(int64(p)) }
func (p SessionID) MarshalJSON() ([]byte, error)       { return marshalIDJSON(int64(p)) }
func (p DeviceID) MarshalJSON() ([]byte, error)        { return marshalIDJSON(int64(p)) }
func (p AttachmentID) MarshalJSON() ([]byte, error)    { return marshalIDJSON(int64(p)) }
func (p WorkspaceID) MarshalJSON() ([]byte, error)     { return marshalIDJSON(int64(p)) }

func (p *PostID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindPost, b, (*int64)(p))
}
func (p *CommentID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindComment, b, (*int64)(p))
}
func (p *TagID) UnmarshalJSON(b []byte) error { return unmarshalIDJSON(KindTag, b, (*int64)(p)) }
func (p *RoomID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindRoom, b, (*int64)(p))
}
func (p *UserID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindUser, b, (*int64)(p))
}
func (p *TaskID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindTask, b, (*int64)(p))
}
func (p *MessageID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindMessage, b, (*int64)(p))
}
func (p *ImpersonationID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindImpersonation, b, (*int64)(p))
}
func (p *NotificationID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindNotification, b, (*int64)(p))
}
func (p *JobID) UnmarshalJSON(b []byte) error { return unmarshalIDJSON(KindJob, b, (*int64)(p)) }
func (p *SessionID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindSession, b, (*int64)(p))
}
func (p *DeviceID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindDevice, b, (*int64)(p))
}
func (p *AttachmentID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindAttachment, b, (*int64)(p))
}
func (p *WorkspaceID) UnmarshalJSON(b []byte) error {
	return unmarshalIDJSON(KindWorkspace, b, (*int64)(p))
}

// Value satisfies database/sql/driver.Valuer so typed IDs flow through
// pgx and database/sql without callers needing explicit casts.
func (p PostID) Value() (driver.Value, error)          { return int64(p), nil }
func (p CommentID) Value() (driver.Value, error)       { return int64(p), nil }
func (p TagID) Value() (driver.Value, error)           { return int64(p), nil }
func (p RoomID) Value() (driver.Value, error)          { return int64(p), nil }
func (p UserID) Value() (driver.Value, error)          { return int64(p), nil }
func (p TaskID) Value() (driver.Value, error)          { return int64(p), nil }
func (p MessageID) Value() (driver.Value, error)       { return int64(p), nil }
func (p ImpersonationID) Value() (driver.Value, error) { return int64(p), nil }
func (p NotificationID) Value() (driver.Value, error)  { return int64(p), nil }
func (p JobID) Value() (driver.Value, error)           { return int64(p), nil }
func (p SessionID) Value() (driver.Value, error)       { return int64(p), nil }
func (p DeviceID) Value() (driver.Value, error)        { return int64(p), nil }
func (p AttachmentID) Value() (driver.Value, error)    { return int64(p), nil }
func (p WorkspaceID) Value() (driver.Value, error)     { return int64(p), nil }

func marshalIDJSON(n int64) ([]byte, error) {
	return json.Marshal(FormatID(n))
}

func unmarshalIDJSON(expected Kind, b []byte, dst *int64) error {
	var s string
	if err := json.Unmarshal(b, &s); err != nil {
		return fmt.Errorf("ids: unmarshal: %w", err)
	}
	n, err := ParseAs(expected, s)
	if err != nil {
		return err
	}
	*dst = n
	return nil
}
