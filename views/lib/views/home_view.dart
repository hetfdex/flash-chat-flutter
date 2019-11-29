import 'package:flash_chat_widgets/components/image_growth_animation.dart';
import 'package:flash_chat_widgets/components/rounded_button.dart';
import 'package:flash_chat_widgets/components/typewriter_animated_text.dart';
import 'package:flash_chat_widgets/helpers/constants.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    @required this.loginButtonOnPressed,
    @required this.registerButtonOnPressed,
  })  : assert(loginButtonOnPressed != null),
        assert(registerButtonOnPressed != null);

  final Function loginButtonOnPressed;
  final Function registerButtonOnPressed;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();

    _animateLogoTitle();
  }

  @override
  void dispose() {
    _animationController?.dispose();

    super.dispose();
  }

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
                ImageGrowthAnimation(
                    image: logoImage,
                    tag: logoAnimationTag,
                    animationValue: _curvedAnimation.value),
                TypewriterAnimatedText(
                  text: homeTitleText,
                  durationSeconds: titleTextDurationSeconds,
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                text: 'Login',
                color: okButtonColor,
                onPressed: widget.loginButtonOnPressed),
            RoundedButton(
                text: 'Register',
                color: cancelButtonColor,
                onPressed: widget.registerButtonOnPressed),
          ],
        ),
      ),
    );
  }

  void _animateLogoTitle() {
    _animationController = AnimationController(
        duration: Duration(seconds: logoAnimationDurationSeconds), vsync: this);

    _curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: logoAnimationCurve);

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.forward();
  }
}
