import 'package:flash_chat_widgets/helpers/constants.dart';
import 'package:flutter/material.dart';

/// A top bar widget
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructs the top bar widget
  const TopBar({@required this.onPressed}) : assert(onPressed != null);

  /// The function called when the close button is pressed
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: null,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.close), onPressed: onPressed),
      ],
      title: Text(chatTitleText),
      backgroundColor: okButtonColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
