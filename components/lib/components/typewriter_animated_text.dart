import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/Material.dart';

/// A wrapper around the TypewriterAnimatedTextKit
class TypewriterAnimatedText extends StatelessWidget {
  /// Constructs the typewritter animated text widget
  const TypewriterAnimatedText({
    @required this.text,
    @required this.durationSeconds,
    this.textStyle,
  })  : assert(text != null),
        assert(durationSeconds != null);

  /// The text to animated as a list
  final List<String> text;

  /// The duration of the animation
  final int durationSeconds;

  /// The style of the text
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return TypewriterAnimatedTextKit(
      text: text,
      duration: Duration(seconds: durationSeconds),
      textStyle: textStyle,
    );
  }
}
