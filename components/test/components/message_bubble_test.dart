import 'package:components/components/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MessageBubbleWrapper extends StatelessWidget {
  const MessageBubbleWrapper({this.sender, this.message, this.isCurrentUser});

  final String sender;

  final String message;

  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessageBubbleTest',
      home: MessageBubble(
          sender: sender, message: message, isCurrentUser: isCurrentUser),
    );
  }
}

void main() {
  const sender = 'sender';
  const message = 'message';

  isCurrentUser(Widget widget) =>
      widget is Material && widget.color == Colors.lightBlueAccent;

  Widget buildMessageBubble({bool isCurrentUser}) => MessageBubbleWrapper(
      message: message, sender: sender, isCurrentUser: isCurrentUser);

  group('constructor', () {
    test('null sender throws error', () {
      expect(
          () => MessageBubble(
                sender: null,
                message: message,
                isCurrentUser: true,
              ),
          throwsAssertionError);
    });

    test('null message throws error', () {
      expect(
          () => MessageBubble(
                sender: sender,
                message: null,
                isCurrentUser: true,
              ),
          throwsAssertionError);
    });

    test('null isCurrentUser throws error', () {
      expect(
          () => MessageBubble(
                sender: sender,
                message: message,
                isCurrentUser: null,
              ),
          throwsAssertionError);
    });
  });

  testWidgets('builds widget with message, sender and the current user',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildMessageBubble(isCurrentUser: true));

    await tester.pump();

    expect(find.byType(MessageBubble), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.byWidgetPredicate(isCurrentUser), findsOneWidget);
  });

  testWidgets('builds widget with message, sender and not the current user',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildMessageBubble(isCurrentUser: false));

    await tester.pump();

    expect(find.byWidgetPredicate(isCurrentUser), findsNothing);
  });
}
