import 'package:flutter/Material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {@required this.onPressed, @required this.text, @required this.color})
      : assert(onPressed != null),
        assert(text != null),
        assert(color != null);

  final Function onPressed;

  final String text;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
