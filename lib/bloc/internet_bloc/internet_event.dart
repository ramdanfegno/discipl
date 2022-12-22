part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {}

class onConnected extends InternetEvent {}

class notConnected extends InternetEvent {}
