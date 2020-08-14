import 'package:flutter/material.dart';

import '../helpers/constants.dart';

/// An input field widget
class InputField extends StatelessWidget {
  /// Contructs the input field widget
  const InputField({
    @required this.keyboardType,
    @required this.onChanged,
    @required this.obscureText,
    @required this.textEditingController,
    @required this.hintText,
  })  : assert(keyboardType != null),
        assert(onChanged != null),
        assert(obscureText != null),
        assert(textEditingController != null),
        assert(hintText != null);

  /// The type of keyboard to display
  final TextInputType keyboardType;

  /// The function called when the text field's value changes
  final Function onChanged;

  /// Whether to hide the text being edited
  final bool obscureText;

  /// The text editing controller
  final TextEditingController textEditingController;

  /// Hint of the type of input expected
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscureText,
      controller: textEditingController,
      decoration: authenticationInputFieldDecoration.copyWith(
        hintText: hintText,
      ),
    );
  }
}
