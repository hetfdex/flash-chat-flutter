import 'package:flutter/material.dart';

const InputDecoration authenticationInputFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const InputDecoration messageInputFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here',
  border: InputBorder.none,
);

const BoxDecoration messageContainerBoxDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const TextStyle sendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const String chatTitleText = '⚡️Chat';

const List<String> homeTitleText = <String>['Flash Chat'];

const String logoAnimationTag = 'logo';

final Image logoImage =
    Image.asset('packages/flash_chat_widgets/images/logo.png');

const int titleTextDurationSeconds = 10;
const int logoAnimationDurationSeconds = 4;

const Curve logoAnimationCurve = Curves.easeInOut;

const Color okButtonColor = Colors.lightBlueAccent;
const Color cancelButtonColor = Colors.blueAccent;
