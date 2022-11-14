part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final UserData userData;

  const AuthenticationSuccess(this.userData);

  @override
  List<Object> get props => [userData];

  @override
  String toString() => 'Authenticated displayName: ${userData.toString()}';
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];

  @override
  String toString() => 'AuthenticationFailure';
}

class AuthenticationSkipped extends AuthenticationState {}

class AuthenticationOnLoading extends AuthenticationState {}

class AuthenticationRetrying extends AuthenticationState {
  final String message;

  const AuthenticationRetrying({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];

  @override
  String toString() => 'AuthenticationFailure';
}

class AuthenticationNewUserOnBoarding extends AuthenticationState {
  final String message;

  const AuthenticationNewUserOnBoarding({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];

  @override
  String toString() => 'AuthenticationFailure';
}

class AuthenticationCheckError extends AuthenticationState {
  final String message;

  AuthenticationCheckError({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class UnAuthenticated extends AuthenticationState {
  final String message;

  const UnAuthenticated({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];

  @override
  String toString() => 'UnAuthenticated';
}
