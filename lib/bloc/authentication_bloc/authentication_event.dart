part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationSkip extends AuthenticationEvent {}

class AuthenticationRetry extends AuthenticationEvent {}

class AuthenticationLoading extends AuthenticationEvent {}

class AuthenticationNewUser extends AuthenticationEvent {}
