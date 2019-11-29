import 'package:flash_chat_core/views/home/bloc/home_bloc.dart';
import 'package:flash_chat_core/views/home/bloc/home_event.dart';
import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:views/views/authentication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String _email;
String _password;

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _registerBloc = BlocProvider.of<RegisterBloc>(context);

    final _homeBloc = BlocProvider.of<HomeBloc>(context);

    return AuthenticationView(
        isLoading: false,
        authenticationButtonText: 'Register',
        authenticationButtonOnPressed: () {
          if (_registerBloc.state == RegisterFillSuccess()) {
            _registerBloc.add(RegisterSubmitted(_email, _password));
          }
        },
        cancelButtonOnPressed: () {
          _homeBloc.add(CancelButtonPressed());
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
    _registerBloc.add(RegisterChanged(_email, _password));
  }
}
