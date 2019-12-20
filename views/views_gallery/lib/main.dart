import 'dart:async';
import 'package:views/views/authentication_view.dart';
import 'package:views/views/chat_view.dart';
import 'package:views/views/home_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(ViewsGallery());

/// The views gallery entry point
class ViewsGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Chat Views Gallery',
      home: Gallery(),
    );
  }
}

/// A gallery for views
class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const view =
        3; //0 == Homeview, 1 == LoginView, 2 == RegisterView, 3 == ChatView

    final textEditingController = TextEditingController();

    if (view == 0) {
      return HomeView(
          loginButtonOnPressed: () {}, registerButtonOnPressed: () {});
    } else if (view == 1) {
      return AuthenticationView(
        isLoading: false,
        authenticationButtonText: 'Login',
        authenticationButtonOnPressed: () {},
        cancelButtonOnPressed: () {},
        emailInputFieldOnChanged: (String v) {},
        passwordInputFieldOnChanged: (String v) {},
        emailInputFieldfTextEditingController: textEditingController,
        passwordInputFieldTextEditingController: textEditingController,
      );
    } else if (view == 2) {
      return AuthenticationView(
        isLoading: true,
        authenticationButtonText: 'Register',
        authenticationButtonOnPressed: () {},
        cancelButtonOnPressed: () {},
        emailInputFieldOnChanged: (String v) {},
        passwordInputFieldOnChanged: (String v) {},
        emailInputFieldfTextEditingController: textEditingController,
        passwordInputFieldTextEditingController: textEditingController,
      );
    } else if (view == 3) {
      final streamController = StreamController<String>();

      final stream = streamController.stream;

      builder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Container();
      }

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
