import 'package:components/helpers/constants.dart';
import 'package:flutter/material.dart';

/// An input field widget
class InputField extends StatelessWidget {
  /// Contructs the input field widget
  const InputField({
    @required this.keyboardType,
    @required this.onChanged,
    @required this.obscureText,
    this.hintText,
  })  : assert(keyboardType != null),
        assert(onChanged != null),
        assert(obscureText != null);

  /// The type of keyboard to display
  final TextInputType keyboardType;

  /// The function called when the text field's value changes
  final Function onChanged;

  /// Whether to hide the text being edited
  final bool obscureText;

  /// Hint of the type of input expected
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: authenticationInputFieldDecoration.copyWith(
        hintText: hintText,
      ),
    );
  }
}
