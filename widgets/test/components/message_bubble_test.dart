import 'package:flash_chat_widgets/components/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MessageBubbleWrapper extends StatelessWidget {
  const MessageBubbleWrapper(this._sender, this._message, this._isCurrentUser);

  final String _sender;
  final String _message;

  final bool _isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessageBubbleTest',
      home: MessageBubble(
          sender: _sender, message: _message, isCurrentUser: _isCurrentUser),
    );
  }
}

void main() {
  const String sender = 'MessageBubbleTestSender';
  const String message = 'MessageBubbleTest';

  final WidgetPredicate currentUserMaterial = (Widget widget) =>
      widget is Material && widget.color == Colors.lightBlueAccent;
  final WidgetPredicate notCurrentUserMaterial =
      (Widget widget) => widget is Material && widget.color == Colors.grey;

  Widget buildMessageBubble(
          String message, String sender, bool isCurrentUser) =>
      MessageBubbleWrapper(message, sender, isCurrentUser);

  group('constructor', () {
    test('null sender throws error', () {
      try {
        MessageBubble(sender: null, message: message, isCurrentUser: false);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null message throws error', () {
      try {
        MessageBubble(sender: sender, message: null, isCurrentUser: true);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null isCurrentUser throws error', () {
      try {
        MessageBubble(sender: sender, message: message, isCurrentUser: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets('builds widget with message, sender and the current user',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildMessageBubble(message, sender, true));

    await tester.pump();

    expect(find.byType(MessageBubble), findsOneWidget);
    expect(find.byWidgetPredicate(currentUserMaterial), findsOneWidget);
    expect(find.byWidgetPredicate(notCurrentUserMaterial), findsNothing);
  });

  testWidgets('builds widget with message, sender and not the current user',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildMessageBubble(message, sender, false));

    await tester.pump();

    expect(find.byType(MessageBubble), findsOneWidget);
    expect(find.byWidgetPredicate(notCurrentUserMaterial), findsOneWidget);
    expect(find.byWidgetPredicate(currentUserMaterial), findsNothing);
  });
}
