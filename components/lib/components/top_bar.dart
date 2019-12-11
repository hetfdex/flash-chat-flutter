import 'package:components/helpers/constants.dart';
import 'package:flutter/material.dart';

/// A top bar widget
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructs the top bar widget
  const TopBar({
    @required this.onPressed,
    @required this.titleText,
  })  : assert(onPressed != null),
        assert(titleText != null);

  /// The function called when the close button is pressed
  final Function onPressed;

  /// The title text
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: null,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: onPressed,
        ),
      ],
      title: Text(titleText),
      backgroundColor: primaryColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
