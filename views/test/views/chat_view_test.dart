import 'dart:async';
import 'package:flash_chat_views/views/chat_view.dart';
import 'package:flash_chat_widgets/components/message_stream_builder.dart';
import 'package:flash_chat_widgets/components/message_writer.dart';
import 'package:flash_chat_widgets/components/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ChatViewWrapper extends StatelessWidget {
  const ChatViewWrapper(
      this._closeButtonOnPressed,
      this._messageInputFieldOnChanged,
      this._sendButtonOnPressed,
      this._messageStream,
      this._messageBuilder,
      this._textEditingController);

  final Function _closeButtonOnPressed;

  final Function _messageInputFieldOnChanged;

  final Function _sendButtonOnPressed;

  final Stream<dynamic> _messageStream;

  final Function(BuildContext, AsyncSnapshot<dynamic>) _messageBuilder;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatViewTest',
      home: ChatView(
          closeButtonOnPressed: _closeButtonOnPressed,
          messageInputFieldOnChanged: _messageInputFieldOnChanged,
          sendButtonOnPressed: _sendButtonOnPressed,
          messageStream: _messageStream,
          messageBuilder: _messageBuilder,
          textEditingController: _textEditingController),
    );
  }
}

void main() {
  final StreamController<String> streamController =
      StreamController<String>.broadcast();

  final Stream<String> messageStream = streamController.stream;

  final TextEditingController textEditingController = TextEditingController();

  final Function(BuildContext, AsyncSnapshot<dynamic>) messageBuilder =
      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Container();
  };

  String messageInputFieldWasChanged;

  bool closeButtonWasPressed = false;
  bool sendButtonWasPressed = false;

  final Function messageInputFieldOnChanged = (String v) {
    messageInputFieldWasChanged = v;
  };

  final Function closeButtonOnPressed = () {
    closeButtonWasPressed = true;
  };

  final Function sendButtonOnPressed = () {
    sendButtonWasPressed = true;
  };

  Widget buildChatView(
          Function closeButtonOnPressed,
          Function messageInputFieldOnChanged,
          Function sendButtonOnPressed,
          Stream<dynamic> messageStream,
          Function(BuildContext, AsyncSnapshot<dynamic>) messageBuilder,
          TextEditingController textEditingController) =>
      ChatViewWrapper(
          closeButtonOnPressed,
          messageInputFieldOnChanged,
          sendButtonOnPressed,
          messageStream,
          messageBuilder,
          textEditingController);

  group('constructor', () {
    test('null closeButtonOnPressed throws error', () {
      try {
        ChatView(
            closeButtonOnPressed: null,
            messageInputFieldOnChanged: messageInputFieldOnChanged,
            sendButtonOnPressed: sendButtonOnPressed,
            messageStream: messageStream,
            messageBuilder: messageBuilder,
            textEditingController: textEditingController);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null messageInputFieldOnChanged throws error', () {
      try {
        ChatView(
            closeButtonOnPressed: closeButtonOnPressed,
            messageInputFieldOnChanged: null,
            sendButtonOnPressed: sendButtonOnPressed,
            messageStream: messageStream,
            messageBuilder: messageBuilder,
            textEditingController: textEditingController);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
    test('null sendButtonOnPressed throws error', () {
      try {
        ChatView(
            closeButtonOnPressed: closeButtonOnPressed,
            messageInputFieldOnChanged: messageInputFieldOnChanged,
            sendButtonOnPressed: null,
            messageStream: messageStream,
            messageBuilder: messageBuilder,
            textEditingController: textEditingController);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
    test('null messageStream throws error', () {
      try {
        ChatView(
            closeButtonOnPressed: closeButtonOnPressed,
            messageInputFieldOnChanged: messageInputFieldOnChanged,
            sendButtonOnPressed: sendButtonOnPressed,
            messageStream: null,
            messageBuilder: messageBuilder,
            textEditingController: textEditingController);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
    test('null messageBuilder throws error', () {
      try {
        ChatView(
            closeButtonOnPressed: closeButtonOnPressed,
            messageInputFieldOnChanged: messageInputFieldOnChanged,
            sendButtonOnPressed: sendButtonOnPressed,
            messageStream: messageStream,
            messageBuilder: null,
            textEditingController: textEditingController);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
    test('null textEditingController throws error', () {
      try {
        ChatView(
            closeButtonOnPressed: closeButtonOnPressed,
            messageInputFieldOnChanged: messageInputFieldOnChanged,
            sendButtonOnPressed: sendButtonOnPressed,
            messageStream: messageStream,
            messageBuilder: messageBuilder,
            textEditingController: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets('builds view widget', (WidgetTester tester) async {
    await tester.pumpWidget(buildChatView(
        closeButtonOnPressed,
        messageInputFieldOnChanged,
        sendButtonOnPressed,
        messageStream,
        messageBuilder,
        textEditingController));

    await tester.pump();

    expect(find.byType(ChatView), findsOneWidget);
    expect(find.byType(TopBar), findsOneWidget);
    expect(find.byType(MessageStreamBuilder), findsOneWidget);
    expect(find.byType(MessageWriter), findsOneWidget);
  });

  testWidgets('close tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildChatView(
        closeButtonOnPressed,
        messageInputFieldOnChanged,
        sendButtonOnPressed,
        messageStream,
        messageBuilder,
        textEditingController));

    await tester.pump();

    await tester.tap(find.byType(IconButton));

    await tester.pump();

    expect(closeButtonWasPressed, true);
  });

  testWidgets('send tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildChatView(
        closeButtonOnPressed,
        messageInputFieldOnChanged,
        sendButtonOnPressed,
        messageStream,
        messageBuilder,
        textEditingController));

    await tester.pump();

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(sendButtonWasPressed, true);
  });

  testWidgets('message input calls onChanged', (WidgetTester tester) async {
    const String messageInputTest = 'messageInputTest';

    await tester.pumpWidget(buildChatView(
        closeButtonOnPressed,
        messageInputFieldOnChanged,
        sendButtonOnPressed,
        messageStream,
        messageBuilder,
        textEditingController));

    await tester.pump();

    await tester.enterText(find.byType(TextField), messageInputTest);

    await tester.pump();

    assert(messageInputFieldWasChanged == messageInputTest);
  });
}
