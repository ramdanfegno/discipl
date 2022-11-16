import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:habitoz_fitness_app/models/login_response.dart';
import '../../repositories/user_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial());

  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    print('mapEventToState');
    if (event is AuthenticationStarted) {
      print('mapEventToState');
      yield* _mapAuthenticationStartedToState();
    }
    else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    }
    else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
    else if (event is AuthenticationSkip) {
      yield* _mapAuthenticationSkipToState();
    }
  }


  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    try{
      yield AuthenticationOnLoading();
      bool? isLogged = await _userRepository.isLogged();
      bool? isGuest = await _userRepository.isGuest();
      LoginResponse? userData = await _userRepository.getLoginResponse();

      if(isLogged!){
        // also need to check if token expired
        // if expired yield authFailed

        if(userData != null && userData.token != null){
          yield AuthenticationSuccess();
        }
        else{
          yield const AuthenticationFailure(message: 'Token Expired');
        }
      }
      else{
        //check if guest
        if(isGuest!){
          //guest
          yield AuthenticationGuest();
        }
        else{
          //new user
          yield const AuthenticationFailure(message: 'Unauthenticated');
        }
      }
    }
    catch(e){
      print(e.toString());
      yield AuthenticationFailure(message: e.toString());
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    try{
      _userRepository.setGuestFlag(false);
      _userRepository.setIsLogged(true);
      yield AuthenticationSuccess();
    }
    catch(e){
      yield AuthenticationFailure(message: 'AuthenticationFailure: ${e.toString()}');
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationOnLoading();
    Response? response = await _userRepository.logOut();
    _userRepository.clear();
    _userRepository.setIsLogged(false);
    _userRepository.setGuestFlag(false);
    if (response!.statusCode == 200) {
      yield const AuthenticationFailure(message: ' AuthenticationFailure');
    }
  }

  Stream<AuthenticationState> _mapAuthenticationSkipToState() async* {
    _userRepository.setGuestFlag(true);
    _userRepository.setIsLogged(false);
    yield AuthenticationGuest();
  }
}
