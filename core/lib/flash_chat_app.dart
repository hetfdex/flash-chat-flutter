import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/authentication.dart';
import 'views/views.dart';

/// The flash chat app
class FlashChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
            return Chat();
          });
        } else {
          return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeViewActive) {
              return Home();
            }
            if (state is LoginViewActive) {
              return Login();
            }
            if (state is RegisterViewActive) {
              return Register();
            }
            return Scaffold();
          });
        }
      }),
    );
  }
}
