// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

import 'dart:convert';

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  OtpResponse({
    this.user,
    this.mobile,
    this.otp,
    this.id,
    this.isRegistered,
    this.appSign
  });

  String? user;
  String? mobile;
  int? otp;
  int? id;
  bool? isRegistered;
  String? appSign;

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
    user: json["user"],
    mobile: json["mobile"],
    otp: json["otp"],
    id: json["id"],
    appSign: json["app_sign"],
    isRegistered: json["is_registered"]
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "mobile": mobile,
    "otp": otp,
    "id": id,
    "is_registered": isRegistered,
    "app_sign": appSign
  };
}
