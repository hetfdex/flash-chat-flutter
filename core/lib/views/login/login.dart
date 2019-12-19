import 'package:components/components/warning_dialog.dart';
import 'package:flash_chat_core/utils/form_validation_utils.dart';
import 'package:flash_chat_core/views/home/bloc/home_bloc.dart';
import 'package:flash_chat_core/views/home/bloc/home_event.dart';
import 'package:flash_chat_core/views/login/bloc/bloc.dart';
import 'package:views/views/authentication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String _email;
String _password;

/// The login view implementation
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    final _homeBloc = BlocProvider.of<HomeBloc>(context);

    return AuthenticationView(
        isLoading: _loginBloc.state is LoginValidateInProgress,
        authenticationButtonText: 'Login',
        authenticationButtonOnPressed: () {
          if (_loginBloc.state == LoginFillSuccess(error: null)) {
            _loginBloc.add(LoginSubmitted(email: _email, password: _password));
          } else {
            if (!isValidEmail(_email)) {
              showWarningDialog(context, Warnings.invalidEmail);
            } else if (!isValidPassword(_password)) {
              showWarningDialog(context, Warnings.invalidPassword);
            }
          }
        },
        cancelButtonOnPressed: () {
          _homeBloc.add(CancelButtonPressed());
        },
        emailInputFieldOnChanged: (String v) {
          _email = v;

          _loginFieldOnChanged(_loginBloc);
        },
        passwordInputFieldOnChanged: (String v) {
          _password = v;

          _loginFieldOnChanged(_loginBloc);
        });
  }

  void _loginFieldOnChanged(LoginBloc _loginBloc) {
    _loginBloc.add(LoginChanged(email: _email, password: _password));
  }
}
