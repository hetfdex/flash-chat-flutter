import 'package:components/components/input_field.dart';
import 'package:components/components/rounded_button.dart';
import 'package:components/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

/// An authentication view widget
class AuthenticationView extends StatelessWidget {
  /// Constructs the authentication view widget
  const AuthenticationView(
      {@required this.isLoading,
      @required this.authenticationButtonText,
      @required this.authenticationButtonOnPressed,
      @required this.cancelButtonOnPressed,
      @required this.emailInputFieldOnChanged,
      @required this.passwordInputFieldOnChanged})
      : assert(isLoading != null),
        assert(authenticationButtonText != null),
        assert(authenticationButtonOnPressed != null),
        assert(cancelButtonOnPressed != null),
        assert(emailInputFieldOnChanged != null),
        assert(passwordInputFieldOnChanged != null);

  /// Whether to show the loading animation
  final bool isLoading;

  /// The text on the authentication button
  final String authenticationButtonText;

  /// The function called when the authentication button is pressed
  final Function authenticationButtonOnPressed;

  /// The function called when the cancel button is pressed
  final Function cancelButtonOnPressed;

  /// The function called when the email field is changed
  final Function emailInputFieldOnChanged;

  /// The function called when the password button is changed
  final Function passwordInputFieldOnChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(
                height: 48.0,
              ),
              InputField(
                keyboardType: TextInputType.emailAddress,
                onChanged: emailInputFieldOnChanged,
                obscureText: false,
                hintText: 'Enter email',
              ),
              const SizedBox(
                height: 8.0,
              ),
              InputField(
                keyboardType: TextInputType.text,
                onChanged: passwordInputFieldOnChanged,
                obscureText: true,
                hintText: 'Enter password',
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: authenticationButtonText,
                color: primaryColor,
                onPressed: authenticationButtonOnPressed,
              ),
              RoundedButton(
                text: 'Cancel',
                color: secondaryColor,
                onPressed: cancelButtonOnPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
