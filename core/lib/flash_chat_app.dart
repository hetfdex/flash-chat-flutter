import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/views/chat/bloc/bloc.dart';
import 'package:flash_chat_core/views/chat/bloc/chat_bloc.dart';
import 'package:flash_chat_core/views/chat/chat.dart';
import 'package:flash_chat_core/views/home/bloc/bloc.dart';
import 'package:flash_chat_core/views/home/home.dart';
import 'package:flash_chat_core/views/login/login.dart';
import 'package:flash_chat_core/views/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The flash chat app
class FlashChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationSuccess) {
          return BlocBuilder<ChatBloc, ChatState>(
              builder: (BuildContext context, ChatState state) {
            return Chat();
          });
        } else {
          return BlocBuilder<HomeBloc, HomeState>(
              builder: (BuildContext context, HomeState state) {
            if (state is HomeActive) {
              return Home();
            }
            if (state is LoginActive) {
              return Login();
            }
            if (state is RegisterActive) {
              return Register();
            }
            return Scaffold();
          });
        }
      }),
    );
  }
}
