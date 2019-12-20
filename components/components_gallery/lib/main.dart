import 'package:components/components/message_bubble.dart';
import 'package:components/components/input_field.dart';
import 'package:components/components/message_writer.dart';
import 'package:components/components/rounded_button.dart';
import 'package:components/components/top_bar.dart';
import 'package:components/components/typewriter_animated_text.dart';
import 'package:components/components/warning_dialog.dart';
import 'package:components/helpers/constants.dart';
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

    final textEditingController = TextEditingController();

    //InputField
    const keyboardType = TextInputType.text;

    //MessageBubble
    const message = 'message';

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
                    textEditingController: textEditingController,
                    hintText: 'hintText'),
                InputField(
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                  textEditingController: textEditingController,
                  obscureText: false,
                  hintText: '',
                ),
                const MessageBubble(
                    sender: 'currentUser',
                    message: message,
                    isCurrentUser: true),
                const MessageBubble(
                    sender: 'otherUser',
                    message: message,
                    isCurrentUser: false),
                MessageWriter(
                  textEditingController: textEditingController,
                  onChanged: onChanged,
                  onPressed: textEditingController.clear,
                ),
                TopBar(
                  onPressed: onPressed,
                  titleText: 'titleText',
                ),
                const TypewriterAnimatedText(
                  text: ['textList'],
                  durationSeconds: 10,
                  textStyle: TextStyle(
                    color: secondaryColor,
                  ),
                ),
                RoundedButton(
                  color: primaryColor,
                  text: 'Invalid Email Warning Dialog',
                  onPressed: () =>
                      showWarningDialog(context, Warnings.invalidEmail),
                ),
                RoundedButton(
                  color: secondaryColor,
                  text: 'Invalid Password Warning Dialog',
                  onPressed: () =>
                      showWarningDialog(context, Warnings.invalidPassword),
                ),
                RoundedButton(
                  color: primaryColor,
                  text: 'Unkown User Warning Dialog',
                  onPressed: () =>
                      showWarningDialog(context, Warnings.unknownUser),
                ),
                RoundedButton(
                  color: secondaryColor,
                  text: 'Wrong Password Warning Dialog',
                  onPressed: () =>
                      showWarningDialog(context, Warnings.wrongPassword),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
