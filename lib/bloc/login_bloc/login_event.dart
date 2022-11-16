import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithCredentials extends LoginEvent {
  final String phone;

  const LoginWithCredentials({
    required this.phone,
  });

  @override
  List<Object> get props => [phone];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { phone: $phone}';
  }
}

class LoginPhoneChanged extends LoginEvent {
  final String phone;

  const LoginPhoneChanged({required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'EmailChanged { email :$phone }';
}
