import 'package:components/components/warning_dialog.dart';
import 'package:flash_chat_core/utils/form_validation_utils.dart';
import 'package:flash_chat_core/views/home/bloc/home_bloc.dart';
import 'package:flash_chat_core/views/home/bloc/home_event.dart';
import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:views/views/authentication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The register view implementation
class Register extends StatelessWidget {
  final _emailInputFieldfTextEditingController = TextEditingController();

  final _passwordInputFieldTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _registerBloc = BlocProvider.of<RegisterBloc>(context);

    final _homeBloc = BlocProvider.of<HomeBloc>(context);

    return AuthenticationView(
      isLoading: _registerBloc.state is RegisterValidateInProgress,
      authenticationButtonText: 'Register',
      authenticationButtonOnPressed: () =>
          _registerButtonOnPressed(context, _registerBloc),
      cancelButtonOnPressed: () => _homeBloc.add(CancelButtonPressed()),
      emailInputFieldOnChanged: (String v) {
        _registerFieldOnChanged(_registerBloc);
      },
      passwordInputFieldOnChanged: (String v) {
        _registerFieldOnChanged(_registerBloc);
      },
      emailInputFieldfTextEditingController:
          _emailInputFieldfTextEditingController,
      passwordInputFieldTextEditingController:
          _passwordInputFieldTextEditingController,
    );
  }

  void _registerFieldOnChanged(RegisterBloc registerBloc) {
    registerBloc.add(RegisterChanged(
        email: _emailInputFieldfTextEditingController.text,
        password: _passwordInputFieldTextEditingController.text));
  }

  void _registerButtonOnPressed(
      BuildContext context, RegisterBloc registerBloc) {
    if (!isValidEmail(_emailInputFieldfTextEditingController.text)) {
      showWarningDialog(context, Warnings.invalidEmail);
    } else if (!isValidPassword(
        _passwordInputFieldTextEditingController.text)) {
      showWarningDialog(context, Warnings.invalidPassword);
    } else if (registerBloc.state == RegisterFillSuccess(error: null)) {
      registerBloc.add(RegisterSubmitted(
          email: _emailInputFieldfTextEditingController.text,
          password: _passwordInputFieldTextEditingController.text));
    }
  }
}
