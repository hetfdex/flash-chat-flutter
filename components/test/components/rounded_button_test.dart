import 'package:components/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class RoundedButtonWrapper extends StatelessWidget {
  const RoundedButtonWrapper({this.onPressed, this.text, this.color});

  final Function onPressed;

  final String text;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoundedButtonTest',
      home: RoundedButton(onPressed: onPressed, text: text, color: color),
    );
  }
}

void main() {
  const text = 'text';

  const color = Colors.white;

  var wasPressed = false;

  onPressed() => wasPressed = true;

  Widget buildRoundedButton() =>
      RoundedButtonWrapper(onPressed: onPressed, text: text, color: color);

  group('constructor', () {
    test('null onPressed throws error', () {
      expect(() => RoundedButton(onPressed: null, text: text, color: color),
          throwsAssertionError);
    });

    test('null text throws error', () {
      expect(
          () => RoundedButton(onPressed: onPressed, text: null, color: color),
          throwsAssertionError);
    });

    test('null color throws error', () {
      expect(() => RoundedButton(onPressed: onPressed, text: text, color: null),
          throwsAssertionError);
    });
  });

  testWidgets('builds widget', (WidgetTester tester) async {
    isCorrectColor(Widget widget) =>
        widget is Material && widget.color == color;

    await tester.pumpWidget(buildRoundedButton());

    await tester.pump();

    expect(find.byType(RoundedButton), findsOneWidget);
    expect(find.text(text), findsOneWidget);
    expect(find.byWidgetPredicate(isCorrectColor), findsOneWidget);
  });

  testWidgets('button tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildRoundedButton());

    await tester.pump();

    await tester.tap(find.byType(RoundedButton));

    await tester.pump();

    expect(wasPressed, true);
  });
}
