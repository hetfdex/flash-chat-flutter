import 'package:bloc_test/bloc_test.dart';
import 'package:flash_chat_core/views/home/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  HomeBloc homeBloc;

  setUp(() {
    homeBloc = HomeBloc();
  });

  tearDown(() {
    homeBloc?.close();
  });

  test('initial state is correct', () {
    expect(homeBloc.state, HomeViewActive());
  });

  group('LoginButtonPressed', () {
    blocTest(
      'emits [HomeViewActive, LoginViewActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) => homeBloc.add(LoginButtonPressed()),
      expect: [
        HomeViewActive(),
        LoginViewActive(),
      ],
    );
  });

  group('RegisterButtonPressed', () {
    blocTest(
      'emits [HomeViewActive, RegisterViewActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) => homeBloc.add(RegisterButtonPressed()),
      expect: [
        HomeViewActive(),
        RegisterViewActive(),
      ],
    );
  });
  group('CancelButtonPressed', () {
    blocTest(
      'emits [HomeViewActive, LoginViewActive, HomeViewActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) {
        homeBloc.add(LoginButtonPressed());
        homeBloc.add(CancelButtonPressed());

        return;
      },
      expect: [
        HomeViewActive(),
        LoginViewActive(),
        HomeViewActive(),
      ],
    );

    blocTest(
      'emits [HomeViewActive, RegisterViewActive, HomeViewActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) {
        homeBloc.add(RegisterButtonPressed());
        homeBloc.add(CancelButtonPressed());

        return;
      },
      expect: [
        HomeViewActive(),
        RegisterViewActive(),
        HomeViewActive(),
      ],
    );
  });
}
