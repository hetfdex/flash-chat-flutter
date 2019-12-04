import 'package:bloc/bloc.dart';
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

  testWidgets('builds widget', (WidgetTester tester) async {
    await tester.pumpWidget(buildLogin());

    await tester.pump();

    expect(find.byType(Login), findsOneWidget);
  });
}
