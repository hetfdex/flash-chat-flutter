import 'package:equatable/equatable.dart';

/// The chat events
abstract class ChatEvent extends Equatable {
  /// Constructs the chat event
  const ChatEvent();
}

/// The chat submitted event
class ChatSubmitted extends ChatEvent {
  /// Constructs the chat submitted event
  const ChatSubmitted(this.message);

  /// The submited message
  final String message;

  @override
  String toString() => 'ChatSubmitted';

  @override
  List<Object> get props => <Object>[message];
}

/// The chat changed event
class ChatChanged extends ChatEvent {
  /// Constructs the chat changed event
  ChatChanged(this.message);

  /// The changed message
  final String message;

  @override
  String toString() => 'ChatChanged';

  @override
  List<Object> get props => <Object>[message];
}

/// The close button pressed event
class CloseButtonPressed extends ChatEvent {
  @override
  String toString() => 'CloseButtonPressed';

  @override
  List<Object> get props => null;
}
