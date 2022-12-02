import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:habitoz_fitness_app/models/login_response.dart';
import 'package:habitoz_fitness_app/models/otp_response_model.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/models/zone_list_model.dart';
import '../../models/fitness_response.dart';
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
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    }
    else if (event is AuthenticationLoggedIn) {
      print('AuthenticationLoggedIn');
      yield* _mapAuthenticationLoggedInToState(event.otpResponse,event.loginResponse,event.zoneResult);
    }
    else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
    else if (event is AuthenticationSkip) {
      yield* _mapAuthenticationSkipToState();
    }
    else if (event is AuthenticationSkipProfile) {
      yield* _mapSkipCheckProfileState(event.data);
    }
    else if (event is AuthenticationProfileFilled) {
      yield* _mapProfileFilledToState(event.data);
    }
    else if (event is AuthenticationMoveToHomeScreen) {
      yield* _mapMoveToHomeState();
    }
    else if (event is AuthenticationRetry) {
      yield* _mapRetryLoginState(event.msg);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    try{
      yield AuthenticationLoadSplashScreen();
      await Future.delayed(const Duration(seconds: 2),() {});

      bool? isLogged = await _userRepository.isLogged();
      bool? isGuest = await _userRepository.isGuest();
      LoginResponse? userData = await _userRepository.getLoginResponse();
      ZoneResult? zoneResult = await _userRepository.getZoneDetailsLocal();

      if(isLogged!){
        // also need to check if token expired
        // if expired yield authFailed

        if(userData != null && userData.token != null){
          yield AuthenticationSuccess(isGuest: false,isLoggedIn: true,userName: userData.user!,zoneResult: zoneResult);
        }
        else{
          yield const AuthenticationFailure(message: 'Token Expired');
        }
      }
      else{
        //check if guest
        if(isGuest!){
          //guest
          yield const AuthenticationGuest(isGuest: true,isLoggedIn: false);
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

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState(OtpResponse otpResponse,LoginResponse loginResponse,ZoneResult? zoneResult) async* {
    try{
      _userRepository.setGuestFlag(false);
      _userRepository.setIsLogged(true);

      // check if profile is empty or is new user
      //if new user redirect to profile fill screen
      //if not redirect to home screen
      if(otpResponse.isRegistered != null && otpResponse.isRegistered!){
        yield AuthenticationSuccess(isLoggedIn: true,isGuest: false,userName: loginResponse.user,zoneResult: zoneResult);
      }
      else{
        yield AuthenticationCompleteProfile();
      }
      //yield AuthenticationCompleteProfile();
    }
    catch(e){
      yield AuthenticationFailure(message: 'AuthenticationFailure: ${e.toString()}');
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationOnLoading();
    UserProfile? userProfile = await _userRepository.getProfileDetailsLocal();

    Response? response = await _userRepository.logOut(userProfile!.id.toString());
    _userRepository.clear();
    _userRepository.setIsLogged(false);
    _userRepository.setGuestFlag(false);
    yield const AuthenticationFailure(message: ' Logged out');
  }

  Stream<AuthenticationState> _mapAuthenticationSkipToState() async* {
    _userRepository.setGuestFlag(true);
    _userRepository.setIsLogged(false);
    yield const AuthenticationGuest(isGuest: true,isLoggedIn: false);
  }

  Stream<AuthenticationState> _mapSkipCheckProfileState(Map<String,dynamic> data) async* {
    //check how much is filled
    //post details that are filled
    //store profile details
    String? userName = '';
    ZoneResult? zoneResult = await _userRepository.getZoneDetailsLocal();
    if(data.isNotEmpty){
      try{
        yield AuthenticationOnLoading();
        Response? response = await _userRepository.fitnessCalculate(data);
        if(response != null){
          print('fitnessCalculate');
          print(response.statusCode);
          print(response.data);
          print(response.statusMessage);

          if(response.statusCode == 200){
            //store profile details
            Response? response2 = await _userRepository.getUserProfile(true);
            print('getUserProfile');
            print(response2!.statusCode);
            print(response2.data);
            print(response2.statusMessage);
            if(response2 != null && response2.statusCode == 200){
              UserProfile userProfile = UserProfile.fromJson(response2.data);
              userName = (userProfile.user!.firstName != null) ? userProfile.user!.firstName : '';
              await _userRepository.storeProfileDetails(userProfile);
            }
          }
        }
      }
      catch(e){
        print(e.toString());
      }
    }
    _userRepository.setGuestFlag(false);
    _userRepository.setIsLogged(true);
    yield AuthenticationSuccess(isGuest: false,isLoggedIn: true,userName: userName,zoneResult: zoneResult);
  }

  Stream<AuthenticationState> _mapProfileFilledToState(Map<String,dynamic> data) async* {
    //post details that are filled
    //fitness calculation
    //store profile details
    //route to show result
    try{

      print('_mapProfileFilledToState');
      yield AuthenticationOnLoading();
      Response? response = await _userRepository.fitnessCalculate(data);
      if(response != null){
        print(response.statusCode);
        print(response.statusMessage);
        print(response.data);

        if(response.statusCode == 200){
          print('response fitnessCalculate');
          print(response.data);

          _userRepository.setGuestFlag(false);
          _userRepository.setIsLogged(true);
          FitnessResponse result = FitnessResponse.fromJson(response.data);
          //store profile details
          try{
            Response? response2 = await _userRepository.getUserProfile(true);
            if(response2 != null && response2.statusCode == 200){
              UserProfile userProfile = UserProfile.fromJson(response2.data);
              await _userRepository.storeProfileDetails(userProfile);
            }
          }
        catch(e){
            print(e.toString());
          }
          yield AuthenticationShowResult(result: result,data: data);
        }
        else{
          print('Unable to calculate fitness details 1');
          yield* _showError('Unable to calculate fitness details');
        }
      }
      else{
        print('Unable to calculate fitness details 2');
        yield* _showError('Unable to calculate fitness details');
      }

      }
    catch(e){
      print(e.toString());
      yield* _showError('Unable to calculate fitness details');
    }
  }

  Stream<AuthenticationState> _showError(String msg) async*{
    _userRepository.setGuestFlag(false);
    _userRepository.setIsLogged(true);
    ZoneResult? zoneResult = await _userRepository.getZoneDetailsLocal();
    yield AuthenticationSuccess(message: msg,isGuest: false,isLoggedIn: true,zoneResult: zoneResult);
  }

  Stream<AuthenticationState> _mapMoveToHomeState() async*{
    _userRepository.setGuestFlag(false);
    _userRepository.setIsLogged(true);
    ZoneResult? zoneResult = await _userRepository.getZoneDetailsLocal();
    yield AuthenticationSuccess(isGuest: false,isLoggedIn: true,zoneResult: zoneResult);
  }

  Stream<AuthenticationState> _mapRetryLoginState(String? msg) async*{
    _userRepository.clear();
    _userRepository.setGuestFlag(false);
    _userRepository.setIsLogged(false);
    yield AuthenticationFailure(message: msg!);
  }

}
