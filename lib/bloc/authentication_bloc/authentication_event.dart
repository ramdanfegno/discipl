part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  OtpResponse otpResponse;
  LoginResponse loginResponse;
  ZoneResult? zoneResult;

  AuthenticationLoggedIn({required this.loginResponse,required this.otpResponse,required this.zoneResult});
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationSkip extends AuthenticationEvent {}

class AuthenticationRetry extends AuthenticationEvent {
  final String? msg;
  AuthenticationRetry({this.msg});
}

class AuthenticationSkipProfile extends AuthenticationEvent {
  final Map<String,dynamic> data;
  AuthenticationSkipProfile({required this.data});
}

class AuthenticationProfileFilled extends AuthenticationEvent {
  final Map<String,dynamic> data;
  AuthenticationProfileFilled({required this.data});
}

class AuthenticationMoveToHomeScreen extends AuthenticationEvent {}


