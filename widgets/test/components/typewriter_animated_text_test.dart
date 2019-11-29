import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_widgets/components/typewriter_animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TypewriterAnimatedTextWrapper extends StatelessWidget {
  const TypewriterAnimatedTextWrapper(this._text, this._durationSeconds);

  final List<String> _text;

  final int _durationSeconds;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TypewriterAnimatedTextTest',
      home: TypewriterAnimatedText(
          text: _text, durationSeconds: _durationSeconds),
    );
  }
}

void main() {
  const List<String> text = <String>['TypewriterAnimatedTextTest'];

  const int durationSeconds = 1;

  Widget buildTypewriterAnimatedText(List<String> text, int durationSeconds) =>
      TypewriterAnimatedTextWrapper(text, durationSeconds);

  group('constructor', () {
    test('null text throws error', () {
      try {
        TypewriterAnimatedText(text: null, durationSeconds: durationSeconds);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null durationSeconds throws error', () {
      try {
        TypewriterAnimatedText(text: text, durationSeconds: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets('builds widget with text and durationSeconds',
      (WidgetTester tester) async {
    final WidgetPredicate typewriterAnimatedTextKit = (Widget widget) =>
        widget is TypewriterAnimatedTextKit &&
        widget.duration == Duration(seconds: durationSeconds);

    await tester.pumpWidget(buildTypewriterAnimatedText(text, durationSeconds));

    await tester.pump();

    expect(find.byType(TypewriterAnimatedText), findsOneWidget);
    expect(find.byWidgetPredicate(typewriterAnimatedTextKit), findsOneWidget);
  });
}
