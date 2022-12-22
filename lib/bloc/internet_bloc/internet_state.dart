part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}

class connectedState extends InternetState {
  String? msg;

  connectedState({required this.msg});
}

class notConnectedState extends InternetState {
  String? msg;

  notConnectedState({required this.msg});
}
