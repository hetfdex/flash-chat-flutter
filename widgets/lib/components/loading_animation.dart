import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({@required this.isLoading, @required this.child})
      : assert(isLoading != null),
        assert(child != null);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: isLoading, child: child);
  }
}
