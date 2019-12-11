import 'package:flutter/Material.dart';

/// A rounded button widget
class RoundedButton extends StatelessWidget {
  /// Constructs the rounded button widget
  const RoundedButton({
    @required this.onPressed,
    @required this.text,
    @required this.color,
  })  : assert(onPressed != null),
        assert(text != null),
        assert(color != null);

  /// The function called when the button is pressed
  final Function onPressed;

  /// The button text
  final String text;

  /// The button color
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
