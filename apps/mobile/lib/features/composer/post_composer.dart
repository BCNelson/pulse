import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/outbox.dart';
import '../../graphql/__generated__/schema.schema.gql.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';

class PostComposer extends ConsumerStatefulWidget {
  const PostComposer({super.key, required this.tagId});

  final String tagId;

  @override
  ConsumerState<PostComposer> createState() => _PostComposerState();
}

class _PostComposerState extends ConsumerState<PostComposer> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final client = ref.read(ferryClientProvider);
    final req = GCreatePostReq(
      (b) => b
        ..vars.input.title = _title.text.trim()
        ..vars.input.body = _body.text.trim()
        ..vars.input.tags.add(
          GPostTagInput((tb) => tb..tagId = widget.tagId),
        ),
    );
    try {
      final resp = await client.request(req).first;
      if (!mounted) return;
      if (resp.hasErrors) {
        // Network reachable but GraphQL error — show inline; don't queue.
        setState(() {
          _busy = false;
          _error = resp.graphqlErrors?.map((e) => e.message).join('\n') ??
              resp.linkException?.toString() ??
              'create failed';
        });
        return;
      }
      setState(() => _busy = false);
      Navigator.of(context).pop();
    } catch (e) {
      // Network unreachable / connection blew up — queue for replay.
      final db = ref.read(outboxDatabaseProvider);
      await db.enqueue('createPost', {
        'tagId': widget.tagId,
        'title': _title.text.trim(),
        'body': _body.text.trim(),
      });
      if (!mounted) return;
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved to outbox — will retry when online.')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('New post', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextField(
            controller: _title,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _body,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'Body',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(_error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _busy ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _busy ? null : _submit,
                child: _busy
                    ? const SizedBox(
                        height: 18, width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Post'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
