 import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:social_flutter_app/blocs/authentication/authentication_event.dart';
import 'package:social_flutter_app/blocs/authentication/authentication_state.dart';
import 'package:social_flutter_app/repository/user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{

  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
  : assert(userRepository != null),
  _userRepository = userRepository, super(null);
  
  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event)  async*{
    if(event is AppStarted){
      yield* _mapAppStartedToState();
    }

    if(event is LoggedIn){
      yield* _mapLoggedInToState();
    }

    if(event is LoggedOut){
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async*{
    try{
      final isSignedIn = await _userRepository.isSignedIn();
      if(isSignedIn){
        final user = await _userRepository.getUser();
        yield Authenticated(user);
      }
      else{
        yield Unauthenticated();
      }
    }catch(_){
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async*{
    final user = await _userRepository.getUser();
    yield Authenticated(user);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async*{
    yield Unauthenticated();
    _userRepository.singOut();
  }

}