import 'package:equatable/equatable.dart';

/// The chat states
abstract class ChatState extends Equatable {
  /// Constructs the chat state
  const ChatState();

  @override
  List<Object> get props => null;
}

/// The chat initial state
class ChatInitial extends ChatState {}

/// The chat fill success state
class ChatFillSuccess extends ChatState {
  /// The error thrown
  final Error error;

  /// Constructs the chat fill sucess state
  const ChatFillSuccess({this.error});

  @override
  List get props => [error];
}

/// The chat fill in progress state
class ChatFillInProgress extends ChatState {}

/// The chat encryption in progress state
class ChatEncryptionInProgress extends ChatState {}
