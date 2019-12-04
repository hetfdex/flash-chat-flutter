import 'package:bloc/bloc.dart';
import 'package:flash_chat_core/views/home/bloc/bloc.dart';
import 'package:flash_chat_core/views/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../../test_debugger_bloc_delegate.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeTest',
      home: BlocBuilder<HomeBloc, HomeState>(
        bloc: BlocProvider.of<HomeBloc>(context),
        builder: (BuildContext context, HomeState state) {
          return Home();
        },
      ),
    );
  }
}

void main() {
  final testDebuggerBlocDelegate = TestDebuggerBlocDelegate();

  BlocSupervisor.delegate = testDebuggerBlocDelegate;

  Widget buildHome() {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc(),
      child: HomeWrapper(),
    );
  }

  testWidgets('builds widget', (WidgetTester tester) async {
    await tester.pumpWidget(buildHome());

    await tester.pump();

    expect(find.byType(Home), findsOneWidget);
  });

  testWidgets('login tap calls event', (WidgetTester tester) async {
    await tester.pumpWidget(buildHome());

    await tester.pump();

    await tester.tap(find.text('Login'));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'LoginButtonPressed');
  });

  testWidgets('register tap calls event', (WidgetTester tester) async {
    await tester.pumpWidget(buildHome());

    await tester.pump();

    await tester.tap(find.text('Register'));

    await tester.pump();

    expect(testDebuggerBlocDelegate.lastEvent, 'RegisterButtonPressed');
  });
}
