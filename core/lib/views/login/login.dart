import 'package:components/components/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/views/authentication_view.dart';

import '../../utils/utils.dart';
import '../../views/views.dart';

/// The login view implementation
class Login extends StatelessWidget {
  final _emailInputFieldfTextEditingController = TextEditingController();

  final _passwordInputFieldTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    final _homeBloc = BlocProvider.of<HomeBloc>(context);

    return AuthenticationView(
      isLoading: _loginBloc.state is LoginValidateInProgress,
      authenticationButtonText: 'Login',
      authenticationButtonOnPressed: () =>
          _loginButtonOnPressed(context, _loginBloc),
      cancelButtonOnPressed: () => _homeBloc.add(CancelButtonPressed()),
      emailInputFieldOnChanged: (v) {
        _loginFieldsOnChanged(_loginBloc);
      },
      passwordInputFieldOnChanged: (v) {
        _loginFieldsOnChanged(_loginBloc);
      },
      emailInputFieldfTextEditingController:
          _emailInputFieldfTextEditingController,
      passwordInputFieldTextEditingController:
          _passwordInputFieldTextEditingController,
    );
  }

  void _loginFieldsOnChanged(LoginBloc loginBloc) {
    loginBloc.add(LoginChanged(
        email: _emailInputFieldfTextEditingController.text,
        password: _passwordInputFieldTextEditingController.text));
  }

  void _loginButtonOnPressed(BuildContext context, LoginBloc loginBloc) {
    if (!isValidEmail(_emailInputFieldfTextEditingController.text)) {
      showWarningDialog(context, Warnings.invalidEmail);
    } else if (!isValidPassword(
        _passwordInputFieldTextEditingController.text)) {
      showWarningDialog(context, Warnings.invalidPassword);
    } else if (loginBloc.state == LoginFillSuccess(error: null)) {
      loginBloc.add(LoginSubmitted(
          email: _emailInputFieldfTextEditingController.text,
          password: _passwordInputFieldTextEditingController.text));
    }
  }
}
