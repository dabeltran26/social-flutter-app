import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_flutter_app/blocs/login/login_event.dart';
import 'package:social_flutter_app/blocs/login/login_state.dart';
import 'package:social_flutter_app/repository/user_repository.dart';
import 'package:social_flutter_app/utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {

  final UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
  :assert (userRepository != null),
  _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();


  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is EmailChanged){
      yield* _mapEmailChangedToState(event.email);
    }
    if(event is PasswordChanged){
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is LoginWithCredentials) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email,
          password: event.password
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async*{
    yield state.update(
        isEmailValid: Validators.isValidEmail(email)
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async*{
    yield state.update(
        isPasswordValid: Validators.isValidPassword(password)
    );
  }


  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email, String password
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

}