import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/Material.dart';

class TypewriterAnimatedText extends StatelessWidget {
  const TypewriterAnimatedText(
      {@required this.text, @required this.durationSeconds})
      : assert(text != null),
        assert(durationSeconds != null);

  final List<String> text;

  final int durationSeconds;

  @override
  Widget build(BuildContext context) {
    return TypewriterAnimatedTextKit(
      text: text,
      duration: Duration(seconds: durationSeconds),
      textStyle: TextStyle(
        fontSize: 45.0,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
