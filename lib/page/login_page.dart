import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_flutter_app/blocs/login/login_bloc.dart';
import 'package:social_flutter_app/repository/user_repository.dart';
import 'package:social_flutter_app/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(),
      ),
    );
  }
}