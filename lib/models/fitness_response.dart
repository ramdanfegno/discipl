// To parse this JSON data, do
//
//     final fitnessResponse = fitnessResponseFromJson(jsonString);

import 'dart:convert';

FitnessResponse fitnessResponseFromJson(String str) => FitnessResponse.fromJson(json.decode(str));

String fitnessResponseToJson(FitnessResponse data) => json.encode(data.toJson());

class FitnessResponse {
  FitnessResponse({
    this.age,
    this.bmi,
    this.bmr,
    this.bfp,
    this.message,
  });

  int? age;
  double? bmi;
  double? bmr;
  double? bfp;
  String? message;

  factory FitnessResponse.fromJson(Map<String, dynamic> json) => FitnessResponse(
    age: json["age"] == null ? null : json["age"],
    bmi: json["BMI"] == null ? null : json["BMI"],
    bmr: json["BMR"] == null ? null : json["BMR"],
    bfp: json["BFP"] == null ? null : json["BFP"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "age": age,
    "BMI": bmi,
    "BMR": bmr,
    "BFP": bfp,
    "message": message,
  };
}
