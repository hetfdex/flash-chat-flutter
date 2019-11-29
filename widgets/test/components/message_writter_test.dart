import 'package:flash_chat_widgets/components/message_writer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MessageWriterWrapper extends StatelessWidget {
  const MessageWriterWrapper(this._textEditingController,
      this._messageInputFieldOnChanged, this._sendButtonOnPressed);

  final TextEditingController _textEditingController;

  final Function _messageInputFieldOnChanged;

  final Function _sendButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessageWriterTest',
      home: Scaffold(
        body: MessageWriter(
            textEditingController: _textEditingController,
            messageInputFieldOnChanged: _messageInputFieldOnChanged,
            sendButtonOnPressed: _sendButtonOnPressed),
      ),
    );
  }
}

void main() {
  final TextEditingController textEditingController = TextEditingController();

  String wasChanged;

  bool sendButtonWasPressed = false;

  final Function messageInputFieldOnChanged = (String v) {
    wasChanged = v;
  };

  final Function sendButtonOnPressed = () {
    sendButtonWasPressed = true;
  };

  Widget buildMessageWriter(TextEditingController textEditingController,
          Function messageInputFieldOnChanged, Function sendButtonOnPressed) =>
      MessageWriterWrapper(textEditingController, messageInputFieldOnChanged,
          sendButtonOnPressed);

  group('constructor', () {
    test('null textEditingController throws error', () {
      try {
        MessageWriter(
          textEditingController: null,
          messageInputFieldOnChanged: messageInputFieldOnChanged,
          sendButtonOnPressed: sendButtonOnPressed,
        );
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null messageInputFieldOnChanged throws error', () {
      try {
        MessageWriter(
          textEditingController: textEditingController,
          messageInputFieldOnChanged: null,
          sendButtonOnPressed: sendButtonOnPressed,
        );
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null sendButtonOnPressed throws error', () {
      try {
        MessageWriter(
          textEditingController: textEditingController,
          messageInputFieldOnChanged: messageInputFieldOnChanged,
          sendButtonOnPressed: null,
        );
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets(
      'builds widget with textEditingController, messageInputFieldOnChanged and sendButtonOnPressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildMessageWriter(textEditingController,
        messageInputFieldOnChanged, sendButtonOnPressed));

    await tester.pump();

    expect(find.byType(MessageWriter), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(FlatButton), findsOneWidget);
  });

  testWidgets('tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildMessageWriter(textEditingController,
        messageInputFieldOnChanged, sendButtonOnPressed));

    await tester.pump();

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(sendButtonWasPressed, true);
  });

  testWidgets('input calls onChanged', (WidgetTester tester) async {
    const String testInput = 'InputFieldTest';

    await tester.pumpWidget(buildMessageWriter(textEditingController,
        messageInputFieldOnChanged, sendButtonOnPressed));

    await tester.pump();

    await tester.enterText(find.byType(TextField), testInput);

    await tester.pump();

    assert(wasChanged == testInput);
  });
}
