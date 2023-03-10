

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:habitoz_fitness_app/models/login_response.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/utils/api_query.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
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


  //send otp
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

  //verify otp - login
  Future<Response?> loginWithOtp(
      String phoneNumber, String code) async {
    Map<String, String> body = {
      "mobile": phoneNumber,
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

  //resend otp
  Future<Response?> reSendOtp(String id) async {

    String appSignature;
    appSignature = await SmsAutoFill().getAppSignature;
    appSignature = appSignature;

    Map<String, String> body = {
      "otp_id": id,
      "app_sign": appSignature,
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

  //logout
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

  //get user profile
  Future<Response?> getUserProfile(bool forceRefresh) async {
    try {
      LoginResponse? loginResponse = await getLoginResponse();
      String? token = loginResponse!.token;

      Map<String,String> headers = {
        'Authorization' : 'Token $token'
      };

      Response? response = await apiQuery.getQuery(
          Constants.apiUserProfile, headers, {},
          'UserProfileApi', true, true, forceRefresh);
      return response;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //calculate bmi
  Future<Response?> fitnessCalculate(Map<String,dynamic> details) async {
    try {

      LoginResponse? loginResponse = await getLoginResponse();
      String? token = loginResponse!.token;

      Map<String,String> headers = {
        'Authorization' : 'Token $token'
      };

      Map<String, dynamic> body = {};
      if(details.isNotEmpty){
        body = details;
      }

      if(details['weight'] == null){
        body['weight'] = 0.0;
      }
      if(details['height_cm'] == null){
        body['height_cm'] = 0.0;
      }
      if(details['height_ft'] == null){
        body['height_ft'] = 0.0;
      }
      if(details['neck'] == null){
        body['neck'] = 0.0;
      }

      print(body);

      Response? response = await apiQuery.postQuery(
          Constants.apiFitnessCalculate,headers, body, 'FitnessCalculate');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //update user details
  Future<Response?> updateUserDetails(Map<String,dynamic> details) async {
    try {

      LoginResponse? loginResponse = await getLoginResponse();
      String? token = loginResponse!.token;

      Map<String, dynamic> body = {};

      if(details.isNotEmpty){
        body = details;
      }

      Map<String,String> headers = {
        'Authorization' : 'Token $token'
      };

      print('body');
      print(body);

      Response? response = await apiQuery.putQuery(Constants.apiUserProfile,headers,body, 'UpdateProfile');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  /// Local storage

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

  storeProfileDetails(UserProfile userData) async {
    // ignore: unnecessary_null_comparison
    if (userData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userProfileJson = json.encode(userData);
      prefs.setString(PROFILE_DETAILS, userProfileJson);
    }
  }

  Future<UserProfile?> getProfileDetailsLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(PROFILE_DETAILS) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(PROFILE_DETAILS);
      return UserProfile.fromJson(json.decode(userResponse!));
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