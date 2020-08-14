import 'package:bloc/bloc.dart';

class TestDebuggerBlocDelegate extends BlocObserver {
  String lastEvent;
  String currentState;
  String nextState;

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object event) {
    super.onEvent(bloc, event);
    lastEvent = event.toString();
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    currentState = transition.currentState.toString();
    nextState = transition.nextState.toString();
  }
}
