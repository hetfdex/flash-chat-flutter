import 'package:flutter/material.dart';

/// Decoration for authentication input fields
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

/// Decoration for message input fields
const InputDecoration messageInputFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here',
  border: InputBorder.none,
);

/// Decoration for message containers
const BoxDecoration messageContainerBoxDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

/// Style for send button texts
const TextStyle sendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

/// Style for the home title
const TextStyle homeTitleTextStyle = TextStyle(
  fontSize: 45.0,
  fontWeight: FontWeight.w900,
);

/// Color for primary elements
const Color primaryColor = Colors.lightBlueAccent;

/// Color for secondary elements
const Color secondaryColor = Colors.blueAccent;

/// Text for invalid email title
const invalidEmailTitle = 'Invalid email';

/// Text for invalid password title
const invalidPasswordTitle = 'Invalid password';

/// Text for unknown user title
const unknownUserTitle = 'Unknown user';

/// Text for wrong password title
const wrongPasswordTitle = 'Wrong password';

/// Text for invalid email content
const invalidEmailContent = 'A valid email address is required';

/// Text for invalid password content
const invalidPasswordContent =
    'Passwords must be at least 8 characters, with at least 1 capital letter, 1 number and 1 symbol';

/// Text for unknown user content
const unknownUserContent =
    'Check your email address is correct or register first';

/// Text for wrong password content
const wrongPasswordContent = 'Check your password and try again';
