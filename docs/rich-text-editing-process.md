# Markdown Editing Process

Pulse treats authored content as one canonical body string:

- Backend tables store `posts.body`, `comments.body`, and `messages.body` as `TEXT`.
- GraphQL exposes those fields as `String!`.
- Search, redaction, offline drafts, optimistic responses, caches, and chat promotion already flow through that body string.

Markdown should use that existing contract. The body string is Markdown, not a separate rich-text document.

## Contract

- Canonical storage: CommonMark-style Markdown in the existing `body` fields.
- API shape: keep `body: String!` for posts, comments, and messages.
- Rendering: clients render Markdown where body content is displayed.
- Editing: users can switch between raw Markdown and a rendered rich preview.
- Fallback: if Markdown rendering fails or is unavailable, the raw body string remains readable.

The first supported syntax set is intentionally small:

- Paragraphs and soft line breaks.
- Headings.
- Bold and italic.
- Inline code and fenced code blocks.
- Bulleted and numbered lists.
- Blockquotes.
- Links with allowed URL schemes.

Do not support raw HTML, arbitrary embeds, tables, task lists, images, or custom Pulse directives in the first pass.

## Frontend Process

1. Add one shared Markdown renderer for post bodies, comment bodies, and chat messages.
2. Add one shared Markdown composer that owns a `TextEditingController` and can switch between raw Markdown and rendered preview.
3. Convert `PostComposer`, `CommentComposer`, and the chat composer to use the shared composer.
4. Keep submits, optimistic responses, drafts, and outbox payloads writing the same body string.
5. Add a follow-up spike for a true WYSIWYG Markdown editor if preview mode is not enough.

Package guidance:

- Use `flutter_markdown_plus` for maintained read-only Markdown rendering.
- Spike `super_editor` separately for WYSIWYG Markdown editing because it can import/export Markdown and supports Markdown-as-you-type behavior, but it has a larger integration surface.

## Backend Process

The backend keeps the existing `body` contract. Any Markdown-specific backend work should be additive:

- Search continues to index `body`; Markdown punctuation is acceptable in the first pass.
- Redaction replaces `body` with the existing redaction string.
- Mention extraction continues from the raw Markdown body until explicit mention tokens are introduced.
- Chat promotion copies the message body Markdown into the promoted post body.

Future backend hardening can add Markdown normalization, URL scheme validation, and derived preview text if needed.

## Test Gates

Frontend tests:

- Markdown body renders emphasis, lists, code, blockquotes, and links.
- Raw Markdown mode preserves the exact body string.
- Switching to rich preview does not mutate composer text.
- Post, comment, and chat submission still send `body` as a string.
- Existing draft and outbox tests continue to pass.

Backend tests:

- Existing post/comment/message tests continue to pass with Markdown body strings.
- Search still finds text inside Markdown-formatted content.
- Redaction still clears Markdown-formatted bodies.
- Chat promotion preserves Markdown body text.

Manual QA:

- Compose and render Markdown in posts, comments, and chat.
- Toggle raw/preview repeatedly before submitting.
- Paste Markdown copied from GitHub and Slack.
- Verify long lists, code blocks, and blockquotes do not overflow mobile layouts.
