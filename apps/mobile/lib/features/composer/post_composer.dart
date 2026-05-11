import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/outbox.dart';
import '../../design/atoms/pulse_button.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
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
      final db = ref.read(outboxDatabaseProvider);
      await db.enqueue('createPost', {
        'tagId': widget.tagId,
        'title': _title.text.trim(),
        'body': _body.text.trim(),
      });
      if (!mounted) return;
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('saved to outbox — will retry when online')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      color: t.paper,
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: t.ink,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: 1,
              child: Text(
                'NEW POST',
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 9.5,
                  color: t.paper,
                  letterSpacing: 0.10 * 9.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _title,
            autofocus: true,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: t.ink),
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: t.ink3,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: false,
              isCollapsed: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 6),
            ),
          ),
          Divider(height: 1, color: t.hair2),
          const SizedBox(height: 8),
          TextField(
            controller: _body,
            maxLines: 6,
            style: TextStyle(fontSize: 13, color: t.ink, height: 1.5),
            decoration: InputDecoration(
              hintText: 'Body…',
              hintStyle: TextStyle(fontSize: 13, color: t.ink3),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: false,
              isCollapsed: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 6),
            ),
          ),
          const SizedBox(height: 12),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _error!,
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 11,
                  color: t.amberInk,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PulseButton(
                label: 'Cancel',
                variant: PulseButtonVariant.ghost,
                onPressed: _busy ? null : () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 8),
              PulseButton(
                label: _busy ? 'Posting…' : 'Post',
                variant: PulseButtonVariant.primary,
                onPressed: _busy ? null : _submit,
                kbdHint: '⌘↩',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
