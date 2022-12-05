part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

/// Initial splash screen
class AuthenticationInitial extends AuthenticationState {}

/// Show loading widget
class AuthenticationOnLoading extends AuthenticationState {}

class AuthenticationLoadSplashScreen extends AuthenticationState {}

/// To home screen as user
class AuthenticationSuccess extends AuthenticationState {
  final String? message,userName;
  final bool isGuest;
  final bool isLoggedIn;
  final ZoneResult? zoneResult;

  const AuthenticationSuccess({this.message,required this.isLoggedIn,
    required this.zoneResult,
    required this.isGuest,this.userName});

  @override
  String toString() => 'AuthenticationSuccess';
}

/// To login screen
class AuthenticationFailure extends AuthenticationState {
  final String? message;

  const AuthenticationFailure({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];

  @override
  String toString() => 'AuthenticationFailure';
}

/// To home screen as guest
class AuthenticationGuest extends AuthenticationState {
  final bool isGuest;
  final bool isLoggedIn;
  const AuthenticationGuest({required this.isGuest,required this.isLoggedIn});
}

/// Profile form screen
class AuthenticationCompleteProfile extends AuthenticationState {}

class AuthenticationShowResult extends AuthenticationState {
  final FitnessResponse result;
  final Map<String,dynamic> data;
  const AuthenticationShowResult({required this.result,required this.data});
}

