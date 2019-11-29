import 'package:components/components/message_writer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MessageWriterWrapper extends StatelessWidget {
  const MessageWriterWrapper(
      {this.textEditingController, this.onChanged, this.onPressed});

  final TextEditingController textEditingController;

  final Function onChanged;

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessageWriterTest',
      home: Scaffold(
        body: MessageWriter(
            textEditingController: textEditingController,
            onChanged: onChanged,
            onPressed: onPressed),
      ),
    );
  }
}

void main() {
  final textEditingController = TextEditingController();

  String wasChanged;

  var wasPressed = false;

  onChanged(String v) => wasChanged = v;

  onPressed() => wasPressed = true;

  Widget buildMessageWriter(
          {TextEditingController textEditingController,
          Function onChanged,
          Function onPressed}) =>
      MessageWriterWrapper(
          textEditingController: textEditingController,
          onChanged: onChanged,
          onPressed: onPressed);

  group('constructor', () {
    test('null textEditingController throws error', () {
      expect(
          () => MessageWriter(
                textEditingController: null,
                onChanged: onChanged,
                onPressed: onPressed,
              ),
          throwsAssertionError);
    });

    test('null onChanged throws error', () {
      expect(
          () => MessageWriter(
                textEditingController: textEditingController,
                onChanged: null,
                onPressed: onPressed,
              ),
          throwsAssertionError);
    });

    test('null onPressed throws error', () {
      expect(
          () => MessageWriter(
                textEditingController: textEditingController,
                onChanged: onChanged,
                onPressed: null,
              ),
          throwsAssertionError);
    });

    testWidgets(
        'builds widget with textEditingController, onChanged and onPressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildMessageWriter(
          textEditingController: textEditingController,
          onChanged: onChanged,
          onPressed: onPressed));

      await tester.pump();

      expect(find.byType(MessageWriter), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(FlatButton), findsOneWidget);
    });

    testWidgets('button tap calls onPressed', (WidgetTester tester) async {
      await tester.pumpWidget(buildMessageWriter(
          textEditingController: textEditingController,
          onChanged: onChanged,
          onPressed: onPressed));

      await tester.pump();

      await tester.tap(find.byType(FlatButton));

      await tester.pump();

      expect(wasPressed, true);
    });

    testWidgets('text input calls onChanged', (WidgetTester tester) async {
      const testInput = 'testInput';

      await tester.pumpWidget(buildMessageWriter(
          textEditingController: textEditingController,
          onChanged: onChanged,
          onPressed: onPressed));

      await tester.pump();

      await tester.enterText(find.byType(TextField), testInput);

      await tester.pump();

      assert(wasChanged == testInput);
    });
  });
}
