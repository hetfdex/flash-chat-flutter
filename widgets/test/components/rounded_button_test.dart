import 'package:flash_chat_widgets/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class RoundedButtonWrapper extends StatelessWidget {
  const RoundedButtonWrapper(this._onPressed, this._text, this._color);

  final Function _onPressed;

  final String _text;

  final Color _color;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoundedButtonTest',
      home: RoundedButton(onPressed: _onPressed, text: _text, color: _color),
    );
  }
}

void main() {
  const String text = 'RoundedButtonTest';

  const Color color = Colors.white;

  bool wasPressed = false;

  final Function onPressed = () {
    wasPressed = true;
  };

  Widget buildRoundedButton(Function onPressed, String text, Color color) =>
      RoundedButtonWrapper(onPressed, text, color);

  group('constructor', () {
    test('null onPressed throws error', () {
      try {
        RoundedButton(onPressed: null, text: text, color: color);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null id throws error', () {
      try {
        RoundedButton(onPressed: onPressed, text: text, color: color);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null text throws error', () {
      try {
        RoundedButton(onPressed: onPressed, text: null, color: color);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null color throws error', () {
      try {
        RoundedButton(onPressed: onPressed, text: text, color: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets('builds widget with onPressed, id, text and color',
      (WidgetTester tester) async {
    final WidgetPredicate material =
        (Widget widget) => widget is Material && widget.color == color;

    await tester.pumpWidget(buildRoundedButton(onPressed, text, color));

    await tester.pump();

    expect(find.byType(RoundedButton), findsOneWidget);
    expect(find.text(text), findsOneWidget);
    expect(find.byWidgetPredicate(material), findsOneWidget);
  });

  testWidgets('tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildRoundedButton(onPressed, text, color));

    await tester.pump();

    await tester.tap(find.byType(RoundedButton));

    await tester.pump();

    expect(wasPressed, true);
  });
}
