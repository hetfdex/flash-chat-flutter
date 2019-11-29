import 'package:flash_chat_views/views/authentication_view.dart';
import 'package:flash_chat_widgets/components/input_field.dart';
import 'package:flash_chat_widgets/components/loading_animation.dart';
import 'package:flash_chat_widgets/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthenticationViewWrapper extends StatelessWidget {
  const AuthenticationViewWrapper(
      this._isLoading,
      this._authenticationButtonText,
      this._authenticationButtonOnPressed,
      this._cancelButtonOnPressed,
      this._emailInputFieldOnChanged,
      this._passwordInputFieldOnChanged);

  final bool _isLoading;

  final String _authenticationButtonText;

  final Function _authenticationButtonOnPressed;
  final Function _cancelButtonOnPressed;
  final Function _emailInputFieldOnChanged;
  final Function _passwordInputFieldOnChanged;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthenticationViewTest',
      home: AuthenticationView(
          isLoading: _isLoading,
          authenticateButtonText: _authenticationButtonText,
          authenticationButtonOnPressed: _authenticationButtonOnPressed,
          cancelButtonOnPressed: _cancelButtonOnPressed,
          emailInputFieldOnChanged: _emailInputFieldOnChanged,
          passwordInputFieldOnChanged: _passwordInputFieldOnChanged),
    );
  }
}

void main() {
  const String authenticateButtonText = 'authenticateButtonText';

  String emailInput;
  String passwordInput;

  bool authenticationButtonWasPressed = false;
  bool cancelButtonWasPressed = false;

  final Function authenticationButtonOnPressed = () {
    authenticationButtonWasPressed = true;
  };
  final Function cancelButtonOnPressed = () {
    cancelButtonWasPressed = true;
  };
  final Function emailInputFieldOnChanged = (String v) {
    emailInput = v;
  };
  final Function passwordInputFieldOnChanged = (String v) {
    passwordInput = v;
  };

  Widget buildAuthenticationView(
          bool isLoading,
          String authenticateButtonText,
          Function authenticateButtonOnPressed,
          Function cancelButtonOnPressed,
          Function emailInputFieldOnChanged,
          Function passwordInputFieldOnChanged) =>
      AuthenticationViewWrapper(
          isLoading,
          authenticateButtonText,
          authenticateButtonOnPressed,
          cancelButtonOnPressed,
          emailInputFieldOnChanged,
          passwordInputFieldOnChanged);

  group('constructor', () {
    test('null isLoading throws error', () {
      try {
        AuthenticationView(
            isLoading: null,
            authenticateButtonText: authenticateButtonText,
            authenticationButtonOnPressed: authenticationButtonOnPressed,
            cancelButtonOnPressed: cancelButtonOnPressed,
            emailInputFieldOnChanged: emailInputFieldOnChanged,
            passwordInputFieldOnChanged: passwordInputFieldOnChanged);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
    test('null authenticateButtonText throws error', () {
      try {
        AuthenticationView(
            isLoading: false,
            authenticateButtonText: null,
            authenticationButtonOnPressed: authenticationButtonOnPressed,
            cancelButtonOnPressed: cancelButtonOnPressed,
            emailInputFieldOnChanged: emailInputFieldOnChanged,
            passwordInputFieldOnChanged: passwordInputFieldOnChanged);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null authenticationButtonOnPressed throws error', () {
      try {
        AuthenticationView(
            isLoading: false,
            authenticateButtonText: authenticateButtonText,
            authenticationButtonOnPressed: null,
            cancelButtonOnPressed: cancelButtonOnPressed,
            emailInputFieldOnChanged: emailInputFieldOnChanged,
            passwordInputFieldOnChanged: passwordInputFieldOnChanged);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
    test('null cancelButtonOnPressed throws error', () {
      try {
        AuthenticationView(
            isLoading: false,
            authenticateButtonText: authenticateButtonText,
            authenticationButtonOnPressed: authenticationButtonOnPressed,
            cancelButtonOnPressed: null,
            emailInputFieldOnChanged: emailInputFieldOnChanged,
            passwordInputFieldOnChanged: passwordInputFieldOnChanged);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
    test('null emailInputFieldOnChanged throws error', () {
      try {
        AuthenticationView(
            isLoading: false,
            authenticateButtonText: authenticateButtonText,
            authenticationButtonOnPressed: authenticationButtonOnPressed,
            cancelButtonOnPressed: cancelButtonOnPressed,
            emailInputFieldOnChanged: null,
            passwordInputFieldOnChanged: passwordInputFieldOnChanged);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null passwordInputFieldOnChanged throws error', () {
      try {
        AuthenticationView(
            isLoading: false,
            authenticateButtonText: authenticateButtonText,
            authenticationButtonOnPressed: authenticationButtonOnPressed,
            cancelButtonOnPressed: cancelButtonOnPressed,
            emailInputFieldOnChanged: emailInputFieldOnChanged,
            passwordInputFieldOnChanged: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets('builds view widget', (WidgetTester tester) async {
    await tester.pumpWidget(buildAuthenticationView(
        false,
        authenticateButtonText,
        authenticationButtonOnPressed,
        cancelButtonOnPressed,
        emailInputFieldOnChanged,
        passwordInputFieldOnChanged));

    await tester.pump();

    expect(find.byType(AuthenticationView), findsOneWidget);
    expect(find.byType(LoadingAnimation), findsOneWidget);
    expect(find.byType(Hero), findsOneWidget);
    expect(find.byType(InputField), findsNWidgets(2));
    expect(find.byType(RoundedButton), findsNWidgets(2));
  });

  testWidgets('authenticateButton tap calls onPressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildAuthenticationView(
        false,
        authenticateButtonText,
        authenticationButtonOnPressed,
        cancelButtonOnPressed,
        emailInputFieldOnChanged,
        passwordInputFieldOnChanged));

    await tester.pump();

    await tester.tap(find.text(authenticateButtonText));

    await tester.pump();

    expect(authenticationButtonWasPressed, true);
  });

  testWidgets('cancelButton tap calls onPressed', (WidgetTester tester) async {
    const String cancelButtonText = 'Cancel';

    await tester.pumpWidget(buildAuthenticationView(
        false,
        authenticateButtonText,
        authenticationButtonOnPressed,
        cancelButtonOnPressed,
        emailInputFieldOnChanged,
        passwordInputFieldOnChanged));

    await tester.pump();

    await tester.tap(find.text(cancelButtonText));

    await tester.pump();

    expect(cancelButtonWasPressed, true);
  });

  testWidgets('email input calls onChanged', (WidgetTester tester) async {
    final WidgetPredicate emailInputField = (Widget widget) =>
        widget is InputField && widget.hintText == 'Enter email';

    const String emailInputText = 'emailInputText';

    await tester.pumpWidget(buildAuthenticationView(
        false,
        authenticateButtonText,
        authenticationButtonOnPressed,
        cancelButtonOnPressed,
        emailInputFieldOnChanged,
        passwordInputFieldOnChanged));

    await tester.pump();

    await tester.enterText(
        find.byWidgetPredicate(emailInputField), emailInputText);

    await tester.pump();

    assert(emailInput == emailInputText);
  });

  testWidgets('password input calls onChanged', (WidgetTester tester) async {
    final WidgetPredicate passwordInputField = (Widget widget) =>
        widget is InputField && widget.hintText == 'Enter password';

    const String passwordInputTest = 'passwordInputTest';

    await tester.pumpWidget(buildAuthenticationView(
        false,
        authenticateButtonText,
        authenticationButtonOnPressed,
        cancelButtonOnPressed,
        emailInputFieldOnChanged,
        passwordInputFieldOnChanged));

    await tester.pump();

    await tester.enterText(
        find.byWidgetPredicate(passwordInputField), passwordInputTest);

    await tester.pump();

    assert(passwordInput == passwordInputTest);
  });

  testWidgets('isLoading is false', (WidgetTester tester) async {
    final WidgetPredicate loadingAnimation = (Widget widget) =>
        widget is LoadingAnimation && widget.isLoading == false;

    await tester.pumpWidget(buildAuthenticationView(
        false,
        authenticateButtonText,
        authenticationButtonOnPressed,
        cancelButtonOnPressed,
        emailInputFieldOnChanged,
        passwordInputFieldOnChanged));

    await tester.pump();

    expect(find.byWidgetPredicate(loadingAnimation), findsOneWidget);
  });

  testWidgets('isLoading is true', (WidgetTester tester) async {
    final WidgetPredicate loadingAnimation = (Widget widget) =>
        widget is LoadingAnimation && widget.isLoading == true;

    await tester.pumpWidget(buildAuthenticationView(
        true,
        authenticateButtonText,
        authenticationButtonOnPressed,
        cancelButtonOnPressed,
        emailInputFieldOnChanged,
        passwordInputFieldOnChanged));

    await tester.pump();

    expect(find.byWidgetPredicate(loadingAnimation), findsOneWidget);
  });
}
