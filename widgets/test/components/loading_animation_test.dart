import 'package:flash_chat_widgets/components/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoadingAnimationWrapper extends StatelessWidget {
  const LoadingAnimationWrapper(this._isLoading, this._child);

  final bool _isLoading;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoadingAnimationTest',
      home: LoadingAnimation(isLoading: _isLoading, child: _child),
    );
  }
}

void main() {
  const Widget child = Text('LoadingAnimationTest');

  Widget buildLoadingAnimation(bool isLoading, Widget child) =>
      LoadingAnimationWrapper(isLoading, child);

  group('constructor', () {
    test('null isLoading throws error', () {
      try {
        LoadingAnimation(isLoading: null, child: child);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null child throws error', () {
      try {
        LoadingAnimation(isLoading: true, child: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets('builds widget with true isLoading and child',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildLoadingAnimation(true, child));

    await tester.pump();

    expect(find.byType(LoadingAnimation), findsOneWidget);
    expect(find.byType(ModalProgressHUD), findsOneWidget);
    expect(find.byWidget(child), findsOneWidget);
  });

  testWidgets('builds widget with false isLoading and child',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildLoadingAnimation(false, child));

    await tester.pump();

    expect(find.byType(LoadingAnimation), findsOneWidget);
    expect(find.byType(ModalProgressHUD), findsOneWidget);
    expect(find.byWidget(child), findsOneWidget);
  });
}
