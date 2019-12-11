import 'package:components/helpers/constants.dart';
import 'package:flutter/material.dart';

/// List of invalid fields
enum InvalidField {
  /// Email field
  email,

  /// Password field
  pasword,
}

/// Shows an alert dialog with information about the invalid field
void showInvalidFieldDialog(BuildContext context, InvalidField invalidField) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.white,
        title: _titleTextSelector(invalidField),
        content: _contentTextSelector(invalidField),
        actions: <Widget>[
          FlatButton(
            color: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              "OK",
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

Text _titleTextSelector(InvalidField invalidField) {
  final _invalidEmailTitle = Text(
    'Invalid email address',
    style: TextStyle(
      color: primaryColor,
    ),
  );
  final _invalidPasswordTitle = Text(
    'Invalid password',
    style: TextStyle(
      color: primaryColor,
    ),
  );

  if (invalidField == InvalidField.email) {
    return _invalidEmailTitle;
  }

  if (invalidField == InvalidField.pasword) {
    return _invalidPasswordTitle;
  }
  return Text('');
}

Text _contentTextSelector(InvalidField invalidField) {
  final _invalidEmailContent = Text(
    'A valid email address is required',
    style: TextStyle(
      color: Colors.black,
    ),
  );
  final _invalidPasswordContent = Text(
    'Passwords must be at least 8 characters, with at least 1 capital letter,\n1 number and 1 symbol',
    style: TextStyle(
      color: Colors.black,
    ),
  );

  if (invalidField == InvalidField.email) {
    return _invalidEmailContent;
  }

  if (invalidField == InvalidField.pasword) {
    return _invalidPasswordContent;
  }
  return Text('');
}
