import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/views/home_view.dart';

import '../../views/views.dart';

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
