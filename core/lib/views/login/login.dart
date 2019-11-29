import 'package:flash_chat_core/views/home/bloc/home_bloc.dart';
import 'package:flash_chat_core/views/home/bloc/home_event.dart';
import 'package:flash_chat_core/views/login/bloc/bloc.dart';
import 'package:flash_chat_views/views/authentication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String _email;
String _password;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    final HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);

    return AuthenticationView(
        isLoading: false,
        authenticateButtonText: 'Login',
        authenticationButtonOnPressed: () {
          if (_loginBloc.currentState == LoginFillSuccess()) {
            _loginBloc.dispatch(LoginSubmitted(_email, _password));
          }
        },
        cancelButtonOnPressed: () {
          _homeBloc.dispatch(CancelButtonPressed());
        },
        emailInputFieldOnChanged: (String v) {
          _email = v;

          loginFieldOnChanged(_loginBloc);
        },
        passwordInputFieldOnChanged: (String v) {
          _password = v;

          loginFieldOnChanged(_loginBloc);
        });
  }

  void loginFieldOnChanged(LoginBloc _loginBloc) {
    _loginBloc.dispatch(LoginChanged(_email, _password));
  }
}
