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
    test('emits [HomeActive, LoginActive]', () {
      final List<HomeState> expectedResponse = <HomeState>[
        HomeActive(),
        LoginActive(),
      ];

      expectLater(
        homeBloc.state,
        emitsInOrder(expectedResponse),
      );

      homeBloc.add(LoginButtonPressed());
    });
  });

  group('RegisterButtonPressed', () {
    test('emits [HomeActive, RegisterActive]', () {
      final List<HomeState> expectedResponse = <HomeState>[
        HomeActive(),
        RegisterActive(),
      ];

      expectLater(
        homeBloc.state,
        emitsInOrder(expectedResponse),
      );

      homeBloc.add(RegisterButtonPressed());
    });
  });
  group('CancelButtonPressed', () {
    test('emits [HomeActive, LoginActive, HomeActive]', () {
      final List<HomeState> expectedResponse = <HomeState>[
        HomeActive(),
        LoginActive(),
        HomeActive(),
      ];

      expectLater(
        homeBloc.state,
        emitsInOrder(expectedResponse),
      );

      homeBloc.add(LoginButtonPressed());
      homeBloc.add(CancelButtonPressed());
    });

    test('emits [HomeActive, RegisterActive, HomeActive]', () {
      final List<HomeState> expectedResponse = <HomeState>[
        HomeActive(),
        RegisterActive(),
        HomeActive(),
      ];

      expectLater(
        homeBloc.state,
        emitsInOrder(expectedResponse),
      );

      homeBloc.add(RegisterButtonPressed());
      homeBloc.add(CancelButtonPressed());
    });
  });
}
