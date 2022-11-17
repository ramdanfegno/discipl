// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.mobile,
    this.profile,
  });

  String? mobile;
  Profile? profile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    mobile: json["mobile"] == null ? null : json["mobile"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "profile": profile!.toJson(),
  };
}

class Profile {
  Profile({
    this.id,
    this.age,
    this.weight,
    this.heightCm,
    this.heightFt,
    this.neck,
    this.chestExtended,
    this.chestNormal,
    this.forearms,
    this.arms,
    this.upperAbs,
    this.lowerAbs,
    this.hip,
    this.thigh,
    this.calves,
    this.gender,
    this.membershipId,
    this.bodyFatPercentage,
    this.bodyMassIndex,
    this.basalMetabolismRate,
    this.image,
    this.user,
    this.fitnessCenter,
    this.course,
  });

  int? id;
  int? age;
  double? weight;
  double? heightCm;
  double? heightFt;
  double? neck;
  double? chestExtended;
  double? chestNormal;
  double? forearms;
  double? arms;
  double? upperAbs;
  double? lowerAbs;
  double? hip;
  double? thigh;
  double? calves;
  String? gender;
  dynamic membershipId;
  double? bodyFatPercentage;
  double? bodyMassIndex;
  double? basalMetabolismRate;
  String? image;
  double? user;
  dynamic fitnessCenter;
  dynamic course;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    age: json["age"],
    weight: json["weight"],
    heightCm: json["height_cm"],
    heightFt: json["height_ft"],
    neck: json["neck"],
    chestExtended: json["chest_extended"],
    chestNormal: json["chest_normal"],
    forearms: json["forearms"],
    arms: json["arms"],
    upperAbs: json["upper_abs"],
    lowerAbs: json["lower_abs"],
    hip: json["hip"],
    thigh: json["thigh"],
    calves: json["calves"],
    gender: json["gender"],
    membershipId: json["membership_id"],
    bodyFatPercentage: json["body_fat_percentage"],
    bodyMassIndex: json["body_mass_index"],
    basalMetabolismRate: json["basal_metabolism_rate"],
    image: json["image"],
    user: json["user"],
    fitnessCenter: json["fitness_center"],
    course: json["course"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "age": age,
    "weight": weight,
    "height_cm": heightCm,
    "height_ft": heightFt,
    "neck": neck,
    "chest_extended": chestExtended,
    "chest_normal": chestNormal,
    "forearms": forearms,
    "arms": arms,
    "upper_abs": upperAbs,
    "lower_abs": lowerAbs,
    "hip": hip,
    "thigh": thigh,
    "calves": calves,
    "gender": gender,
    "membership_id": membershipId,
    "body_fat_percentage": bodyFatPercentage,
    "body_mass_index": bodyMassIndex,
    "basal_metabolism_rate": basalMetabolismRate,
    "image": image,
    "user": user,
    "fitness_center": fitnessCenter,
    "course": course,
  };
}
