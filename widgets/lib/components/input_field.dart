import 'package:flash_chat_widgets/helpers/constants.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {@required this.keyboardType,
      @required this.onChanged,
      @required this.obscureText,
      @required this.hintText})
      : assert(keyboardType != null),
        assert(onChanged != null),
        assert(obscureText != null),
        assert(hintText != null);

  final TextInputType keyboardType;

  final Function onChanged;

  final bool obscureText;

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration:
          authenticationInputFieldDecoration.copyWith(hintText: hintText),
    );
  }
}
