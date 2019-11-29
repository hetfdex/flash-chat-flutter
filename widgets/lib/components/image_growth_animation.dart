import 'package:flutter/Material.dart';

class ImageGrowthAnimation extends StatelessWidget {
  const ImageGrowthAnimation(
      {@required this.image, @required this.animationValue, @required this.tag})
      : assert(image != null),
        assert(animationValue != null),
        assert(tag != null);

  final Image image;

  final String tag;

  final double animationValue;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        child: image,
        height: animationValue * 60.0,
      ),
    );
  }
}
