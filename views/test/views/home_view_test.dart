import 'package:flash_chat_views/views/home_view.dart';
import 'package:flash_chat_widgets/components/image_growth_animation.dart';
import 'package:flash_chat_widgets/components/rounded_button.dart';
import 'package:flash_chat_widgets/components/typewriter_animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeViewWrapper extends StatelessWidget {
  const HomeViewWrapper(
      this._loginButtonOnPressed, this._registerButtonOnPressed);

  final Function _loginButtonOnPressed;
  final Function _registerButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeViewTest',
      home: HomeView(
        loginButtonOnPressed: _loginButtonOnPressed,
        registerButtonOnPressed: _registerButtonOnPressed,
      ),
    );
  }
}

void main() {
  bool loginButtonWasPressed = false;
  bool registerButtonWasPressed = false;

  final Function loginButtonOnPressed = () {
    loginButtonWasPressed = true;
  };

  final Function registerButtonOnPressed = () {
    registerButtonWasPressed = true;
  };

  Widget buildHomeView(
    Function loginButtonOnPressed,
    Function registerButtonOnPressed,
  ) =>
      HomeViewWrapper(loginButtonOnPressed, registerButtonOnPressed);

  group('constructor', () {
    test('null loginButtonOnPressed throws error', () {
      try {
        HomeView(
          loginButtonOnPressed: null,
          registerButtonOnPressed: registerButtonOnPressed,
        );
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null registerButtonOnPressed throws error', () {
      try {
        HomeView(
          loginButtonOnPressed: loginButtonOnPressed,
          registerButtonOnPressed: null,
        );
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets('builds view widget', (WidgetTester tester) async {
    await tester.pumpWidget(buildHomeView(
      loginButtonOnPressed,
      registerButtonOnPressed,
    ));

    await tester.pump();

    expect(find.byType(HomeView), findsOneWidget);
    expect(find.byType(RoundedButton), findsNWidgets(2));
    expect(find.byType(ImageGrowthAnimation), findsOneWidget);
    expect(find.byType(TypewriterAnimatedText), findsOneWidget);
  });

  testWidgets('login tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildHomeView(
      loginButtonOnPressed,
      registerButtonOnPressed,
    ));

    await tester.pump();

    await tester.tap(find.text('Login'));

    await tester.pump();

    expect(loginButtonWasPressed, true);
  });

  testWidgets('register tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildHomeView(
      loginButtonOnPressed,
      registerButtonOnPressed,
    ));

    await tester.pump();

    await tester.tap(find.text('Register'));

    await tester.pump();

    expect(registerButtonWasPressed, true);
  });
}
