import 'package:bloc/bloc.dart';
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

  testWidgets('builds widget', (WidgetTester tester) async {
    await tester.pumpWidget(buildRegister());

    await tester.pump();

    expect(find.byType(Register), findsOneWidget);
  });
}
