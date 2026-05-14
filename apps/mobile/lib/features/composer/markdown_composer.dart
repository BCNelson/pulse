import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/services.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_quill/markdown_quill.dart';

import '../../design/atoms/pulse_segmented.dart';
import '../../design/tokens.dart';

enum MarkdownComposerMode { markdown, rich }

class MarkdownComposer extends StatefulWidget {
  const MarkdownComposer({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.minLines = 1,
    this.maxLines,
    this.autofocus = false,
    this.onSubmitted,
    this.textStyle,
    this.contentPadding = const EdgeInsets.fromLTRB(8, 10, 8, 10),
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final int minLines;
  final int? maxLines;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry contentPadding;

  @override
  State<MarkdownComposer> createState() => _MarkdownComposerState();
}

class _MarkdownComposerState extends State<MarkdownComposer> {
  MarkdownComposerMode _mode = MarkdownComposerMode.markdown;
  final _markdownToDelta = MarkdownToDelta(markdownDocument: md.Document());
  final _deltaToMarkdown = DeltaToMarkdown();
  late final QuillController _richController;
  late final FocusNode _richFocusNode;
  late final ScrollController _richScrollController;
  late String _richMarkdown;
  bool _syncingFromRich = false;
  bool _syncingRichFromMarkdown = false;

  @override
  void initState() {
    super.initState();
    _richMarkdown = widget.controller.text;
    _richController = _buildQuillController(_richMarkdown)
      ..addListener(_onRichTextChanged);
    _richFocusNode = FocusNode();
    _richScrollController = ScrollController();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant MarkdownComposer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == widget.controller) return;
    oldWidget.controller.removeListener(_onTextChanged);
    widget.controller.addListener(_onTextChanged);
    _syncRichFromMarkdown(widget.controller.text);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleMarkdownKeyEvent);
    widget.controller.removeListener(_onTextChanged);
    _richController.removeListener(_onRichTextChanged);
    _richController.dispose();
    _richFocusNode.dispose();
    _richScrollController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (!_syncingFromRich) {
      _syncRichFromMarkdown(widget.controller.text);
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final previewText = widget.controller.text.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [_buildEditorFrame(context, t, previewText)],
    );
  }

  Widget _buildEditorFrame(
    BuildContext context,
    PulseTokens t,
    String markdown,
  ) {
    final editorHeight = _editorHeight(context);
    return Container(
      key: const Key('markdown-composer-editor-frame'),
      height: editorHeight,
      color: t.paper,
      child: Column(
        children: [
          _EditorToolbar(
            mode: _mode,
            onModeChanged: (mode) {
              setState(() => _mode = mode);
              if (mode == MarkdownComposerMode.markdown) {
                widget.focusNode?.requestFocus();
              } else {
                _richFocusNode.requestFocus();
              }
            },
            controller:
                _mode == MarkdownComposerMode.rich ? _richController : null,
            focusNode:
                _mode == MarkdownComposerMode.rich ? _richFocusNode : null,
          ),
          Divider(height: 1, color: t.hair2),
          Expanded(
            child: _mode == MarkdownComposerMode.markdown
                ? _buildTextField(t)
                : _buildRichEditor(markdown),
          ),
        ],
      ),
    );
  }

  static const double _toolbarHeight = 30;

  Widget _buildRichEditor(
    String markdown,
  ) {
    return _QuillMarkdownEditor(
      controller: _richController,
      focusNode: _richFocusNode,
      scrollController: _richScrollController,
      hintText: widget.hintText,
      padding: widget.contentPadding,
    );
  }

  Widget _buildTextField(PulseTokens t) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      style: widget.textStyle ?? TextStyle(fontSize: 12, color: t.ink),
      expands: true,
      minLines: null,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: t.ink3, fontSize: 12),
        isCollapsed: true,
        border: InputBorder.none,
        contentPadding: widget.contentPadding,
      ),
    );
  }

  bool _handleMarkdownKeyEvent(KeyEvent event) => false;

  QuillController _buildQuillController(String markdown) {
    return QuillController(
      document: markdown.trim().isEmpty
          ? Document()
          : Document.fromDelta(_markdownToDelta.convert(markdown)),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  void _syncRichFromMarkdown(String markdown) {
    if (markdown == _richMarkdown) return;
    _richMarkdown = markdown;
    final nextDocument = markdown.trim().isEmpty
        ? Document()
        : Document.fromDelta(_markdownToDelta.convert(markdown));
    _syncingRichFromMarkdown = true;
    try {
      _richController.document = nextDocument;
    } finally {
      _syncingRichFromMarkdown = false;
    }
  }

  void _onRichTextChanged() {
    if (_syncingRichFromMarkdown) return;
    final markdown = _deltaToMarkdown
        .convert(_richController.document.toDelta())
        .trimRight();
    _richMarkdown = markdown;
    if (markdown == widget.controller.text) return;
    _syncingFromRich = true;
    widget.controller.value = widget.controller.value.copyWith(
      text: markdown,
      selection: TextSelection.collapsed(offset: markdown.length),
      composing: TextRange.empty,
    );
    _syncingFromRich = false;
  }

  double _lineHeight(BuildContext context) {
    final style = widget.textStyle ?? Theme.of(context).textTheme.bodyMedium;
    final fontSize = style?.fontSize ?? 13;
    final height = style?.height ?? 1.4;
    return fontSize * height + 16;
  }

  double _editorHeight(BuildContext context) {
    final lineHeight = _lineHeight(context);
    final contentHeight = widget.maxLines == null
        ? 160.0
        : (lineHeight * widget.maxLines!).clamp(56, 160).toDouble();
    return _toolbarHeight + 1 + contentHeight;
  }
}

class _QuillMarkdownEditor extends StatelessWidget {
  const _QuillMarkdownEditor({
    required this.controller,
    required this.focusNode,
    required this.scrollController,
    required this.hintText,
    required this.padding,
  });

  final QuillController controller;
  final FocusNode focusNode;
  final ScrollController scrollController;
  final String hintText;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      children: [
        Expanded(
          child: QuillEditor(
            controller: controller,
            focusNode: focusNode,
            scrollController: scrollController,
            config: QuillEditorConfig(
              placeholder: hintText,
              padding: padding,
              customStyles: DefaultStyles(
                paragraph: DefaultTextBlockStyle(
                  TextStyle(fontSize: 12, height: 1.35, color: t.ink),
                  const HorizontalSpacing(0, 0),
                  const VerticalSpacing(0, 0),
                  const VerticalSpacing(0, 0),
                  null,
                ),
                placeHolder: DefaultTextBlockStyle(
                  TextStyle(fontSize: 12, height: 1.35, color: t.ink3),
                  const HorizontalSpacing(0, 0),
                  const VerticalSpacing(0, 0),
                  const VerticalSpacing(0, 0),
                  null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EditorToolbar extends StatelessWidget {
  const _EditorToolbar({
    required this.mode,
    required this.onModeChanged,
    required this.controller,
    required this.focusNode,
  });

  final MarkdownComposerMode mode;
  final ValueChanged<MarkdownComposerMode> onModeChanged;
  final QuillController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final controller = this.controller;
    return Container(
      height: 30,
      color: t.paper2,
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (mode == MarkdownComposerMode.rich) ...[
                    _QuillToolButton(
                      tooltip: 'Bold',
                      icon: Icons.format_bold,
                      onPressed: controller == null
                          ? null
                          : () => _format(Attribute.bold),
                    ),
                    _QuillToolButton(
                      tooltip: 'Italic',
                      icon: Icons.format_italic,
                      onPressed: controller == null
                          ? null
                          : () => _format(Attribute.italic),
                    ),
                    _QuillToolButton(
                      tooltip: 'Inline code',
                      icon: Icons.code,
                      onPressed: controller == null
                          ? null
                          : () => _format(Attribute.inlineCode),
                    ),
                    _QuillToolButton(
                      tooltip: 'Link',
                      icon: Icons.link,
                      onPressed: controller == null
                          ? null
                          : () => _format(const LinkAttribute('https://')),
                    ),
                    _QuillToolButton(
                      tooltip: 'Bulleted list',
                      icon: Icons.format_list_bulleted,
                      onPressed: controller == null
                          ? null
                          : () => _format(Attribute.ul),
                    ),
                    _QuillToolButton(
                      tooltip: 'Numbered list',
                      icon: Icons.format_list_numbered,
                      onPressed: controller == null
                          ? null
                          : () => _format(Attribute.ol),
                    ),
                    _QuillToolButton(
                      tooltip: 'Quote',
                      icon: Icons.format_quote,
                      onPressed: controller == null
                          ? null
                          : () => _format(Attribute.blockQuote),
                    ),
                    _QuillToolButton(
                      tooltip: 'Code block',
                      icon: Icons.data_object,
                      onPressed: controller == null
                          ? null
                          : () => _format(Attribute.codeBlock),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 2),
            child: PulseSegmented<MarkdownComposerMode>(
              options: MarkdownComposerMode.values,
              selected: mode,
              onChanged: onModeChanged,
              labelOf: (mode) => switch (mode) {
                MarkdownComposerMode.markdown => 'MD',
                MarkdownComposerMode.rich => 'RICH',
              },
            ),
          ),
        ],
      ),
    );
  }

  void _format(Attribute<dynamic> attribute) {
    controller?.formatSelection(attribute);
    focusNode?.requestFocus();
  }
}

class _QuillToolButton extends StatelessWidget {
  const _QuillToolButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return IconButton(
      tooltip: tooltip,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints.tightFor(width: 30, height: 28),
      onPressed: onPressed,
      icon: Icon(icon, size: 16, color: t.ink2),
    );
  }
}
