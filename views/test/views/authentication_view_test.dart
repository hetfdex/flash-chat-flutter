import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:views/views/authentication_view.dart';
import 'package:components/components/input_field.dart';
import 'package:components/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthenticationViewWrapper extends StatelessWidget {
  const AuthenticationViewWrapper(
      {this.isLoading,
      this.authenticationButtonText,
      this.authenticationButtonOnPressed,
      this.cancelButtonOnPressed,
      this.emailInputFieldOnChanged,
      this.passwordInputFieldOnChanged,
      this.emailInputFieldTextEditingController,
      this.passwordInputFieldTextEditingController});

  final bool isLoading;

  final String authenticationButtonText;

  final Function authenticationButtonOnPressed;

  final Function cancelButtonOnPressed;

  final Function emailInputFieldOnChanged;

  final Function passwordInputFieldOnChanged;

  final TextEditingController emailInputFieldTextEditingController;

  final TextEditingController passwordInputFieldTextEditingController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthenticationViewTest',
      home: AuthenticationView(
        isLoading: isLoading,
        authenticationButtonText: authenticationButtonText,
        authenticationButtonOnPressed: authenticationButtonOnPressed,
        cancelButtonOnPressed: cancelButtonOnPressed,
        emailInputFieldOnChanged: emailInputFieldOnChanged,
        passwordInputFieldOnChanged: passwordInputFieldOnChanged,
        emailInputFieldfTextEditingController:
            emailInputFieldTextEditingController,
        passwordInputFieldTextEditingController:
            passwordInputFieldTextEditingController,
      ),
    );
  }
}

void main() {
  const authenticationButtonText = 'authenticationButtonText';

  final emailInputFieldTextEditingController = TextEditingController();

  final passwordInputFieldTextEditingController = TextEditingController();

  String emailInput;
  String passwordInput;

  var authenticationButtonWasPressed = false;
  var cancelButtonWasPressed = false;

  authenticationButtonOnPressed() {
    authenticationButtonWasPressed = true;
  }

  cancelButtonOnPressed() {
    cancelButtonWasPressed = true;
  }

  emailInputFieldOnChanged(String v) {
    emailInput = v;
  }

  passwordInputFieldOnChanged(String v) {
    passwordInput = v;
  }

  loadingAnimationIsActive(Widget widget) =>
      widget is ModalProgressHUD && widget.inAsyncCall;

  Widget buildAuthenticationView({bool isLoading}) => AuthenticationViewWrapper(
        isLoading: isLoading,
        authenticationButtonText: authenticationButtonText,
        authenticationButtonOnPressed: authenticationButtonOnPressed,
        cancelButtonOnPressed: cancelButtonOnPressed,
        emailInputFieldOnChanged: emailInputFieldOnChanged,
        passwordInputFieldOnChanged: passwordInputFieldOnChanged,
        emailInputFieldTextEditingController:
            emailInputFieldTextEditingController,
        passwordInputFieldTextEditingController:
            passwordInputFieldTextEditingController,
      );

  group('constructor', () {
    test('null isLoading throws error', () {
      expect(
          () => AuthenticationView(
                isLoading: null,
                authenticationButtonText: authenticationButtonText,
                authenticationButtonOnPressed: authenticationButtonOnPressed,
                cancelButtonOnPressed: cancelButtonOnPressed,
                emailInputFieldOnChanged: emailInputFieldOnChanged,
                passwordInputFieldOnChanged: passwordInputFieldOnChanged,
                emailInputFieldfTextEditingController:
                    emailInputFieldTextEditingController,
                passwordInputFieldTextEditingController:
                    passwordInputFieldTextEditingController,
              ),
          throwsAssertionError);
    });
    test('null authenticationButtonText throws error', () {
      expect(
          () => AuthenticationView(
              isLoading: false,
              authenticationButtonText: null,
              authenticationButtonOnPressed: authenticationButtonOnPressed,
              cancelButtonOnPressed: cancelButtonOnPressed,
              emailInputFieldOnChanged: emailInputFieldOnChanged,
              passwordInputFieldOnChanged: passwordInputFieldOnChanged,
              emailInputFieldfTextEditingController:
                  emailInputFieldTextEditingController,
              passwordInputFieldTextEditingController:
                  passwordInputFieldTextEditingController),
          throwsAssertionError);
    });

    test('null authenticationButtonOnPressed throws error', () {
      expect(
          () => AuthenticationView(
              isLoading: false,
              authenticationButtonText: authenticationButtonText,
              authenticationButtonOnPressed: null,
              cancelButtonOnPressed: cancelButtonOnPressed,
              emailInputFieldOnChanged: emailInputFieldOnChanged,
              passwordInputFieldOnChanged: passwordInputFieldOnChanged,
              emailInputFieldfTextEditingController:
                  emailInputFieldTextEditingController,
              passwordInputFieldTextEditingController:
                  passwordInputFieldTextEditingController),
          throwsAssertionError);
    });
    test('null cancelButtonOnPressed throws error', () {
      expect(
          () => AuthenticationView(
              isLoading: false,
              authenticationButtonText: authenticationButtonText,
              authenticationButtonOnPressed: authenticationButtonOnPressed,
              cancelButtonOnPressed: null,
              emailInputFieldOnChanged: emailInputFieldOnChanged,
              passwordInputFieldOnChanged: passwordInputFieldOnChanged,
              emailInputFieldfTextEditingController:
                  emailInputFieldTextEditingController,
              passwordInputFieldTextEditingController:
                  passwordInputFieldTextEditingController),
          throwsAssertionError);
    });
    test('null emailInputFieldOnChanged throws error', () {
      expect(
          () => AuthenticationView(
              isLoading: false,
              authenticationButtonText: authenticationButtonText,
              authenticationButtonOnPressed: authenticationButtonOnPressed,
              cancelButtonOnPressed: cancelButtonOnPressed,
              emailInputFieldOnChanged: null,
              passwordInputFieldOnChanged: passwordInputFieldOnChanged,
              emailInputFieldfTextEditingController:
                  emailInputFieldTextEditingController,
              passwordInputFieldTextEditingController:
                  passwordInputFieldTextEditingController),
          throwsAssertionError);
    });

    test('null passwordInputFieldOnChanged throws error', () {
      expect(
          () => AuthenticationView(
              isLoading: false,
              authenticationButtonText: authenticationButtonText,
              authenticationButtonOnPressed: authenticationButtonOnPressed,
              cancelButtonOnPressed: cancelButtonOnPressed,
              emailInputFieldOnChanged: emailInputFieldOnChanged,
              passwordInputFieldOnChanged: null,
              emailInputFieldfTextEditingController:
                  emailInputFieldTextEditingController,
              passwordInputFieldTextEditingController:
                  passwordInputFieldTextEditingController),
          throwsAssertionError);
    });

    test('null emailInputFieldfTextEditingController throws error', () {
      expect(
          () => AuthenticationView(
              isLoading: false,
              authenticationButtonText: authenticationButtonText,
              authenticationButtonOnPressed: authenticationButtonOnPressed,
              cancelButtonOnPressed: cancelButtonOnPressed,
              emailInputFieldOnChanged: emailInputFieldOnChanged,
              passwordInputFieldOnChanged: passwordInputFieldOnChanged,
              emailInputFieldfTextEditingController: null,
              passwordInputFieldTextEditingController:
                  passwordInputFieldTextEditingController),
          throwsAssertionError);
    });

    test('null passwordInputFieldTextEditingController throws error', () {
      expect(
          () => AuthenticationView(
              isLoading: false,
              authenticationButtonText: authenticationButtonText,
              authenticationButtonOnPressed: authenticationButtonOnPressed,
              cancelButtonOnPressed: cancelButtonOnPressed,
              emailInputFieldOnChanged: emailInputFieldOnChanged,
              passwordInputFieldOnChanged: passwordInputFieldOnChanged,
              emailInputFieldfTextEditingController:
                  emailInputFieldTextEditingController,
              passwordInputFieldTextEditingController: null),
          throwsAssertionError);
    });
  });

  testWidgets('builds widget with false isLoading',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildAuthenticationView(isLoading: false));

    await tester.pump();

    expect(find.byType(AuthenticationView), findsOneWidget);
    expect(find.byType(ModalProgressHUD), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(InputField), findsNWidgets(2));
    expect(find.byType(RoundedButton), findsNWidgets(2));
    expect(find.byWidgetPredicate(loadingAnimationIsActive), findsNothing);
  });

  testWidgets('builds widget with true isLoading', (WidgetTester tester) async {
    await tester.pumpWidget(buildAuthenticationView(isLoading: true));

    await tester.pump();

    expect(find.byType(AuthenticationView), findsOneWidget);
    expect(find.byType(ModalProgressHUD), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(InputField), findsNWidgets(2));
    expect(find.byType(RoundedButton), findsNWidgets(2));
    expect(find.byWidgetPredicate(loadingAnimationIsActive), findsOneWidget);
  });

  testWidgets('authenticationButton tap calls onPressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildAuthenticationView(isLoading: false));

    await tester.pump();

    await tester.tap(find.text(authenticationButtonText));

    await tester.pump();

    expect(authenticationButtonWasPressed, true);
  });

  testWidgets('cancelButton tap calls onPressed', (WidgetTester tester) async {
    await tester.pumpWidget(buildAuthenticationView(isLoading: false));

    await tester.pump();

    await tester.tap(find.text('Cancel'));

    await tester.pump();

    expect(cancelButtonWasPressed, true);
  });

  testWidgets('email input calls onChanged', (WidgetTester tester) async {
    emailInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter email';

    const emailInputText = 'emailInputText';

    await tester.pumpWidget(buildAuthenticationView(isLoading: false));

    await tester.pump();

    await tester.enterText(
        find.byWidgetPredicate(emailInputField), emailInputText);

    await tester.pump();

    expect(emailInput, emailInputText);
  });

  testWidgets('password input calls onChanged', (WidgetTester tester) async {
    passwordInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter password';

    const passwordInputText = 'passwordInputText';

    await tester.pumpWidget(buildAuthenticationView(isLoading: false));

    await tester.pump();

    await tester.enterText(
        find.byWidgetPredicate(passwordInputField), passwordInputText);

    await tester.pump();

    expect(passwordInput, passwordInputText);
  });
}
