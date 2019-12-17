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
  if (invalidField == null) {
    throw ArgumentError('invalidField must not be null');
  }

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

Text _titleTextSelector(InvalidField invalidField) {
  if (invalidField == InvalidField.email) {
    return Text(
      emailTitleText,
      style: TextStyle(
        color: primaryColor,
      ),
    );
  }

  return Text(
    passwordTitleText,
    style: TextStyle(
      color: primaryColor,
    ),
  );
}

Text _contentTextSelector(InvalidField invalidField) {
  if (invalidField == InvalidField.email) {
    return Text(
      emailContentText,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }

  return Text(
    passwordContentText,
    style: TextStyle(
      color: Colors.black,
    ),
  );
}
