/*
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

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
    if (event is AuthenticationStarted) {
      print('AuthenticationBloc AuthenticationStarted 1');
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      print('AuthenticationBloc AuthenticationLoggedIn 1');
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      print('AuthenticationBloc AuthenticationLoggedOut 1');
      yield* _mapAuthenticationLoggedOutToState();
    } else if (event is AuthenticationSkip) {
      print('AuthenticationBloc AuthenticationSkip 1');
      yield* _mapAuthenticationSkipToState();
    } else if (event is AuthenticationRetry) {
      print('AuthenticationBloc AuthenticationRetry 1');
      yield* _authRetry();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    bool? isLogged = await _userRepository.isLogged();
    UserData userData;
    // check if home api is called successfully
    if (response.statusCode == 200) {
      try {
        print('AuthenticationBloc _mapAuthenticationStartedToState isLoggedIn response 200 _authSuccess 1');
        //call fun to check userdata
        userData = UserData.fromJson(response.data);
        print(userData.message);
        _userRepository.setLocationMsg(userData.message!);
        yield* _authSuccess(userData);
      } on Exception catch (e, s) {
        print("Error $s");
      }
    } else {
      print('AuthenticationBloc _mapAuthenticationStartedToState isLoggedIn response not 200 _authFailed 1');
      _userRepository.setLocationMsg(' ');
      //handle auth failed cases
      yield* _authFailed(' ');
    }
  }

  Stream<AuthenticationState> _authSuccess(UserData userData) async* {
    if (userData.user != null) {
      print('AuthenticationBloc _authSuccess userData not null ');
      _userRepository.setUserProfile(userData);
      _userRepository.setUserDetails(userData.user!);
      _userRepository.setIsLogged(true);
      yield AuthenticationSuccess(userData);
    } else {
      print('AuthenticationBloc _authSuccess userData null ');
      yield* _authFailed(userData.message!);
    }
  }

  Stream<AuthenticationState> _authFailed(String message) async* {
    bool? isNotNewUser = await _userRepository.isNotNewUser();
    bool? isSkipped = await _userRepository.isGuest();
    if (!(isNotNewUser!)) {
      print('AuthenticationBloc _authFailed isNotNewUser false ');
      yield AuthenticationNewUserOnBoarding(message: message);
    } else if (isSkipped!) {
      // if auth skipped ,redirect to home as guest user
      // if auth is not skipped, redirect to home , with login popup shown after a short period
      _userRepository.setIsLogged(false);
      yield AuthenticationSkipped();
    } else {
      print('AuthenticationBloc _authFailed isNotNewUser true ');
      //user logged out either manually or by session expiry
      _userRepository.setIsLogged(false);
      yield UnAuthenticated(
        message: message
      );
    }
  }

  Stream<AuthenticationState> _authRetry() async* {
    print('AuthenticationBloc _authRetry');
    String? msg = await _userRepository.getLocationMsg();
    print(msg);
    yield AuthenticationRetrying(message: (msg != null) ? msg : ' ');
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    try{
      print('AuthenticationBloc _mapAuthenticationLoggedInToState');
      Response? response = await _userRepository.isLoggedIn();
      UserData userData = UserData.fromJson(response!.data);
      _userRepository.setUserProfile(userData);
      _userRepository.setUserDetails(userData.user!);
      _userRepository.setIsLogged(true);
      yield AuthenticationSuccess(userData);
    }
    catch(e){
      yield const AuthenticationFailure(message: ' ');
    }

  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    Response? response = await _userRepository.logOut();
    String? msg = await _userRepository.getLocationMsg();
    print(msg);
    print('AuthenticationBloc _mapAuthenticationLoggedOutToState logOut');

    _userRepository.clear();
    _userRepository.setIsLogged(false);
    if (response!.statusCode == 200) {
      print('AuthenticationBloc _mapAuthenticationLoggedOutToState logOut response 200 ');
      yield AuthenticationFailure(message: (msg != null) ? msg : ' ');
    }
  }

  Stream<AuthenticationState> _mapAuthenticationSkipToState() async* {
    _userRepository.setGuestFlag(true);
    _userRepository.setIsLogged(false);
    print('AuthenticationBloc _mapAuthenticationSkipToState');

    */
/* Response? response = await _userRepository.setPinCode('000000');
    print("============ \n\n\n $response \n\n\n===========");
    if(response!.statusCode == 200){
      PinCodeData pinCodeResponse = PinCodeData.fromJson(response.data);
      if(pinCodeResponse.errorMessage == null){
        _userRepository.storePinCode(pinCodeResponse);
        _userRepository.setHasPinCode(true);
      }
    }*//*

    yield AuthenticationSkipped();
  }
}
*/
