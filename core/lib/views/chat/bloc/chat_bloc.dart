import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pointycastle/pointycastle.dart';

import '../../../authentication/authentication.dart';
import '../../../repositories/repositories.dart';
import '../../../utils/utils.dart';
import 'bloc.dart';

/// The chat bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  /// Constructs the chat bloc
  ChatBloc(this._secureStorageUtils, this._userRepository,
      this._documentRepository, this._authenticationBloc)
      : assert(_secureStorageUtils != null),
        assert(_userRepository != null),
        assert(_documentRepository != null),
        assert(_authenticationBloc != null),
        super(ChatInitial());

  final SecureStorageUtils _secureStorageUtils;

  final UserRepository _userRepository;

  final DocumentRepository _documentRepository;

  final AuthenticationBloc _authenticationBloc;

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
    } on Object catch (e) {
      yield ChatFillSuccess(error: e);
    }
  }

  Stream<ChatState> _mapCloseButtonPressedToState(
    CloseButtonPressed event,
  ) async* {
    _authenticationBloc.add(UserLoggedOut());

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
