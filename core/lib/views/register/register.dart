import 'package:flash_chat_core/utils/form_validation_utils.dart';
import 'package:flash_chat_core/views/dialogs/invalid_field_dialog.dart';
import 'package:flash_chat_core/views/home/bloc/home_bloc.dart';
import 'package:flash_chat_core/views/home/bloc/home_event.dart';
import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:views/views/authentication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String _email;
String _password;

/// The register view implementation
class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _registerBloc = BlocProvider.of<RegisterBloc>(context);

    final _homeBloc = BlocProvider.of<HomeBloc>(context);

    return AuthenticationView(
        isLoading: _registerBloc.state is RegisterValidateInProgress,
        authenticationButtonText: 'Register',
        authenticationButtonOnPressed: () {
          if (_registerBloc.state == RegisterFillSuccess(error: null)) {
            _registerBloc
                .add(RegisterSubmitted(email: _email, password: _password));
          } else {
            if (!isValidEmail(_email)) {
              showInvalidFieldDialog(context, InvalidField.email);
            } else if (!isValidPassword(_password)) {
              showInvalidFieldDialog(context, InvalidField.pasword);
            }
          }
        },
        cancelButtonOnPressed: () {
          _homeBloc.add(CancelButtonPressed());
        },
        emailInputFieldOnChanged: (String v) {
          _email = v;

          _registerFieldOnChanged(_registerBloc);
        },
        passwordInputFieldOnChanged: (String v) {
          _password = v;

          _registerFieldOnChanged(_registerBloc);
        });
  }

  void _registerFieldOnChanged(RegisterBloc _registerBloc) {
    _registerBloc.add(RegisterChanged(email: _email, password: _password));
  }
}
