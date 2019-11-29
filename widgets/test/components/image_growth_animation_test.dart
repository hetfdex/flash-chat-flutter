import 'package:flash_chat_widgets/components/image_growth_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ImageGrowthAnimationWrapper extends StatelessWidget {
  const ImageGrowthAnimationWrapper(
      this._image, this._animationValue, this._tag);

  final Image _image;

  final String _tag;

  final double _animationValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageGrowthAnimationTest',
      home: ImageGrowthAnimation(
          image: _image, animationValue: _animationValue, tag: _tag),
    );
  }
}

void main() {
  const String tag = 'ImageGrowthAnimationTestTag';

  const double animationValue = 1.0;

  final Image image = Image.asset('images/logo.png');

  Widget buildImageGrowthAnimation(
          Image image, double animationValue, String tag) =>
      ImageGrowthAnimationWrapper(image, animationValue, tag);

  group('constructor', () {
    test('null imageAssetLocation throws error', () {
      try {
        ImageGrowthAnimation(
            image: null, animationValue: animationValue, tag: tag);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null animationValue throws error', () {
      try {
        ImageGrowthAnimation(image: image, animationValue: null, tag: tag);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null tag throws error', () {
      try {
        ImageGrowthAnimation(
            image: image, animationValue: animationValue, tag: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets('builds widget with assetLocation, animationValue and tag',
      (WidgetTester tester) async {
    final WidgetPredicate hero =
        (Widget widget) => widget is Hero && widget.tag == tag;

    await tester
        .pumpWidget(buildImageGrowthAnimation(image, animationValue, tag));

    await tester.pump();

    expect(find.byType(ImageGrowthAnimation), findsOneWidget);
    expect(find.byWidgetPredicate(hero), findsOneWidget);
  });
}
