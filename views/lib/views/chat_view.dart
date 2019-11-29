import 'package:components/components/message_writer.dart';
import 'package:components/components/top_bar.dart';
import 'package:flutter/material.dart';

/// The chat view widget
class ChatView extends StatelessWidget {
  /// Constructs the chat view widget
  const ChatView(
      {@required this.closeButtonOnPressed,
      @required this.messageInputFieldOnChanged,
      @required this.sendButtonOnPressed,
      @required this.messageStream,
      @required this.messageBuilder,
      @required this.textEditingController})
      : assert(closeButtonOnPressed != null),
        assert(messageInputFieldOnChanged != null),
        assert(sendButtonOnPressed != null),
        assert(messageStream != null),
        assert(messageBuilder != null),
        assert(textEditingController != null);

  /// The function called when the close button is pressed
  final Function closeButtonOnPressed;

  /// The function called when the input field is changed
  final Function messageInputFieldOnChanged;

  /// The function called when the send button is pressed
  final Function sendButtonOnPressed;

  /// The stream of message
  final Stream<dynamic> messageStream;

  /// The function called when to build the messages
  final Function(BuildContext, AsyncSnapshot<dynamic>) messageBuilder;

  /// The text editing controller
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        onPressed: closeButtonOnPressed,
        titleText: '⚡️Chat',
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<dynamic>(
              stream: messageStream,
              builder: messageBuilder,
            ),
            MessageWriter(
                textEditingController: textEditingController,
                onChanged: messageInputFieldOnChanged,
                onPressed: sendButtonOnPressed),
          ],
        ),
      ),
    );
  }
}
