import 'package:components/helpers/constants.dart';
import 'package:flutter/material.dart';

/// A message writting widget
class MessageWriter extends StatelessWidget {
  /// Constructs the message writer widget
  const MessageWriter({
    @required this.textEditingController,
    @required this.onChanged,
    @required this.onPressed,
  })  : assert(textEditingController != null),
        assert(onChanged != null),
        assert(onPressed != null);

  /// The text editing controller
  final TextEditingController textEditingController;

  /// The function called when the text field's value changes
  final Function onChanged;

  /// What happens when the send button is pressed
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: messageContainerBoxDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: onChanged,
              decoration: messageInputFieldDecoration,
            ),
          ),
          FlatButton(
            onPressed: onPressed,
            child: Text(
              'Send',
              style: sendButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
