import 'package:views/views/home_view.dart';
import 'package:components/components/rounded_button.dart';
import 'package:components/components/typewriter_animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeViewWrapper extends StatelessWidget {
  const HomeViewWrapper(
      {this.loginButtonOnPressed, this.registerButtonOnPressed});

  final Function loginButtonOnPressed;

  final Function registerButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeViewTest',
      home: HomeView(
        loginButtonOnPressed: loginButtonOnPressed,
        registerButtonOnPressed: registerButtonOnPressed,
      ),
    );
  }
}

void main() {
  var loginButtonWasPressed = false;
  var registerButtonWasPressed = false;

  loginButtonOnPressed() {
    loginButtonWasPressed = true;
  }

  registerButtonOnPressed() {
    registerButtonWasPressed = true;
  }

  Widget buildHomeView() => HomeViewWrapper(
      loginButtonOnPressed: loginButtonOnPressed,
      registerButtonOnPressed: registerButtonOnPressed);

  group('constructor', () {
    test('null loginButtonOnPressed throws error', () {
      expect(
          () => HomeView(
                loginButtonOnPressed: null,
                registerButtonOnPressed: registerButtonOnPressed,
              ),
          throwsAssertionError);
    });

    test('null registerButtonOnPressed throws error', () {
      expect(
          () => HomeView(
                loginButtonOnPressed: loginButtonOnPressed,
                registerButtonOnPressed: null,
              ),
          throwsAssertionError);
    });
  });

  testWidgets('builds widget', (WidgetTester tester) async {
    await tester.pumpWidget(buildHomeView());

    await tester.pump();

    expect(find.byType(HomeView), findsOneWidget);
    expect(find.byType(RoundedButton), findsNWidgets(2));
    expect(find.byType(TypewriterAnimatedText), findsOneWidget);
  });

  testWidgets('login tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildHomeView());

    await tester.pump();

    await tester.tap(find.text('Login'));

    await tester.pump();

    expect(loginButtonWasPressed, true);
  });

  testWidgets('register tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildHomeView());

    await tester.pump();

    await tester.tap(find.text('Register'));

    await tester.pump();

    expect(registerButtonWasPressed, true);
  });
}
