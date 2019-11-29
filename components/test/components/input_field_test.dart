import 'package:components/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class InputFieldWrapper extends StatelessWidget {
  const InputFieldWrapper(
      {this.keyboardType, this.onChanged, this.obscureText, this.hintText});

  final TextInputType keyboardType;

  final Function onChanged;

  final bool obscureText;

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InputFieldTest',
      home: Material(
        child: InputField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            obscureText: obscureText,
            hintText: hintText),
      ),
    );
  }
}

void main() {
  const keyboardType = TextInputType.text;

  const hintText = 'hintText';

  String wasChanged;

  onChanged(String v) => wasChanged = v;

  Widget buildInputField(
          {TextInputType keyboardType,
          Function onChanged,
          bool obscureText,
          String hintText}) =>
      InputFieldWrapper(
          keyboardType: keyboardType,
          onChanged: onChanged,
          obscureText: obscureText,
          hintText: hintText);

  textIsObscured(Widget widget) => widget is TextField && widget.obscureText;

  textInputTypeIsText(Widget widget) =>
      widget is TextField && widget.keyboardType == keyboardType;

  group('constructor', () {
    test('null keyboardType throws error', () {
      expect(
          () => InputField(
                keyboardType: null,
                onChanged: onChanged,
                obscureText: true,
                hintText: hintText,
              ),
          throwsAssertionError);
    });

    test('null onChanged throws error', () {
      expect(
          () => InputField(
                keyboardType: keyboardType,
                onChanged: null,
                obscureText: true,
                hintText: hintText,
              ),
          throwsAssertionError);
    });

    test('null obscureText throws error', () {
      expect(
          () => InputField(
                keyboardType: keyboardType,
                onChanged: onChanged,
                obscureText: null,
                hintText: hintText,
              ),
          throwsAssertionError);
    });
  });

  testWidgets(
      'builds widget with keyboardType, onChanged, false obscureText and hintText',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildInputField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        obscureText: false,
        hintText: hintText));

    await tester.pump();

    expect(find.byType(InputField), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byWidgetPredicate(textInputTypeIsText), findsOneWidget);
    expect(find.byWidgetPredicate(textIsObscured), findsNothing);
    expect(find.text(hintText), findsOneWidget);
  });

  testWidgets(
      'builds widget with keyboardType, onChanged, true obscureText and hintText',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildInputField(
        keyboardType: TextInputType.phone,
        onChanged: onChanged,
        obscureText: true,
        hintText: hintText));

    await tester.pump();

    expect(find.byWidgetPredicate(textInputTypeIsText), findsNothing);
    expect(find.byWidgetPredicate(textIsObscured), findsOneWidget);
  });

  testWidgets('builds widget with keyboardType, onChanged, true obscureText',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildInputField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        obscureText: true,
        hintText: null));

    await tester.pump();

    expect(find.text(hintText), findsNothing);
  });

  testWidgets('text input calls onChanged', (WidgetTester tester) async {
    const testInput = 'testInput';

    await tester.pumpWidget(buildInputField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        obscureText: true,
        hintText: hintText));

    await tester.pump();

    await tester.enterText(find.byType(TextField), testInput);

    await tester.pump();

    expect(wasChanged, testInput);
  });
}
