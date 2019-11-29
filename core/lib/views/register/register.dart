import 'package:flash_chat_core/views/home/bloc/home_bloc.dart';
import 'package:flash_chat_core/views/home/bloc/home_event.dart';
import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:flash_chat_views/views/authentication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String _email;
String _password;

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegisterBloc _registerBloc = BlocProvider.of<RegisterBloc>(context);

    final HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);

    return AuthenticationView(
        isLoading: false,
        authenticateButtonText: 'Register',
        authenticationButtonOnPressed: () {
          if (_registerBloc.currentState == RegisterFillSuccess()) {
            _registerBloc.dispatch(RegisterSubmitted(_email, _password));
          }
        },
        cancelButtonOnPressed: () {
          _homeBloc.dispatch(CancelButtonPressed());
        },
        emailInputFieldOnChanged: (String v) {
          _email = v;

          registerFieldOnChanged(_registerBloc);
        },
        passwordInputFieldOnChanged: (String v) {
          _password = v;

          registerFieldOnChanged(_registerBloc);
        });
  }

  void registerFieldOnChanged(RegisterBloc _registerBloc) {
    _registerBloc.dispatch(RegisterChanged(_email, _password));
  }
}
