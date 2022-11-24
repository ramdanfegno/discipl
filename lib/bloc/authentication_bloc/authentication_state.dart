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
  final String? message;

  const AuthenticationSuccess({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];

  @override
  String toString() => 'AuthenticationSuccess';
}

/// To login screen
class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];

  @override
  String toString() => 'AuthenticationFailure';
}

/// To home screen as guest
class AuthenticationGuest extends AuthenticationState {}

/// Profile form screen
class AuthenticationCompleteProfile extends AuthenticationState {}

class AuthenticationShowResult extends AuthenticationState {
  final FitnessResponse result;
  const AuthenticationShowResult({required this.result});

}
