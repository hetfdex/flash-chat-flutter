import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/authentication_bloc.dart';
import 'package:flash_chat_core/flash_chat_app.dart';
import 'package:flash_chat_core/helpers/debugger_bloc_delegate.dart';
import 'package:flash_chat_core/repositories/document_repository.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:flash_chat_core/views/home/bloc/bloc.dart';
import 'package:flash_chat_core/views/login/bloc/login_bloc.dart';
import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  BlocSupervisor.delegate = DebuggerBlocDelegate();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final Firestore firestore = Firestore.instance;

  const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  final SecureStorageUtils secureStorageUtils =
      SecureStorageUtils(flutterSecureStorage);

  final UserRepository userRepository =
      UserRepository(firebaseAuth, secureStorageUtils);

  final DocumentRepository documentRepository =
      DocumentRepository(firestore, secureStorageUtils);

  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(userRepository);

  final HomeBloc homeBloc = HomeBloc();

  final LoginBloc loginBloc = LoginBloc(userRepository, authenticationBloc);

  final RegisterBloc registerBloc =
      RegisterBloc(userRepository, authenticationBloc);

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
        BlocProvider<HomeBloc>(
          builder: (BuildContext context) => homeBloc,
        ),
        BlocProvider<LoginBloc>(
          builder: (BuildContext context) => loginBloc,
        ),
        BlocProvider<RegisterBloc>(
          builder: (BuildContext context) => registerBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          builder: (BuildContext context) => authenticationBloc,
        ),
      ],
      child: FlashChatApp(),
    ),
  ));
}
