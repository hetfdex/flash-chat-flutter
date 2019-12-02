import 'package:flash_chat_core/views/home/bloc/bloc.dart';
import 'package:views/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The home view implementation
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeView(loginButtonOnPressed: () {
      BlocProvider.of<HomeBloc>(context).add(LoginButtonPressed());
    }, registerButtonOnPressed: () {
      BlocProvider.of<HomeBloc>(context).add(RegisterButtonPressed());
    });
  }
}
