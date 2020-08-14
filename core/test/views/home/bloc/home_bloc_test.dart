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
      'emits [LoginViewActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) => homeBloc.add(LoginButtonPressed()),
      expect: [
        LoginViewActive(),
      ],
    );
  });

  group('RegisterButtonPressed', () {
    blocTest(
      'emits [RegisterViewActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) => homeBloc.add(RegisterButtonPressed()),
      expect: [
        RegisterViewActive(),
      ],
    );
  });
  group('CancelButtonPressed', () {
    blocTest(
      'emits [LoginViewActive, HomeViewActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) {
        homeBloc.add(LoginButtonPressed());
        homeBloc.add(CancelButtonPressed());

        return;
      },
      expect: [
        LoginViewActive(),
        HomeViewActive(),
      ],
    );

    blocTest(
      'emits [RegisterViewActive, HomeViewActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) {
        homeBloc.add(RegisterButtonPressed());
        homeBloc.add(CancelButtonPressed());

        return;
      },
      expect: [
        RegisterViewActive(),
        HomeViewActive(),
      ],
    );
  });
}
