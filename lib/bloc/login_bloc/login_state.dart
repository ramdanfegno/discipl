import 'package:habitoz_fitness_app/models/login_response.dart';
import 'package:meta/meta.dart';

import '../../models/otp_response_model.dart';


@immutable
class LoginState {
  final bool isPhoneValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final OtpResponse? otpResponseModel;
  final String? message;

  LoginState({
    this.otpResponseModel,
    this.message,
    required this.isPhoneValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory LoginState.initial() {
    return LoginState(
      isPhoneValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isPhoneValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure({required String msg}) {
    return LoginState(
        isPhoneValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        message: msg);
  }

  factory LoginState.success({required OtpResponse otpResponseModel}) {
    return LoginState(
      isPhoneValid: true,
      otpResponseModel: otpResponseModel,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState update({
    bool? isPhoneValid,
  }) {
    return copyWith(
      isPhoneValid: isPhoneValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool? isPhoneValid,
    bool? isSubmitEnabled,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isPhoneValid: $isPhoneValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
