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

  testWidgets('builds widget', (WidgetTester tester) async {
    await tester.pumpWidget(buildChat());

    await tester.pump();

    expect(find.byType(Chat), findsOneWidget);
  });
}
