import 'package:bloc_test/bloc_test.dart';
import 'package:flash_chat_core/views/home/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  HomeBloc homeBloc;

  setUp(() {
    homeBloc = HomeBloc();
  });

  test('initial state is correct', () {
    expect(homeBloc.initialState, HomeActive());
  });

  group('LoginButtonPressed', () {
    blocTest(
      'emits [HomeActive, LoginActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) => homeBloc.add(LoginButtonPressed()),
      expect: [
        HomeActive(),
        LoginActive(),
      ],
    );
  });

  group('RegisterButtonPressed', () {
    blocTest(
      'emits [HomeActive, RegisterActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) => homeBloc.add(RegisterButtonPressed()),
      expect: [
        HomeActive(),
        RegisterActive(),
      ],
    );
  });
  group('CancelButtonPressed', () {
    blocTest(
      'emits [HomeActive, LoginActive, HomeActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) {
        homeBloc.add(LoginButtonPressed());
        homeBloc.add(CancelButtonPressed());

        return;
      },
      expect: [
        HomeActive(),
        LoginActive(),
        HomeActive(),
      ],
    );

    blocTest(
      'emits [HomeActive, RegisterActive, HomeActive]',
      build: () {
        return homeBloc;
      },
      act: (homeBloc) {
        homeBloc.add(RegisterButtonPressed());
        homeBloc.add(CancelButtonPressed());

        return;
      },
      expect: [
        HomeActive(),
        RegisterActive(),
        HomeActive(),
      ],
    );
  });
}
