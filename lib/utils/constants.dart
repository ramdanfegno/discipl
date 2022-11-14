import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {

  static const String baseUrl = 'https://blacksquad.dev.fegno.com/api/v1/';

  static const String appTitle = 'Black Squad';
  static const String currencySymbol = '\u20B9';

  //api names
  static const String apiSendOtp = 'user/enter_mobile/';
  static const String apiResendOtp = 'user/resend-otp/';  /// need to verify
  static const String apiLoginWithOtp = 'user/enter_otp/';
  static const String apiUserProfile = 'user/profile/';
  static const String apiLogout = 'user/logout/';
  static const String apiHome = 'user/index/';
  static const String apiCustomerRegister = 'user/register/customer/';
  static const String apiFitnessCenterList = 'fitness_center/fc/';


  static const String placeHolderImg =
      'assets/png/shopprix-placeholder-image.png';
  static const String placeHolderImg2 =
      'assets/png/shopprix-placeholder-image2.png';

  //fonts styles
  static const String fontRegular = 'Barlow-Regular';
  static const String fontSemiBold = 'Barlow-SemiBold';
  static const String fontMedium = 'Barlow-Medium';
  static const String fontBold = 'Barlow-Bold';

  static const double fontSize1 = 15.0;
  static const Color fontColor1 = Color.fromRGBO(94, 114, 228, 1);

  static const double fontSize2 = 15.0;
  static const Color fontColor2 = Color.fromRGBO(94, 114, 228, 1);

  static const double fontSize3 = 15.0;
  static const Color fontColor3 = Color.fromRGBO(94, 114, 228, 1);
  static const Color fontColor4 = Color.fromRGBO(23, 43, 77, 1);

  // static const Color primaryColor = Color.fromRGBO(31, 167, 90, 1);
  static const primaryColor = Color.fromRGBO(255, 186, 0, 1);
  static const Color primaryButtonColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color secondaryButtonColor = Color.fromRGBO(255, 92, 0, 1);

  static const Color buttonColor = Color.fromRGBO(94, 114, 228, 1);
  static const Color errorColor = Color.fromRGBO(239, 83, 80, 1);
  static const Color disabledTextColor = Color.fromRGBO(238, 238, 238, 1);
  static const Color appbarColor = Color.fromRGBO(102, 102, 102, 1);

  static const Color backgroundColor1 = Color.fromRGBO(242, 242, 242, 1);
  static const Color backgroundColor2 = Color.fromRGBO(239, 239, 239, 1);

  static const Color reviewColor = Color.fromRGBO(31, 167, 90, 1);
  static const Color cartTextColor = Color.fromRGBO(244, 145, 42, 1);

  static const TextStyle titleTextStyle = TextStyle(
      color: Color.fromRGBO(40, 40, 40, 1),
      fontFamily: Constants.fontBold,
      fontSize: 24);

  static const TextStyle subtitleTextStyle = TextStyle(
      color: Color.fromRGBO(102, 102, 102, 1),
      fontFamily: Constants.fontRegular,
      fontSize: 15);

}
