import 'package:flutter/material.dart';

import '../helpers/constants.dart';

/// List of invalid fields
enum Warnings {
  /// Invalid email
  invalidEmail,

  /// Invalid password
  invalidPassword,

  /// Unknown user
  unknownUser,

  /// Wrong password
  wrongPassword,
}

/// Shows an alert dialog with information about the invalid field
void showWarningDialog(BuildContext context, Warnings warnings) {
  if (warnings == null) {
    throw ArgumentError('warnings must not be null');
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.white,
        title: _titleTextSelector(warnings),
        content: _contentTextSelector(warnings),
        actions: <Widget>[
          FlatButton(
            color: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Text _titleTextSelector(Warnings warnings) {
  if (warnings == Warnings.invalidEmail) {
    return Text(
      invalidEmailTitle,
      style: TextStyle(
        color: primaryColor,
      ),
    );
  } else if (warnings == Warnings.invalidPassword) {
    return Text(
      invalidPasswordTitle,
      style: TextStyle(
        color: primaryColor,
      ),
    );
  } else if (warnings == Warnings.unknownUser) {
    return Text(
      unknownUserTitle,
      style: TextStyle(
        color: primaryColor,
      ),
    );
  } else {
    return Text(
      wrongPasswordTitle,
      style: TextStyle(
        color: primaryColor,
      ),
    );
  }
}

Text _contentTextSelector(Warnings warnings) {
  if (warnings == Warnings.invalidEmail) {
    return Text(
      invalidEmailContent,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  } else if (warnings == Warnings.invalidPassword) {
    return Text(
      invalidPasswordContent,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  } else if (warnings == Warnings.unknownUser) {
    return Text(
      unknownUserContent,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  } else {
    return Text(
      wrongPasswordContent,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}
