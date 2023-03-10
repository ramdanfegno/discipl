import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {

  static const String baseUrl = 'https://blacksquad.dev.fegno.com/api/v1/';

  static const String appTitle = 'Black Squad';
  static const String currencySymbol = '\u20B9';

  //api names
  static const String apiSendOtp = 'user/enter_mobile/';
  static const String apiResendOtp = 'user/resent_otp/';
  static const String apiLoginWithOtp = 'user/token/login/';
  static const String apiUserProfile = 'user/profile/';
  static const String apiLogout = 'user/logout/';
  static const String apiHome = 'user/index/';
  static const String apiCustomerRegister = 'user/register/customer/';
  static const String apiFitnessCenterList = 'fitness_center/fc/';
  static const String apiFitnessCalculate = 'user/fit-calculator/';
  static const String apiPostEnquiry = '';
  static const String apiFeedList = '';
  static const String apiSetLocation = '';


  //fonts styles
  static const String fontRegular = 'Inter-Regular';
  static const String fontSemiBold = 'Inter-SemiBold';
  static const String fontMedium = 'Inter-Medium';
  static const String fontBold = 'Inter-Bold';

  static const Color fontColor1 = Color.fromRGBO(34, 34, 34, 1);
  static const Color fontColor2 = Color.fromRGBO(233, 30, 35, 1);
  static const Color fontColor3 = Color.fromRGBO(0, 142, 40, 1);


  // static const Color primaryColor = Color.fromRGBO(31, 167, 90, 1);
  static const primaryColor = Color.fromRGBO(233, 30, 35, 1);
  static const Color primaryButtonColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color secondaryButtonColor = Color.fromRGBO(255, 92, 0, 1);

  static const Color buttonColor = Color.fromRGBO(94, 114, 228, 1);
  static const Color errorColor = Color.fromRGBO(239, 83, 80, 1);
  static const Color disabledTextColor = Color.fromRGBO(238, 238, 238, 1);
  static const Color appbarColor = Color.fromRGBO(102, 102, 102, 1);

  static const Color backgroundColor1 = Color.fromRGBO(243, 243, 243, 1);

  static const TextStyle titleTextStyle = TextStyle(
      color: Color.fromRGBO(40, 40, 40, 1),
      fontFamily: Constants.fontBold,
      fontSize: 24);

  static const TextStyle subtitleTextStyle = TextStyle(
      color: Color.fromRGBO(102, 102, 102, 1),
      fontFamily: Constants.fontRegular,
      fontSize: 15);

}
