import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flash_chat_core/repositories/document_repository.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/pem_utils.dart';
import 'package:flash_chat_core/utils/rsa_utils.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:flash_chat_core/views/chat/bloc/bloc.dart';
import 'package:pointycastle/pointycastle.dart';

/// The chat bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  /// Constructs the chat bloc
  ChatBloc(
      this._secureStorageUtils, this._userRepository, this._documentRepository)
      : assert(_secureStorageUtils != null),
        assert(_userRepository != null),
        assert(_documentRepository != null);

  final SecureStorageUtils _secureStorageUtils;

  final UserRepository _userRepository;

  final DocumentRepository _documentRepository;

  @override
  ChatState get initialState => ChatInitial();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatChanged) {
      yield* _mapChatChangedToState(event);
    } else if (event is ChatSubmitted) {
      yield* _mapChatSubmittedToState(event);
    } else if (event is CloseButtonPressed) {
      yield* _mapCloseButtonPressedToState(event);
    }
  }

  Stream<ChatState> _mapChatChangedToState(
    ChatChanged event,
  ) async* {
    yield _hasMessage(event.message)
        ? ChatFillSuccess(error: null)
        : ChatFillInProgress();
  }

  Stream<ChatState> _mapChatSubmittedToState(
    ChatSubmitted event,
  ) async* {
    yield ChatEncryptionInProgress();
    try {
      final user = await _userRepository.user;

      final privateKey = await _getPrivateKey(user.email);

      final encryptedMessage = encryptMessage(event.message, privateKey);

      _documentRepository.postMesssage(message: encryptedMessage);

      yield ChatInitial();
    } on Error catch (e) {
      yield ChatFillSuccess(error: e);
    }
  }

  Stream<ChatState> _mapCloseButtonPressedToState(
    CloseButtonPressed event,
  ) async* {
    yield ChatInitial();
  }

  bool _hasMessage(String message) {
    return message != null && message != '';
  }

  Future<RSAPrivateKey> _getPrivateKey(String email) async {
    final privateKeyPem = await _secureStorageUtils.getPrivateKey(email);

    return pemToPrivateKey(privateKeyPem);
  }
}
