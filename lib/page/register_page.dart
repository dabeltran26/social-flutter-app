import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_flutter_app/blocs/register/register_bloc.dart';
import 'package:social_flutter_app/repository/user_repository.dart';
import 'package:social_flutter_app/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}