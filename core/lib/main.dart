import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/authentication_bloc.dart';
import 'package:flash_chat_core/flash_chat_app.dart';
import 'package:flash_chat_core/helpers/debugger_bloc_delegate.dart';
import 'package:flash_chat_core/repositories/document_repository.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:flash_chat_core/views/chat/bloc/chat_bloc.dart';
import 'package:flash_chat_core/views/home/bloc/bloc.dart';
import 'package:flash_chat_core/views/login/bloc/login_bloc.dart';
import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  BlocSupervisor.delegate = DebuggerBlocDelegate();

  const flutterSecureStorage = FlutterSecureStorage();

  final firebaseAuth = FirebaseAuth.instance;

  final firestore = Firestore.instance;

  final secureStorageUtils = SecureStorageUtils(flutterSecureStorage);

  final userRepository = UserRepository(firebaseAuth, secureStorageUtils);

  final documentRepository = DocumentRepository(firestore);

  final authenticationBloc = AuthenticationBloc(userRepository);

  final homeBloc = HomeBloc();

  final loginBloc = LoginBloc(userRepository, authenticationBloc);

  final registerBloc = RegisterBloc(userRepository, authenticationBloc);

  final chatBloc =
      ChatBloc(secureStorageUtils, userRepository, documentRepository);

  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  runApp(MultiRepositoryProvider(
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
          create: (BuildContext context) => authenticationBloc,
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => homeBloc,
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => loginBloc,
        ),
        BlocProvider<RegisterBloc>(
          create: (BuildContext context) => registerBloc,
        ),
        BlocProvider<ChatBloc>(
          create: (BuildContext context) => chatBloc,
        ),
      ],
      child: FlashChatApp(),
    ),
  ));
}
