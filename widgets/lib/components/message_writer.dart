import 'package:flash_chat_widgets/helpers/constants.dart';
import 'package:flutter/material.dart';

class MessageWriter extends StatelessWidget {
  const MessageWriter({
    @required this.textEditingController,
    @required this.messageInputFieldOnChanged,
    @required this.sendButtonOnPressed,
  });

  final TextEditingController textEditingController;

  final Function messageInputFieldOnChanged;

  final Function sendButtonOnPressed;

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
              onChanged: messageInputFieldOnChanged,
              decoration: messageInputFieldDecoration,
            ),
          ),
          FlatButton(
            onPressed: sendButtonOnPressed,
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
