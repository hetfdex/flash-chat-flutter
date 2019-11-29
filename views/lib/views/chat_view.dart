import 'package:flash_chat_widgets/components/message_stream_builder.dart';
import 'package:flash_chat_widgets/components/message_writer.dart';
import 'package:flash_chat_widgets/components/top_bar.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
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

  final Function closeButtonOnPressed;

  final Function messageInputFieldOnChanged;

  final Function sendButtonOnPressed;

  final Stream<dynamic> messageStream;

  final Function(BuildContext, AsyncSnapshot<dynamic>) messageBuilder;

  final TextEditingController textEditingController;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(closeButtonOnPressed: widget.closeButtonOnPressed),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStreamBuilder(
                stream: widget.messageStream, builder: widget.messageBuilder),
            MessageWriter(
                textEditingController: widget.textEditingController,
                messageInputFieldOnChanged: widget.messageInputFieldOnChanged,
                sendButtonOnPressed: widget.sendButtonOnPressed),
          ],
        ),
      ),
    );
  }
}
