import 'package:components/components/rounded_button.dart';
import 'package:components/components/typewriter_animated_text.dart';
import 'package:components/helpers/constants.dart';
import 'package:flutter/material.dart';

/// The home view widget
class HomeView extends StatelessWidget {
  /// Constructs the home view widget
  const HomeView({
    @required this.loginButtonOnPressed,
    @required this.registerButtonOnPressed,
  })  : assert(loginButtonOnPressed != null),
        assert(registerButtonOnPressed != null);

  /// The function called when the login button is pressed
  final Function loginButtonOnPressed;

  /// The function called when the register button is pressed
  final Function registerButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  'packages/views/images/logo.png',
                  scale: 10.0,
                ),
                TypewriterAnimatedText(
                  text: <String>['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                  durationSeconds: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                text: 'Login',
                color: primaryColor,
                onPressed: loginButtonOnPressed),
            RoundedButton(
                text: 'Register',
                color: secondaryColor,
                onPressed: registerButtonOnPressed),
          ],
        ),
      ),
    );
  }
}
