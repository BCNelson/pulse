package mentions_test

import (
	"reflect"
	"testing"

	"github.com/bcnelson/pulse/services/api/internal/mentions"
)

func TestExtractUsers(t *testing.T) {
	tests := []struct {
		name string
		body string
		want []string
	}{
		{
			name: "single canonical mention",
			body: "hi [@alice](pulse-user:alice) welcome",
			want: []string{"alice"},
		},
		{
			name: "multiple, deduped, order preserved",
			body: "hey [@alice](pulse-user:alice) and [@bob](pulse-user:bob) and [@alice](pulse-user:alice)",
			want: []string{"alice", "bob"},
		},
		{
			name: "case insensitive — lowered",
			body: "see [@Alice](pulse-user:Alice)",
			want: []string{"alice"},
		},
		{
			name: "bare @foo is not a mention",
			body: "hi @alice — see you later",
			want: nil,
		},
		{
			name: "email not extracted",
			body: "ping me@example.com please",
			want: nil,
		},
		{
			name: "wrong scheme not extracted",
			body: "[@alice](https://example.com/u/alice)",
			want: nil,
		},
		{
			name: "label decoupled from slug",
			body: "see [@Alice Cooper](pulse-user:alice)",
			want: []string{"alice"},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := mentions.ExtractUsers(tt.body)
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("ExtractUsers(%q):\n got=%v\nwant=%v", tt.body, got, tt.want)
			}
		})
	}
}

func TestExtractTagPaths(t *testing.T) {
	tests := []struct {
		name string
		body string
		want [][]string
	}{
		{
			name: "single segment",
			body: "filed under [#eng](pulse-tag:eng)",
			want: [][]string{{"eng"}},
		},
		{
			name: "nested path",
			body: "see [#eng/backend](pulse-tag:eng/backend)",
			want: [][]string{{"eng", "backend"}},
		},
		{
			name: "multiple deduped",
			body: "[#a](pulse-tag:a) [#b](pulse-tag:b) [#a](pulse-tag:a)",
			want: [][]string{{"a"}, {"b"}},
		},
		{
			name: "case lowered",
			body: "see [#Eng/Backend](pulse-tag:Eng/Backend)",
			want: [][]string{{"eng", "backend"}},
		},
		{
			name: "bare #foo not extracted",
			body: "filed under #eng",
			want: nil,
		},
		{
			name: "url fragment not extracted",
			body: "see https://example.com/page#frag for details",
			want: nil,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := mentions.ExtractTagPaths(tt.body)
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("ExtractTagPaths(%q):\n got=%v\nwant=%v", tt.body, got, tt.want)
			}
		})
	}
}

func TestExtractMixed(t *testing.T) {
	body := "ping [@alice](pulse-user:alice) re [#eng/backend](pulse-tag:eng/backend)"
	users := mentions.ExtractUsers(body)
	tags := mentions.ExtractTagPaths(body)
	if !reflect.DeepEqual(users, []string{"alice"}) {
		t.Errorf("users: %v", users)
	}
	if !reflect.DeepEqual(tags, [][]string{{"eng", "backend"}}) {
		t.Errorf("tags: %v", tags)
	}
}
