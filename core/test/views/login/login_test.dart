import 'package:bloc/bloc.dart';
import 'package:components/components/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:flash_chat_core/views/home/bloc/home_bloc.dart';
import 'package:flash_chat_core/views/login/bloc/bloc.dart';
import 'package:flash_chat_core/views/login/Login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../../test_debugger_bloc_delegate.dart';

class LoginWrapper extends StatelessWidget {
  const LoginWrapper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginTest',
      home: BlocBuilder<LoginBloc, LoginState>(
        bloc: BlocProvider.of<LoginBloc>(context),
        builder: (BuildContext context, LoginState state) {
          return Login();
        },
      ),
    );
  }
}

void main() {
  final testDebuggerBlocDelegate = TestDebuggerBlocDelegate();

  BlocSupervisor.delegate = testDebuggerBlocDelegate;

  final firebaseAuth = FirebaseAuth.instance;

  final flutterSecureStorage = FlutterSecureStorage();

  final secureStorageUtils = SecureStorageUtils(flutterSecureStorage);

  final userRepository = UserRepository(firebaseAuth, secureStorageUtils);

  final authenticationBloc = AuthenticationBloc(userRepository);

  Widget buildLogin() {
    return MultiBlocProvider(
      providers: <BlocProvider<Bloc<dynamic, dynamic>>>[
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) =>
              LoginBloc(userRepository, authenticationBloc),
        ),
      ],
      child: LoginWrapper(),
    );
  }

  testWidgets('builds widget with no event or state',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildLogin());

    await tester.pump();

    expect(find.byType(Login), findsOneWidget);
    expect(testDebuggerBlocDelegate.lastEvent, null);
    expect(testDebuggerBlocDelegate.currentState, null);
    expect(testDebuggerBlocDelegate.nextState, null);
  });

  testWidgets('login tap with no input does not call event or change state',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildLogin());

    await tester.pump();

    await tester.tap(find.text('Login'));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, null);
    expect(testDebuggerBlocDelegate.currentState, null);
    expect(testDebuggerBlocDelegate.nextState, null);
  });

  testWidgets('email input calls event and changes state',
      (WidgetTester tester) async {
    emailInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter email';

    await tester.pumpWidget(buildLogin());

    await tester.pump();

    await tester.enterText(find.byWidgetPredicate(emailInputField), 'test');

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'LoginChanged');
    expect(testDebuggerBlocDelegate.currentState, 'LoginInitial');
    expect(testDebuggerBlocDelegate.nextState, 'LoginFillInProgress');
  });

  testWidgets('password input calls event and changes state',
      (WidgetTester tester) async {
    passwordInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter password';

    await tester.pumpWidget(buildLogin());

    await tester.pump();

    await tester.enterText(find.byWidgetPredicate(passwordInputField), 'test');

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'LoginChanged');
    expect(testDebuggerBlocDelegate.currentState, 'LoginInitial');
    expect(testDebuggerBlocDelegate.nextState, 'LoginFillInProgress');
  });

  testWidgets('correct input calls event and changes state',
      (WidgetTester tester) async {
    emailInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter email';

    passwordInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter password';

    await tester.pumpWidget(buildLogin());

    await tester.pump();

    await tester.enterText(
        find.byWidgetPredicate(emailInputField), 'test@email.com');

    await tester.enterText(
        find.byWidgetPredicate(passwordInputField), 'Abcde12345@');

    await tester.pump();

    await tester.tap(find.text('Login'));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'LoginChanged');
    expect(testDebuggerBlocDelegate.currentState, 'LoginFillInProgress');
    expect(testDebuggerBlocDelegate.nextState, 'LoginFillSuccess');
  });

  testWidgets('cancel tap calls event and does not change state',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildLogin());

    await tester.pump();

    await tester.tap(find.text('Cancel'));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'CancelButtonPressed');
  });
}
