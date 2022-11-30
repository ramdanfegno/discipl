// To parse this JSON data, do
//
//     final locationResponseModel = locationResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:habitoz_fitness_app/models/zone_list_model.dart';

LocationResponseModel locationResponseModelFromJson(String str) => LocationResponseModel.fromJson(json.decode(str));

String locationResponseModelToJson(LocationResponseModel data) => json.encode(data.toJson());

class LocationResponseModel {
  LocationResponseModel({
    this.zone,
    this.locationName,
    this.message,
  });

  ZoneResult? zone;
  String? locationName;
  String? message;

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) => LocationResponseModel(
    zone: ZoneResult.fromJson(json["zone"]),
    locationName: json["location_name"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "zone": zone!.toJson(),
    "location_name": locationName,
    "message": message,
  };
}
