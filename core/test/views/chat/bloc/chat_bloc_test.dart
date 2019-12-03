import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/repositories/document_repository.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:flash_chat_core/views/chat/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SecureStorageUtilsMock extends Mock implements SecureStorageUtils {}

class UserRepositoryMock extends Mock implements UserRepository {}

class DocumentRepositoryMock extends Mock implements DocumentRepository {}

class FirebaseUserMock extends Mock implements FirebaseUser {
  @override
  String get email => 'email';
}

void main() {
  const message = 'message';

  final FirebaseUser firebaseUser = FirebaseUserMock();

  SecureStorageUtils secureStorageUtils;

  UserRepository userRepository;

  DocumentRepository documentRepository;

  ChatBloc chatBloc;

  setUp(() {
    secureStorageUtils = SecureStorageUtilsMock();

    userRepository = UserRepositoryMock();

    documentRepository = DocumentRepositoryMock();

    chatBloc = ChatBloc(secureStorageUtils, userRepository, documentRepository);
  });

  tearDown(() {
    chatBloc?.close();
  });

  group('constructor', () {
    test('null secureStorageUtils throws error', () {
      expect(() => ChatBloc(null, userRepository, documentRepository),
          throwsAssertionError);
    });

    test('null userRepository throws error', () {
      expect(() => ChatBloc(secureStorageUtils, null, documentRepository),
          throwsAssertionError);
    });

    test('null documentRepository throws error', () {
      expect(() => ChatBloc(secureStorageUtils, userRepository, null),
          throwsAssertionError);
    });
  });

  test('initial state is correct', () {
    expect(chatBloc.initialState, ChatInitial());
  });

  group('ChatChanged', () {
    blocTest(
      'emits [ChatInitial, ChatFillInProgress] when message is null',
      build: () {
        return chatBloc;
      },
      act: (chatBloc) => chatBloc.add(ChatChanged(null)),
      expect: [
        ChatInitial(),
        ChatFillInProgress(),
      ],
    );

    blocTest(
      'emits [ChatInitial, ChatFillInProgress] when message is empty',
      build: () {
        return chatBloc;
      },
      act: (chatBloc) => chatBloc.add(ChatChanged('')),
      expect: [
        ChatInitial(),
        ChatFillInProgress(),
      ],
    );

    blocTest(
      'emits [ChatInitial, ChatFillSuccess] when message is valid',
      build: () {
        return chatBloc;
      },
      act: (chatBloc) => chatBloc.add(ChatChanged(message)),
      expect: [
        ChatInitial(),
        ChatFillSuccess(null),
      ],
    );
  });

  group('ChatSubmitted', () {
    blocTest(
      'emits [ChatInitial, ChatEncryptionInProgress, ChatInitial] when message is  valid',
      build: () {
        const privateKeyPEM =
            '-----BEGIN PRIVATE KEY-----\r\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDDXIUAeDtvNAJAh+tyg/xZEyZlugxRht3+Fzx1TceJsgScFhFa9CNn+6Jto+0BDXQnX8qaNDRNnqOeUSaw97VfnW/oM3GoYbdr15WxIauJhnbXSxDnajdKkYPE6s5acPmazRolJX8XNqqbptbRTb+oSZjExMMKQwZ+u1UQSTU1SfPa0OTMjsMCHksrKfJctc6DJ83828Jer9k+AkkIvmJiZq+GR3Cl/FySkqWUc7ovIeCnTLdnKeH1JmKc/Dnym/q/1tD9RKVNfTMfC5Sc12JKFSExHOC1dWyVRHcr31HiLykos2kneDJeMXkNBsanIaMDU6nR8uF5Qx42RN4um7xNAgMBAAECggEBAJy3cmY/DQaXBRt5LXIO2PcnuoyuY8Ve2GRFhZVgUKpv6OzBcyiwYlq+7LzhXHWUslIHsQJk0HRXx09wMAaUn6XVKPlvk0SNJtPW/Fk89lt7R4hLyoKpnTMvajIkXmcE6+a3k7qqyrn3e4Mjon4CzbWVXHy0jvWDcQlnA8TtxUY54+Qcat8P6oASgFfiadIzdJfB3Pp1AdEh/Px8EMfM29HbRLiBS0PnTcRZPw9A5PFeFFWKFNMdrsFpXPImuybZENXCm9AZnRDcSQMHMUHflYMnts05or0d1aKTwZ+Ql7o6vikE5hhBDsXBVTClQjL+ciCMkRXQGER79g3dHZx1ei0CgYEA/69ueTJzHzCCBaQmeJ2XnijIl3+XXUnJWNn+8JuXd6xPAAEoc7moS6nmX/0o2UvaB3zvVxbYh9sSh857fu/T524zrUMJFVNCZarC/kQO4pBcfOcvDJLsC+3r+/aa6/ltF57/m6648b20XtmIuVcM/SBTeI3ZLU0Se+LCg35KQp8CgYEAw5oUWBj90R07hiDLwFmjS6PkoGIOkmLToIgKqbFZmYAhEjCuLKR7cRihvL+E3NDSEXey5+MdG8wUICtFkMpJFSGULEyPv76BKpIUGnGw6NpG76cw3bqXWWB0aAubtdE3jlPinx0yRduKJJZ0z4OHHiMWs2AEEs1WYlLK5YSZpZMCgYACAVw6cxzYB8ddR/ZNR98ijGtWVNfZEXUUz1DijjXX6HAOLfQlRDV/smtuIUwquB+To3U1F6bHGf7BNeteCX999y1MlJQDqM2Cgp5Y5CvBtyQijqWd0aEsTsdlCIAajbA/WS3kCLDGpJg/jjE2Uup1KcW90k77vfkBI7wmz9zBPQKBgEwvWTkvEr0+O470eyfCQh4WCdiGGNLfdzoRgsWxdAqbo0XofA6bShE03NodZmxzUT7IdoBnL1FCXZxh/kh04Z4/Y+0VLPAsDTc9imL6YUNwsSxq3Fegc462SOC1lMJuaMsg1SXQQ2J+LgIuL/Ubb6dHV3IqNav1Gm5VfP2EdivNAoGAZoNeXk9xTTRFZdYQ9nO3FZdcfK7Zul0C0syhJDQxQuXmK3syFGhehIPqrFJxBe7RO0VmM4UTpDH0/UoJICxvWMhBJW4PxcNsdVhDL6ChyGWY1sawPsQ7KYdXe925k5fWXrrmlnAeIg3h0V/5+21XpllxcpSYrnm+JZtSW+uMF78=\r\n-----END PRIVATE KEY-----';

        when(userRepository.user)
            .thenAnswer((_) => Future<FirebaseUser>.value(firebaseUser));

        when(secureStorageUtils.getPrivateKey('email'))
            .thenAnswer((_) => Future<String>.value(privateKeyPEM));

        when(documentRepository.postMesssage(message: anyNamed(message)))
            .thenAnswer((_) => Future<void>.value());

        return chatBloc;
      },
      act: (chatBloc) => chatBloc.add(ChatSubmitted(message)),
      expect: [
        ChatInitial(),
        ChatEncryptionInProgress(),
        ChatInitial(),
      ],
    );

    final error = Error();

    blocTest(
      'emits [ChatInitial, ChatEncryptionInProgress, LoginFormFillSuccess] on caught error',
      build: () {
        when(userRepository.user).thenAnswer((_) => Future.error(error));

        return chatBloc;
      },
      act: (chatBlock) => chatBlock.add(ChatSubmitted(message)),
      expect: [
        ChatInitial(),
        ChatEncryptionInProgress(),
        ChatFillSuccess(error),
      ],
    );
  });

  group('CloseButtonPressed', () {
    blocTest(
      'emits [ChatInitial, ChatFillInProgress, ChatInitial]',
      build: () {
        return chatBloc;
      },
      act: (chatBloc) {
        chatBloc.add(ChatChanged(null));
        chatBloc.add(CloseButtonPressed());

        return;
      },
      expect: [
        ChatInitial(),
        ChatFillInProgress(),
        ChatInitial(),
      ],
    );
  });
}
