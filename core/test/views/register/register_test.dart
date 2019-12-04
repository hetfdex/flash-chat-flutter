import 'package:bloc/bloc.dart';
import 'package:components/components/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:flash_chat_core/views/home/bloc/home_bloc.dart';
import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:flash_chat_core/views/register/Register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../../test_debugger_bloc_delegate.dart';

class RegisterWrapper extends StatelessWidget {
  const RegisterWrapper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RegisterTest',
      home: BlocBuilder<RegisterBloc, RegisterState>(
        bloc: BlocProvider.of<RegisterBloc>(context),
        builder: (BuildContext context, RegisterState state) {
          return Register();
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

  Widget buildRegister() {
    return MultiBlocProvider(
      providers: <BlocProvider<Bloc<dynamic, dynamic>>>[
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (BuildContext context) =>
              RegisterBloc(userRepository, authenticationBloc),
        ),
      ],
      child: RegisterWrapper(),
    );
  }

  testWidgets('builds widget with no event or state',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildRegister());

    await tester.pump();

    expect(find.byType(Register), findsOneWidget);
    expect(testDebuggerBlocDelegate.lastEvent, null);
    expect(testDebuggerBlocDelegate.currentState, null);
    expect(testDebuggerBlocDelegate.nextState, null);
  });

  testWidgets('Register tap with no input does not call event or change state',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildRegister());

    await tester.pump();

    await tester.tap(find.text('Register'));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, null);
    expect(testDebuggerBlocDelegate.currentState, null);
    expect(testDebuggerBlocDelegate.nextState, null);
  });

  testWidgets('email input calls event and changes state',
      (WidgetTester tester) async {
    emailInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter email';

    await tester.pumpWidget(buildRegister());

    await tester.pump();

    await tester.enterText(find.byWidgetPredicate(emailInputField), 'test');

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'RegisterChanged');
    expect(testDebuggerBlocDelegate.currentState, 'RegisterInitial');
    expect(testDebuggerBlocDelegate.nextState, 'RegisterFillInProgress');
  });

  testWidgets('password input calls event and changes state',
      (WidgetTester tester) async {
    passwordInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter password';

    await tester.pumpWidget(buildRegister());

    await tester.pump();

    await tester.enterText(find.byWidgetPredicate(passwordInputField), 'test');

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'RegisterChanged');
    expect(testDebuggerBlocDelegate.currentState, 'RegisterInitial');
    expect(testDebuggerBlocDelegate.nextState, 'RegisterFillInProgress');
  });

  testWidgets('correct input calls event and changes state',
      (WidgetTester tester) async {
    emailInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter email';

    passwordInputField(Widget widget) =>
        widget is InputField && widget.hintText == 'Enter password';

    await tester.pumpWidget(buildRegister());

    await tester.pump();

    await tester.enterText(
        find.byWidgetPredicate(emailInputField), 'test@email.com');

    await tester.enterText(
        find.byWidgetPredicate(passwordInputField), 'Abcde12345@');

    await tester.pump();

    await tester.tap(find.text('Register'));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'RegisterChanged');
    expect(testDebuggerBlocDelegate.currentState, 'RegisterFillInProgress');
    expect(testDebuggerBlocDelegate.nextState, 'RegisterFillSuccess');
  });

  testWidgets('cancel tap calls event and does not change state',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildRegister());

    await tester.pump();

    await tester.tap(find.text('Cancel'));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'CancelButtonPressed');
  });
}
