

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:habitoz_fitness_app/models/login_response.dart';
import 'package:habitoz_fitness_app/utils/api_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../utils/constants.dart';

class UserRepository{

  ApiQuery apiQuery = ApiQuery();

  // ignore: constant_identifier_names
  static const String IS_LOGGED_IN = "IS_LOGGED_IN";

  // ignore: constant_identifier_names
  static const String IS_GUEST = "IS_GUEST";

  // ignore: constant_identifier_names
  static const String LOGIN_RESPONSE = "LOGIN_RESPONSE";

  // ignore: constant_identifier_names
  static const String PROFILE_DETAILS = "PROFILE_DETAILS";

  // ignore: constant_identifier_names
  static const String LOCATION_MSG = "LOCATION_MSG";


  Future<Response?> sendOtp(String phoneNumber) async {
    String appSignature;
    appSignature = await SmsAutoFill().getAppSignature;
    appSignature = appSignature;
    Map<String, String> body = {
      "mobile": phoneNumber,
      "app_sign": appSignature,
      "name" : '',
      "email" : ''
    };

    print('body');
    print(body);

    try {
      Response? response =
      await apiQuery.postQuery(Constants.apiSendOtp,{},body, 'SendOtp');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<Response?> loginWithOtp(
      String phoneNumber, String id, String code) async {
    Map<String, String> body = {
      "mobile": phoneNumber,
      "id": id,
      "otp": code,
    };
    try {
      Response? response = await apiQuery.postQuery(
          Constants.apiLoginWithOtp,{}, body, 'LoginWithOtp');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<Response?> reSendOtp(String phoneNumber, String id) async {
    Map<String, String> body = {
      "id": id,
      "mobile_number": phoneNumber,
    };
    try {
      Response? response =
      await apiQuery.postQuery(Constants.apiResendOtp,{}, body, 'ReSendOtp');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<Response?> logOut() async {
    try {
      Response? response =
      await apiQuery.logoutQuery(Constants.apiLogout, 'LogoutApi');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  setLoginResponse(LoginResponse userData) async {
    // ignore: unnecessary_null_comparison
    if (userData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userProfileJson = json.encode(userData);
      prefs.setString(LOGIN_RESPONSE, userProfileJson);
    }
  }

  Future<LoginResponse?> getLoginResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(LOGIN_RESPONSE) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(LOGIN_RESPONSE);
      return LoginResponse.fromJson(json.decode(userResponse!));
    }
  }


  Future<bool?> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_LOGGED_IN) ?? false;
  }

  setIsLogged(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(IS_LOGGED_IN, val);
  }

  // to know whether user has skipped login and became a guest user
  Future<bool?> isGuest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_GUEST) ?? false;
  }

  setGuestFlag(bool isGuest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(IS_GUEST, isGuest);
  }

  Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}