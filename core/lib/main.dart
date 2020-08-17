import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'authentication/authentication.dart';
import 'flash_chat_app.dart';
import 'helpers/helpers.dart';
import 'repositories/repositories.dart';
import 'utils/utils.dart';
import 'views/views.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const flutterSecureStorage = FlutterSecureStorage();

  final firebaseAuth = FirebaseAuth.instance;

  final firestore = Firestore.instance;

  final secureStorageUtils = SecureStorageUtils(flutterSecureStorage);

  final userRepository = UserRepository(firebaseAuth, secureStorageUtils);

  final documentRepository = DocumentRepository(firestore);

  final authenticationBloc = AuthenticationBloc(userRepository)
    ..add(AppStarted());

  final homeBloc = HomeBloc();

  final loginBloc = LoginBloc(userRepository, authenticationBloc);

  final registerBloc = RegisterBloc(userRepository, authenticationBloc);

  final chatBloc = ChatBloc(secureStorageUtils, userRepository,
      documentRepository, authenticationBloc);

  Bloc.observer = DebuggerBlocDelegate();

  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(
    MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<UserRepository>.value(
          value: userRepository,
        ),
        RepositoryProvider<DocumentRepository>.value(
          value: documentRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider<Bloc<dynamic, dynamic>>>[
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<HomeBloc>(
            create: (context) => homeBloc,
          ),
          BlocProvider<LoginBloc>(
            create: (context) => loginBloc,
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => registerBloc,
          ),
          BlocProvider<ChatBloc>(
            create: (context) => chatBloc,
          ),
        ],
        child: FlashChatApp(),
      ),
    ),
  );
}
