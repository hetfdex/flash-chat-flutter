import 'package:bloc/bloc.dart';

class TestDebuggerBlocDelegate extends BlocDelegate {
  String lastEvent;

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object event) {
    super.onEvent(bloc, event);
    lastEvent = event.toString();
  }
}
