import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:social_flutter_app/blocs/authentication/authentication_event.dart';
import 'package:social_flutter_app/blocs/authentication/authentication_state.dart';
import 'package:social_flutter_app/page/home_page.dart';
import 'package:social_flutter_app/page/login_page.dart';
import 'package:social_flutter_app/repository/user_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserRepository userRepository = UserRepository();
  runApp(
      BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted()),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'social app',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is Authenticated) {
            return HomePage();
          }
          if (state is Unauthenticated) {
            return LoginPage();
          }
          return Container();
        },
      ),
    );
  }
}
