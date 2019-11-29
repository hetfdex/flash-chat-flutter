import 'package:flash_chat_widgets/components/input_field.dart';
import 'package:flash_chat_widgets/components/loading_animation.dart';
import 'package:flash_chat_widgets/components/rounded_button.dart';
import 'package:flash_chat_widgets/helpers/constants.dart';
import 'package:flutter/material.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView(
      {@required this.isLoading,
      @required this.authenticateButtonText,
      @required this.authenticationButtonOnPressed,
      @required this.cancelButtonOnPressed,
      @required this.emailInputFieldOnChanged,
      @required this.passwordInputFieldOnChanged})
      : assert(isLoading != null),
        assert(authenticateButtonText != null),
        assert(authenticationButtonOnPressed != null),
        assert(cancelButtonOnPressed != null),
        assert(emailInputFieldOnChanged != null),
        assert(passwordInputFieldOnChanged != null);

  final bool isLoading;

  final String authenticateButtonText;

  final Function authenticationButtonOnPressed;
  final Function cancelButtonOnPressed;
  final Function emailInputFieldOnChanged;
  final Function passwordInputFieldOnChanged;

  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingAnimation(
        isLoading: widget.isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: logoAnimationTag,
                  child: Container(
                    height: 200.0,
                    child: logoImage,
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              InputField(
                keyboardType: TextInputType.emailAddress,
                onChanged: widget.emailInputFieldOnChanged,
                obscureText: false,
                hintText: 'Enter email',
              ),
              const SizedBox(
                height: 8.0,
              ),
              InputField(
                keyboardType: TextInputType.text,
                onChanged: widget.passwordInputFieldOnChanged,
                obscureText: true,
                hintText: 'Enter password',
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: widget.authenticateButtonText,
                color: okButtonColor,
                onPressed: widget.authenticationButtonOnPressed,
              ),
              RoundedButton(
                text: 'Cancel',
                color: cancelButtonColor,
                onPressed: widget.cancelButtonOnPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
