import 'package:flash_chat_widgets/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class InputFieldWrapper extends StatelessWidget {
  const InputFieldWrapper(
      this._keyboardType, this._onChanged, this._obscureText, this._hintText);

  final TextInputType _keyboardType;

  final Function _onChanged;

  final bool _obscureText;

  final String _hintText;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InputFieldTest',
      home: Material(
        child: InputField(
            keyboardType: _keyboardType,
            onChanged: _onChanged,
            obscureText: _obscureText,
            hintText: _hintText),
      ),
    );
  }
}

void main() {
  const TextInputType keyboardType = TextInputType.text;

  const String hintText = 'InputFieldTestHintText';

  String wasChanged;

  final Function onChanged = (String v) {
    wasChanged = v;
  };

  Widget buildInputField(TextInputType keyboardType, Function onChanged,
          bool obscureText, String hintText) =>
      InputFieldWrapper(keyboardType, onChanged, obscureText, hintText);

  group('constructor', () {
    test('null keyboardType throws error', () {
      try {
        InputField(
            keyboardType: null,
            onChanged: onChanged,
            obscureText: true,
            hintText: hintText);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null onChanged throws error', () {
      try {
        InputField(
            keyboardType: keyboardType,
            onChanged: null,
            obscureText: true,
            hintText: hintText);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null onChanged throws error', () {
      try {
        InputField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            obscureText: null,
            hintText: hintText);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null hintText throws error', () {
      try {
        InputField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            obscureText: true,
            hintText: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets(
      'builds widget with keyboardType, onChanged, false obscureText and hintText',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(buildInputField(keyboardType, onChanged, false, hintText));

    await tester.pump();

    expect(find.byType(InputField), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text(hintText), findsOneWidget);
  });

  testWidgets(
      'builds widget with keyboardType, onChanged, true obscureText and hintText',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(buildInputField(keyboardType, onChanged, true, hintText));

    await tester.pump();

    expect(find.byType(InputField), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text(hintText), findsOneWidget);
  });

  testWidgets('input calls onChanged', (WidgetTester tester) async {
    const String testInput = 'InputFieldTest';

    await tester
        .pumpWidget(buildInputField(keyboardType, onChanged, true, hintText));

    await tester.pump();

    await tester.enterText(find.byType(TextField), testInput);

    await tester.pump();

    assert(wasChanged == testInput);
  });
}
