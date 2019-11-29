import 'dart:async';
import 'package:views/views/chat_view.dart';
import 'package:components/components/message_writer.dart';
import 'package:components/components/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ChatViewWrapper extends StatelessWidget {
  const ChatViewWrapper(
      {this.closeButtonOnPressed,
      this.messageInputFieldOnChanged,
      this.sendButtonOnPressed,
      this.messageStream,
      this.messageBuilder,
      this.textEditingController});

  final Function closeButtonOnPressed;

  final Function messageInputFieldOnChanged;

  final Function sendButtonOnPressed;

  final Stream<dynamic> messageStream;

  final Function(BuildContext, AsyncSnapshot<dynamic>) messageBuilder;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatViewTest',
      home: ChatView(
          closeButtonOnPressed: closeButtonOnPressed,
          messageInputFieldOnChanged: messageInputFieldOnChanged,
          sendButtonOnPressed: sendButtonOnPressed,
          messageStream: messageStream,
          messageBuilder: messageBuilder,
          textEditingController: textEditingController),
    );
  }
}

void main() {
  final streamController = StreamController<String>.broadcast();

  final messageStream = streamController.stream;

  messageBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Container();
  }

  final textEditingController = TextEditingController();

  String messageInputFieldWasChanged;

  var closeButtonWasPressed = false;
  var sendButtonWasPressed = false;

  messageInputFieldOnChanged(String v) {
    messageInputFieldWasChanged = v;
  }

  closeButtonOnPressed() {
    closeButtonWasPressed = true;
  }

  sendButtonOnPressed() {
    sendButtonWasPressed = true;
  }

  Widget buildChatView(
          {Function closeButtonOnPressed,
          Function messageInputFieldOnChanged,
          Function sendButtonOnPressed,
          Stream<dynamic> messageStream,
          Function(BuildContext, AsyncSnapshot<dynamic>) messageBuilder,
          TextEditingController textEditingController}) =>
      ChatViewWrapper(
          closeButtonOnPressed: closeButtonOnPressed,
          messageInputFieldOnChanged: messageInputFieldOnChanged,
          sendButtonOnPressed: sendButtonOnPressed,
          messageStream: messageStream,
          messageBuilder: messageBuilder,
          textEditingController: textEditingController);

  group('constructor', () {
    test('null closeButtonOnPressed throws error', () {
      expect(
          () => ChatView(
              closeButtonOnPressed: null,
              messageInputFieldOnChanged: messageInputFieldOnChanged,
              sendButtonOnPressed: sendButtonOnPressed,
              messageStream: messageStream,
              messageBuilder: messageBuilder,
              textEditingController: textEditingController),
          throwsAssertionError);
    });

    test('null messageInputFieldOnChanged throws error', () {
      expect(
          () => ChatView(
              closeButtonOnPressed: closeButtonOnPressed,
              messageInputFieldOnChanged: null,
              sendButtonOnPressed: sendButtonOnPressed,
              messageStream: messageStream,
              messageBuilder: messageBuilder,
              textEditingController: textEditingController),
          throwsAssertionError);
    });
    test('null sendButtonOnPressed throws error', () {
      expect(
          () => ChatView(
              closeButtonOnPressed: closeButtonOnPressed,
              messageInputFieldOnChanged: messageInputFieldOnChanged,
              sendButtonOnPressed: null,
              messageStream: messageStream,
              messageBuilder: messageBuilder,
              textEditingController: textEditingController),
          throwsAssertionError);
    });
    test('null messageStream throws error', () {
      expect(
          () => ChatView(
              closeButtonOnPressed: closeButtonOnPressed,
              messageInputFieldOnChanged: messageInputFieldOnChanged,
              sendButtonOnPressed: sendButtonOnPressed,
              messageStream: null,
              messageBuilder: messageBuilder,
              textEditingController: textEditingController),
          throwsAssertionError);
    });
    test('null messageBuilder throws error', () {
      expect(
          () => ChatView(
              closeButtonOnPressed: closeButtonOnPressed,
              messageInputFieldOnChanged: messageInputFieldOnChanged,
              sendButtonOnPressed: sendButtonOnPressed,
              messageStream: messageStream,
              messageBuilder: null,
              textEditingController: textEditingController),
          throwsAssertionError);
    });
    test('null textEditingController throws error', () {
      expect(
          () => ChatView(
              closeButtonOnPressed: closeButtonOnPressed,
              messageInputFieldOnChanged: messageInputFieldOnChanged,
              sendButtonOnPressed: sendButtonOnPressed,
              messageStream: messageStream,
              messageBuilder: messageBuilder,
              textEditingController: null),
          throwsAssertionError);
    });
  });

  testWidgets('builds view widget', (WidgetTester tester) async {
    await tester.pumpWidget(buildChatView(
        closeButtonOnPressed: closeButtonOnPressed,
        messageInputFieldOnChanged: messageInputFieldOnChanged,
        sendButtonOnPressed: sendButtonOnPressed,
        messageStream: messageStream,
        messageBuilder: messageBuilder,
        textEditingController: textEditingController));

    await tester.pump();

    expect(find.byType(ChatView), findsOneWidget);
    expect(find.byType(TopBar), findsOneWidget);
    expect(find.byType(StreamBuilder), findsOneWidget);
    expect(find.byType(MessageWriter), findsOneWidget);
  });

  testWidgets('close tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildChatView(
        closeButtonOnPressed: closeButtonOnPressed,
        messageInputFieldOnChanged: messageInputFieldOnChanged,
        sendButtonOnPressed: sendButtonOnPressed,
        messageStream: messageStream,
        messageBuilder: messageBuilder,
        textEditingController: textEditingController));

    await tester.pump();

    await tester.tap(find.byType(IconButton));

    await tester.pump();

    expect(closeButtonWasPressed, true);
  });

  testWidgets('send tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildChatView(
        closeButtonOnPressed: closeButtonOnPressed,
        messageInputFieldOnChanged: messageInputFieldOnChanged,
        sendButtonOnPressed: sendButtonOnPressed,
        messageStream: messageStream,
        messageBuilder: messageBuilder,
        textEditingController: textEditingController));

    await tester.pump();

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(sendButtonWasPressed, true);
  });

  testWidgets('message input calls onChanged', (WidgetTester tester) async {
    const messageInputTest = 'messageInputTest';

    await tester.pumpWidget(buildChatView(
        closeButtonOnPressed: closeButtonOnPressed,
        messageInputFieldOnChanged: messageInputFieldOnChanged,
        sendButtonOnPressed: sendButtonOnPressed,
        messageStream: messageStream,
        messageBuilder: messageBuilder,
        textEditingController: textEditingController));

    await tester.pump();

    await tester.enterText(find.byType(TextField), messageInputTest);

    await tester.pump();

    expect(messageInputFieldWasChanged, messageInputTest);
  });
}
