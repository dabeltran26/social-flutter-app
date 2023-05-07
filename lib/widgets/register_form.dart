import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:social_flutter_app/blocs/authentication/authentication_event.dart';
import 'package:social_flutter_app/blocs/register/register_bloc.dart';
import 'package:social_flutter_app/blocs/register/register_event.dart';
import 'package:social_flutter_app/blocs/register/register_state.dart';
import 'package:social_flutter_app/common/colors.dart';
import 'package:social_flutter_app/common/text_style.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
        if (state.isSubmitting) {
          print('Cargando');
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          print('Error');
        }
      }, child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          final padding = MediaQuery.of(context).size;
          return Padding(
            padding:EdgeInsets.only(top: padding.height*0.2),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Registrate',
                      style: GeneralTextStyles.tittleBold
                          .copyWith(color: Colors.black, fontSize: 36),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), labelText: 'Password'),
                    obscureText: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    child: Container(
                        width: padding.width * 0.5,
                        height: padding.height * 0.06,
                        child: Center(child: Text('Registrarme'))),
                    onTap: _onFormSubmitted,
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }

  void _onEmailChanged() {
    _registerBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _registerBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(Submitted(
        email: _emailController.text, password: _passwordController.text));
  }
}
