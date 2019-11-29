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

      homeBloc.dispatch(LoginButtonPressed());
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

      homeBloc.dispatch(RegisterButtonPressed());
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

      homeBloc.dispatch(LoginButtonPressed());
      homeBloc.dispatch(CancelButtonPressed());
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

      homeBloc.dispatch(RegisterButtonPressed());
      homeBloc.dispatch(CancelButtonPressed());
    });
  });
}
