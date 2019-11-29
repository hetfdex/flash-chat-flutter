import 'package:components/components/message_bubble.dart';
import 'package:components/components/input_field.dart';
import 'package:components/components/message_writer.dart';
import 'package:components/components/rounded_button.dart';
import 'package:components/components/top_bar.dart';
import 'package:components/components/typewriter_animated_text.dart';
import 'package:flutter/material.dart';

void main() => runApp(ComponentsGallery());

/// The components gallery entry point
class ComponentsGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Chat Widgets Gallery',
      home: Gallery(),
    );
  }
}

/// A gallery for components
class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Shared
    onChanged(String v) {}

    onPressed() {}

    //InputField
    const keyboardType = TextInputType.text;

    const hintText = 'hintText';

    //MessageBubble
    const sender = 'sender';

    const message = 'message';

    //MessageWriter
    final textEditingController = TextEditingController();

    //RoundedButton
    const text = 'text';

    const color = Colors.green;

    //TypewriterAnimatedText
    const textList = <String>['textList'];

    const durationSeconds = 10;

    const textStyle = TextStyle(color: Colors.red);

    //TopBar
    const titleText = 'titleText';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                InputField(
                    keyboardType: keyboardType,
                    onChanged: onChanged,
                    obscureText: true,
                    hintText: hintText),
                InputField(
                    keyboardType: keyboardType,
                    onChanged: onChanged,
                    obscureText: false),
                const MessageBubble(
                    sender: sender, message: message, isCurrentUser: true),
                const MessageBubble(
                    sender: sender, message: message, isCurrentUser: false),
                MessageWriter(
                    textEditingController: textEditingController,
                    onChanged: onChanged,
                    onPressed: onPressed),
                RoundedButton(onPressed: onPressed, text: text, color: color),
                TopBar(onPressed: onPressed, titleText: titleText),
                const TypewriterAnimatedText(
                    text: textList, durationSeconds: durationSeconds),
                const TypewriterAnimatedText(
                    text: textList,
                    durationSeconds: durationSeconds,
                    textStyle: textStyle)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
