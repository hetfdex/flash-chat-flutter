import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:components/components/typewriter_animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TypewriterAnimatedTextWrapper extends StatelessWidget {
  const TypewriterAnimatedTextWrapper(
      {this.text, this.durationSeconds, this.textStyle});

  final List<String> text;

  final int durationSeconds;

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TypewriterAnimatedTextTest',
      home: TypewriterAnimatedText(
        text: text,
        durationSeconds: durationSeconds,
        textStyle: textStyle,
      ),
    );
  }
}

void main() {
  const text = <String>['text'];

  const durationSeconds = 1;

  const textStyle = TextStyle(color: Colors.red);

  isCorrectTextStyle(Widget widget) =>
      widget is Text && widget.style == textStyle;

  Widget buildTypewriterAnimatedText(
          {List<String> text, int durationSeconds, TextStyle textStyle}) =>
      TypewriterAnimatedTextWrapper(
          text: text, durationSeconds: durationSeconds, textStyle: textStyle);

  group('constructor', () {
    test('null text throws error', () {
      expect(
          () => TypewriterAnimatedText(
              text: null,
              durationSeconds: durationSeconds,
              textStyle: textStyle),
          throwsAssertionError);
    });

    test('null durationSeconds throws error', () {
      expect(
          () => TypewriterAnimatedText(
              text: text, durationSeconds: null, textStyle: textStyle),
          throwsAssertionError);
    });
  });

  testWidgets('builds widget with text and durationSeconds',
      (WidgetTester tester) async {
    isCorrectDurationSeconds(Widget widget) =>
        widget is TypewriterAnimatedTextKit &&
        widget.duration == Duration(seconds: durationSeconds);

    isCorrectText(Widget widget) =>
        widget is TypewriterAnimatedTextKit && widget.text == text;

    await tester.pumpWidget(buildTypewriterAnimatedText(
        text: text, durationSeconds: durationSeconds));

    await tester.pump();

    expect(find.byType(TypewriterAnimatedText), findsOneWidget);
    expect(find.byWidgetPredicate(isCorrectText), findsOneWidget);
    expect(find.byWidgetPredicate(isCorrectDurationSeconds), findsOneWidget);
    expect(find.byWidgetPredicate(isCorrectTextStyle), findsNothing);
  });

  testWidgets('builds widget with textStyle', (WidgetTester tester) async {
    await tester.pumpWidget(buildTypewriterAnimatedText(
        text: text, durationSeconds: durationSeconds, textStyle: textStyle));

    await tester.pump();

    expect(find.byWidgetPredicate(isCorrectTextStyle), findsOneWidget);
  });
}
