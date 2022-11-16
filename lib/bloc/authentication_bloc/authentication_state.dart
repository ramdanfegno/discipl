part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];

  @override
  String toString() => 'AuthenticationFailure';
}

class AuthenticationOnLoading extends AuthenticationState {}

class AuthenticationGuest extends AuthenticationState {}
