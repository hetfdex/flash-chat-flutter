import 'package:components/components/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TopBarWrapper extends StatelessWidget {
  const TopBarWrapper({this.onPressed, this.titleText});

  final Function onPressed;

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopBarTest',
      home: TopBar(onPressed: onPressed, titleText: titleText),
    );
  }
}

void main() {
  const titleText = 'titleText';

  var wasPressed = false;

  onPressed() => wasPressed = true;

  Widget buildTopBar() =>
      TopBarWrapper(onPressed: onPressed, titleText: titleText);

  group('constructor', () {
    test('null onPressed throws error', () {
      expect(() => TopBar(onPressed: null, titleText: titleText),
          throwsAssertionError);
    });

    test('null titleText throws error', () {
      expect(() => TopBar(onPressed: onPressed, titleText: null),
          throwsAssertionError);
    });

    test('returns correct preferedSize', () {
      final topBar = TopBar(onPressed: onPressed, titleText: titleText);

      final preferedSize = Size.fromHeight(50.0);

      expect(topBar.preferredSize, preferedSize);
    });
  });

  testWidgets('builds widget', (tester) async {
    await tester.pumpWidget(buildTopBar());

    await tester.pump();

    expect(find.byType(TopBar), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.text(titleText), findsOneWidget);
  });

  testWidgets('button tap calls onPressed', (tester) async {
    await tester.pumpWidget(buildTopBar());

    await tester.pump();

    await tester.tap(find.byType(IconButton));

    await tester.pump();

    expect(wasPressed, true);
  });
}
