import 'dart:async';
import 'package:flash_chat_views/views/authentication_view.dart';
import 'package:flash_chat_views/views/chat_view.dart';
import 'package:flash_chat_views/views/home_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Chat Views Gallery',
      home: Gallery(),
    );
  }
}

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const int view =
        3; //0 == Homeview, 1 == LoginView, 2 == RegisterView, 3 == ChatView

    if (view == 0) {
      return HomeView(
          loginButtonOnPressed: () {}, registerButtonOnPressed: () {});
    } else if (view == 1) {
      return AuthenticationView(
          isLoading: false,
          authenticateButtonText: 'Login',
          authenticationButtonOnPressed: () {},
          cancelButtonOnPressed: () {},
          emailInputFieldOnChanged: (String v) {},
          passwordInputFieldOnChanged: (String v) {});
    } else if (view == 2) {
      return AuthenticationView(
          isLoading: true,
          authenticateButtonText: 'Register',
          authenticationButtonOnPressed: () {},
          cancelButtonOnPressed: () {},
          emailInputFieldOnChanged: (String v) {},
          passwordInputFieldOnChanged: (String v) {});
    } else if (view == 3) {
      final StreamController<String> streamController =
          StreamController<String>();

      final Stream<String> stream = streamController.stream;

      final Function(BuildContext, AsyncSnapshot<dynamic>) builder =
          (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Container();
      };

      return ChatView(
          closeButtonOnPressed: () {},
          messageInputFieldOnChanged: (String v) {},
          sendButtonOnPressed: () {},
          messageStream: stream,
          messageBuilder: builder,
          textEditingController: TextEditingController());
    } else {
      return Scaffold();
    }
  }
}
