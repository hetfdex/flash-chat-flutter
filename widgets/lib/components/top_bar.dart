import 'package:flash_chat_widgets/helpers/constants.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({@required this.closeButtonOnPressed})
      : assert(closeButtonOnPressed != null);

  final Function closeButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: null,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.close), onPressed: closeButtonOnPressed),
      ],
      title: Text(chatTitleText),
      backgroundColor: okButtonColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
