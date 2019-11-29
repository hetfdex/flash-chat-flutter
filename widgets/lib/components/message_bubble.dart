import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {@required this.sender,
      @required this.message,
      @required this.isCurrentUser})
      : assert(sender != null),
        assert(message != null),
        assert(isCurrentUser != null);

  final String sender;
  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
              borderRadius: BorderRadius.only(
                topLeft:
                    isCurrentUser ? const Radius.circular(30.0) : Radius.zero,
                topRight:
                    !isCurrentUser ? const Radius.circular(30.0) : Radius.zero,
                bottomLeft: const Radius.circular(30.0),
                bottomRight: const Radius.circular(30.0),
              ),
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
              color: isCurrentUser ? Colors.lightBlueAccent : Colors.grey),
        ],
      ),
    );
  }
}
