import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitoz_fitness_app/models/login_response.dart';

import '../../models/otp_response_model.dart';
import '../../repositories/user_repo.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'validator.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial());

  LoginState get initialState => LoginState.initial();

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPhoneChanged) {
      yield* _mapLoginPhoneChangedToState(event.phone);
    } else if (event is LoginWithCredentials) {
      yield* _mapLoginWithCredentialsToState(phone: event.phone);
    }
  }

  Stream<LoginState> _mapLoginPhoneChangedToState(String phone) async* {
    yield state.update(
      isPhoneValid: Validators.isValidPhoneNumber(phone),
    );
  }

  Stream<LoginState> _mapLoginWithCredentialsToState(
      {required String phone}) async* {
    yield LoginState.loading();

    try {
      if (Validators.isValidPhoneNumber(phone)) {
        Response? response = await _userRepository.sendOtp(phone);
        print("============ \n\n\n ${response!.data} \n\n\n===========");

        if(response != null && response.statusCode == 200){
          OtpResponse otpResponse = OtpResponse.fromJson(response.data);
          yield LoginState.success(otpResponseModel: otpResponse);
        }
        else{
          yield LoginState.failure(msg: 'Error!');
        }
      } else {
        yield LoginState.failure(msg: 'Enter a valid phone number');
      }
    } catch (_) {
      print("============ \n\n\n $Error\n\n\n ===========");
      yield LoginState.failure(msg: 'Oops! Something went wrong');
    }
  }
}
