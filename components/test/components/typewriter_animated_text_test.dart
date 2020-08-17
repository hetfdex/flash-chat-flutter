import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:components/components/typewriter_animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TypewriterAnimatedTextWrapper extends StatelessWidget {
  const TypewriterAnimatedTextWrapper({
    this.text,
    this.durationSeconds,
    this.textStyle,
  });

  final List<String> text;

  final TextStyle textStyle;

  final int durationSeconds;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TypewriterAnimatedTextTest',
      home: TypewriterAnimatedText(
        text: text,
        textStyle: textStyle,
        durationSeconds: durationSeconds,
      ),
    );
  }
}

void main() {
  const text = <String>['text'];

  const textStyle = TextStyle(color: Colors.red);

  const durationSeconds = 1;

  const durationPause = Duration(seconds: 0);

  isCorrectTextStyle(Widget widget) =>
      widget is Text && widget.style == textStyle;

  isCorrectDurationSeconds(Widget widget) =>
      widget is TypewriterAnimatedTextKit &&
      widget.speed == Duration(seconds: durationSeconds);

  isCorrectText(Widget widget) =>
      widget is TypewriterAnimatedTextKit && widget.text == text;

  isCorrectPause(Widget widget) =>
      widget is TypewriterAnimatedTextKit && widget.pause == durationPause;

  isCorrectRepeatForever(Widget widget) =>
      widget is TypewriterAnimatedTextKit && widget.repeatForever == true;

  Widget buildTypewriterAnimatedText() => TypewriterAnimatedTextWrapper(
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

    test('null textStyle throws error', () {
      expect(
          () => TypewriterAnimatedText(
              text: text, durationSeconds: durationSeconds, textStyle: null),
          throwsAssertionError);
    });
  });

  testWidgets('builds widget', (tester) async {
    await tester.pumpWidget(buildTypewriterAnimatedText());

    await tester.pump();

    expect(find.byType(TypewriterAnimatedText), findsOneWidget);
    expect(find.byWidgetPredicate(isCorrectText), findsOneWidget);
    expect(find.byWidgetPredicate(isCorrectDurationSeconds), findsOneWidget);
    expect(find.byWidgetPredicate(isCorrectTextStyle), findsOneWidget);
    expect(find.byWidgetPredicate(isCorrectRepeatForever), findsOneWidget);
    expect(find.byWidgetPredicate(isCorrectPause), findsOneWidget);
  });
}
