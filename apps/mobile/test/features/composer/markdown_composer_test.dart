import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/design/atoms/pulse_markdown_body.dart';
import 'package:pulse/design/themes.dart';
import 'package:pulse/features/composer/markdown_composer.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: pulseTheme(PulseThemeKey.bone),
      localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(body: child),
    );
  }

  testWidgets('renders markdown body without changing source text',
      (tester) async {
    await tester.pumpWidget(wrap(const PulseMarkdownBody(
      data: '# Heading\n\nThis is **bold** with `code`.',
    )));

    expect(tester.takeException(), isNull);
    expect(find.byType(PulseMarkdownBody), findsOneWidget);
  });

  testWidgets('composer uses an in-place rich editor in rich mode',
      (tester) async {
    final controller = TextEditingController(text: '**hello**');
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(MarkdownComposer(
      controller: controller,
      hintText: 'Body...',
      maxLines: 4,
    )));

    expect(find.text('Markdown body'), findsNothing);

    await tester.tap(find.text('RICH'));
    await tester.pump();

    expect(find.text('Rich Markdown editor'), findsNothing);
    expect(find.byType(QuillEditor), findsOneWidget);
    expect(find.byTooltip('Bold'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.text('**hello**'), findsNothing);
    expect(controller.text, '**hello**');
  });

  testWidgets('composer shows an empty rich editor without raw markdown',
      (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(MarkdownComposer(
      controller: controller,
      hintText: 'Body...',
      maxLines: 4,
    )));

    await tester.tap(find.text('RICH'));
    await tester.pump();

    expect(find.byType(QuillEditor), findsOneWidget);
    expect(find.byTooltip('Bold'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(controller.text, '');
    final editor = tester.widget<QuillEditor>(find.byType(QuillEditor));
    expect(editor.config.padding, const EdgeInsets.fromLTRB(8, 10, 8, 10));
    expect(
      editor.config.customStyles?.placeHolder?.style.fontSize,
      12,
    );
  });

  testWidgets('switching back to markdown shows canonical source',
      (tester) async {
    final controller = TextEditingController(text: '**hello**');
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(MarkdownComposer(
      controller: controller,
      hintText: 'Body...',
      maxLines: 4,
    )));

    await tester.tap(find.text('RICH'));
    await tester.pump();
    await tester.tap(find.text('MD'));
    await tester.pump();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('**hello**'), findsOneWidget);
  });

  testWidgets('markdown and rich modes keep the same editor frame size',
      (tester) async {
    final controller = TextEditingController(text: '**hello**');
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(MarkdownComposer(
      controller: controller,
      hintText: 'Body...',
      maxLines: 4,
    )));

    final mdSize = tester.getSize(
      find.byKey(const Key('markdown-composer-editor-frame')),
    );

    await tester.tap(find.text('RICH'));
    await tester.pump();

    final richSize = tester.getSize(
      find.byKey(const Key('markdown-composer-editor-frame')),
    );

    expect(richSize, mdSize);
  });

  testWidgets('markdown editor supports multiple lines without inner outline',
      (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(MarkdownComposer(
      controller: controller,
      hintText: 'Body...',
      maxLines: 4,
    )));

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(
      field.decoration?.contentPadding,
      const EdgeInsets.fromLTRB(8, 10, 8, 10),
    );
    expect(field.keyboardType, TextInputType.multiline);
    expect(field.textInputAction, TextInputAction.newline);
    expect(field.minLines, isNull);
    expect(field.maxLines, isNull);
    expect(field.expands, isTrue);
    expect(field.onSubmitted, isNull);

    final frame = tester.widget<Container>(
      find.byKey(const Key('markdown-composer-editor-frame')),
    );
    expect(frame.decoration, isNull);
    expect(frame.color, isNotNull);
  });

  testWidgets('markdown editor accepts newline text input', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(MarkdownComposer(
      controller: controller,
      hintText: 'Body...',
      maxLines: 4,
    )));

    await tester.enterText(find.byType(TextField), 'hello\nworld');

    expect(controller.text, 'hello\nworld');
  });

  testWidgets('mode toggle lives in the editor toolbar', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(wrap(MarkdownComposer(
      controller: controller,
      hintText: 'Body...',
      maxLines: 4,
    )));

    final mdToggleTop = tester.getTopLeft(find.text('MD')).dy;

    await tester.tap(find.text('RICH'));
    await tester.pump();

    final richToggleTop = tester.getTopLeft(find.text('MD')).dy;
    final boldTop = tester.getTopLeft(find.byTooltip('Bold')).dy;
    final frameRight = tester
        .getTopRight(find.byKey(const Key('markdown-composer-editor-frame')))
        .dx;
    final toggleRight = tester.getTopRight(find.text('RICH')).dx;

    expect(richToggleTop, mdToggleTop);
    expect((boldTop - richToggleTop).abs() < 4, isTrue);
    expect(frameRight - toggleRight < 24, isTrue);
  });
}
