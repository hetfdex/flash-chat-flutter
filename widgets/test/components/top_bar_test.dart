import 'package:flash_chat_widgets/components/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TopBarWrapper extends StatelessWidget {
  const TopBarWrapper(this._closeButtonOnPressed);

  final Function _closeButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopBarTest',
      home: TopBar(closeButtonOnPressed: _closeButtonOnPressed),
    );
  }
}

void main() {
  bool closeButtonWasPressed = false;

  final Function closeButtonOnPressed = () {
    closeButtonWasPressed = true;
  };

  Widget buildTopBar(Function closeButtonOnPressed) =>
      TopBarWrapper(closeButtonOnPressed);

  group('constructor', () {
    test('null closeButtonOnPressed throws error', () {
      try {
        TopBar(closeButtonOnPressed: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  test('preferredSize returns null', () {
    final TopBar topBar = TopBar(closeButtonOnPressed: closeButtonOnPressed);

    expect(topBar.preferredSize, Size.fromHeight(50.0));
  });

  testWidgets('builds widget with closeButtonOnPressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTopBar(closeButtonOnPressed));

    await tester.pump();

    expect(find.byType(TopBar), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildTopBar(closeButtonOnPressed));

    await tester.pump();

    await tester.tap(find.byType(IconButton));

    await tester.pump();

    expect(closeButtonWasPressed, true);
  });
}
