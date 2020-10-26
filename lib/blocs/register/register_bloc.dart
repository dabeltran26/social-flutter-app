import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_flutter_app/blocs/register/register_event.dart';
import 'package:social_flutter_app/blocs/register/register_state.dart';
import 'package:social_flutter_app/repository/user_repository.dart';
import 'package:social_flutter_app/utils/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async*{
    yield state.update(
      isEmailValid: Validators.isValidEmail(email)
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async*{
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password)
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String email, String password
  ) async*{
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email, password);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
  
}
