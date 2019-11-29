import 'dart:async';
import 'package:flash_chat_widgets/components/message_bubble.dart';
import 'package:flash_chat_widgets/components/loading_animation.dart';
import 'package:flash_chat_widgets/components/input_field.dart';
import 'package:flash_chat_widgets/components/message_stream_builder.dart';
import 'package:flash_chat_widgets/components/message_writer.dart';
import 'package:flash_chat_widgets/components/rounded_button.dart';
import 'package:flash_chat_widgets/components/top_bar.dart';
import 'package:flash_chat_widgets/components/typewriter_animated_text.dart';
import 'package:flash_chat_widgets/components/image_growth_animation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Chat Widgets Gallery',
      home: Gallery(),
    );
  }
}

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ImageGrowthAnimation
    const double animationValue = 1.0;

    const String tag = 'ImageGrowthAnimationTag';

    final Image image =
        Image.asset('packages/flash_chat_widgets/images/logo.png');

    //InputField
    const TextInputType keyboardType = TextInputType.text;
    const String hintText = 'InputFieldHintText';
    final Function onChanged = (String v) {};

    //Loading Animation
    const bool isLoading = false;

    //MessageBubble
    const String sender = 'MessageBubbleSender';
    const String message = 'MessageBubble';

    //MessageStreamBuilder
    final StreamController<String> streamController =
        StreamController<String>();

    final Stream<dynamic> stream = streamController.stream;

    final Function(BuildContext, AsyncSnapshot<dynamic>) builder =
        (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      return const Text('builder');
    };

    //MessageWriter
    TextEditingController textEditingController = TextEditingController();

    Function messageInputFieldOnChanged = (String v) {};

    Function sendButtonOnPressed = () {};

    //RoundedButton
    const String text = 'RoundedButtonText';

    const Color color = Colors.green;

    final Function onPressed = () {};

    //TopBar
    final Function closeButtonOnPressed = () {};

    //TypewriterAnimatedText
    const List<String> texts = <String>['TypewriterAnimatedText'];

    const int durationSeconds = 10;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingAnimation(
        isLoading: isLoading,
        child: SafeArea(
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  ImageGrowthAnimation(
                      image: image, animationValue: animationValue, tag: tag),
                  InputField(
                      keyboardType: keyboardType,
                      onChanged: onChanged,
                      obscureText: true,
                      hintText: hintText),
                  InputField(
                      keyboardType: keyboardType,
                      onChanged: onChanged,
                      obscureText: false,
                      hintText: hintText),
                  const MessageBubble(
                      sender: sender, message: message, isCurrentUser: true),
                  const MessageBubble(
                      sender: sender, message: message, isCurrentUser: false),
                  MessageStreamBuilder(stream: stream, builder: builder),
                  MessageWriter(
                      textEditingController: textEditingController,
                      messageInputFieldOnChanged: messageInputFieldOnChanged,
                      sendButtonOnPressed: sendButtonOnPressed),
                  RoundedButton(onPressed: onPressed, text: text, color: color),
                  TopBar(closeButtonOnPressed: closeButtonOnPressed),
                  const TypewriterAnimatedText(
                      text: texts, durationSeconds: durationSeconds)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
