import 'package:components/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class InputFieldWrapper extends StatelessWidget {
  const InputFieldWrapper(
      {this.keyboardType,
      this.onChanged,
      this.obscureText,
      this.textEditingController,
      this.hintText});

  final TextInputType keyboardType;

  final Function onChanged;

  final bool obscureText;

  final TextEditingController textEditingController;

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
            textEditingController: textEditingController,
            hintText: hintText),
      ),
    );
  }
}

void main() {
  const keyboardType = TextInputType.text;

  const hintText = 'hintText';

  final textEditingController = TextEditingController();

  String wasChanged;

  onChanged(String v) => wasChanged = v;

  Widget buildInputField({bool obscureText}) => InputFieldWrapper(
        keyboardType: keyboardType,
        onChanged: onChanged,
        obscureText: obscureText,
        textEditingController: textEditingController,
        hintText: hintText,
      );

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
                textEditingController: textEditingController,
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
                textEditingController: textEditingController,
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
                textEditingController: textEditingController,
                hintText: hintText,
              ),
          throwsAssertionError);
    });

    test('null textEditingController throws error', () {
      expect(
          () => InputField(
                keyboardType: keyboardType,
                onChanged: onChanged,
                obscureText: true,
                textEditingController: null,
                hintText: hintText,
              ),
          throwsAssertionError);
    });

    test('null hintText throws error', () {
      expect(
          () => InputField(
                keyboardType: keyboardType,
                onChanged: onChanged,
                obscureText: true,
                textEditingController: textEditingController,
                hintText: null,
              ),
          throwsAssertionError);
    });
  });

  testWidgets('builds widget with false obscureText',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildInputField(obscureText: false));

    await tester.pump();

    expect(find.byType(InputField), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byWidgetPredicate(textInputTypeIsText), findsOneWidget);
    expect(find.byWidgetPredicate(textIsObscured), findsNothing);
    expect(find.text(hintText), findsOneWidget);
  });

  testWidgets('builds widget true obscureText', (WidgetTester tester) async {
    await tester.pumpWidget(buildInputField(obscureText: true));

    await tester.pump();

    expect(find.byType(InputField), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byWidgetPredicate(textInputTypeIsText), findsOneWidget);
    expect(find.byWidgetPredicate(textIsObscured), findsOneWidget);
    expect(find.text(hintText), findsOneWidget);
  });

  testWidgets('text input calls onChanged', (WidgetTester tester) async {
    const testInput = 'testInput';

    await tester.pumpWidget(buildInputField(obscureText: true));

    await tester.pump();

    await tester.enterText(find.byType(TextField), testInput);

    await tester.pump();

    expect(wasChanged, testInput);
  });
}
