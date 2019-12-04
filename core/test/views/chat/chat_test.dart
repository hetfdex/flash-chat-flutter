import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/repositories/document_repository.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:flash_chat_core/views/chat/bloc/bloc.dart';
import 'package:flash_chat_core/views/chat/chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../../test_debugger_bloc_delegate.dart';

class ChatWrapper extends StatelessWidget {
  const ChatWrapper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatTest',
      home: BlocBuilder<ChatBloc, ChatState>(
        bloc: BlocProvider.of<ChatBloc>(context),
        builder: (BuildContext context, ChatState state) {
          return Chat();
        },
      ),
    );
  }
}

void main() {
  final testDebuggerBlocDelegate = TestDebuggerBlocDelegate();

  BlocSupervisor.delegate = testDebuggerBlocDelegate;

  final firebaseAuth = FirebaseAuth.instance;

  final firestore = Firestore.instance;

  final flutterSecureStorage = FlutterSecureStorage();

  final secureStorageUtils = SecureStorageUtils(flutterSecureStorage);

  final userRepository = UserRepository(firebaseAuth, secureStorageUtils);

  final documentRepository = DocumentRepository(firestore);

  Widget buildChat() {
    return BlocProvider<ChatBloc>(
      create: (BuildContext context) =>
          ChatBloc(secureStorageUtils, userRepository, documentRepository),
      child: ChatWrapper(),
    );
  }

  testWidgets('builds widget with no event or state',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildChat());

    await tester.pump();

    expect(find.byType(Chat), findsOneWidget);
    expect(testDebuggerBlocDelegate.lastEvent, null);
    expect(testDebuggerBlocDelegate.currentState, null);
    expect(testDebuggerBlocDelegate.nextState, null);
  });

  testWidgets('close tap calls event', (WidgetTester tester) async {
    await tester.pumpWidget(buildChat());

    await tester.pump();

    await tester.tap(find.byType(IconButton));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'CloseButtonPressed');
    expect(testDebuggerBlocDelegate.currentState, null);
    expect(testDebuggerBlocDelegate.nextState, null);
  });

  testWidgets('message input calls event and changes state',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildChat());

    await tester.pump();

    await tester.enterText(find.byType(TextField), 'test');

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'ChatChanged');
    expect(testDebuggerBlocDelegate.currentState, 'ChatInitial');
    expect(testDebuggerBlocDelegate.nextState, 'ChatFillSuccess');
  });

  testWidgets('message input and tap calls event and changes state',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildChat());

    await tester.pump();

    await tester.enterText(find.byType(TextField), 'test');

    await tester.pump();

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'ChatSubmitted');
    expect(testDebuggerBlocDelegate.currentState, 'ChatFillSuccess');
    expect(testDebuggerBlocDelegate.nextState, 'ChatEncryptionInProgress');
  });
}
