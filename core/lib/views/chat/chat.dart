import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:components/components/message_bubble.dart';
import 'package:components/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/views/chat_view.dart';

import '../../utils/utils.dart';
import '../../views/views.dart';

/// The chat view implementation
class Chat extends StatelessWidget {
  final _firestore = Firestore.instance;

  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _chatBloc = BlocProvider.of<ChatBloc>(context);

    return ChatView(
      closeButtonOnPressed: () {
        _chatBloc.add(CloseButtonPressed());
      },
      messageInputFieldOnChanged: (v) {
        _chatBloc.add(ChatChanged(message: _textEditingController.text));
      },
      sendButtonOnPressed: () {
        if (_chatBloc.state == ChatFillSuccess(error: null)) {
          _chatBloc.add(ChatSubmitted(_textEditingController.text));

          _textEditingController.clear();
        }
      },
      messageStream: _firestore.collection('messages').snapshots(),
      messageBuilder: _messageBuilder,
      textEditingController: _textEditingController,
    );
  }

  Widget _messageBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(backgroundColor: primaryColor),
      );
    }

    final documents = snapshot.data.documents.reversed;

    final messageBubbles = <MessageBubble>[];

    for (var document in documents) {
      final String sender = document.data['sender'];

      final String encryptedMessage = document.data['message'];

      final message = decryptMessage(encryptedMessage, null);
      if (message != null) {
        final messageBubble = MessageBubble(
          message: message,
          sender: sender,
          isCurrentUser: sender == 'userEmail',
        );

        messageBubbles.add(messageBubble);
      }
    }
    return Expanded(
      child: ListView(
        reverse: true,
        children: messageBubbles,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      ),
    );
  }
}
