// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.id,
    this.user,
    this.age,
    this.weight,
    this.heightCm,
    this.heightFt,
    this.neck,
    this.shoulders,
    this.chestExtended,
    this.chestNormal,
    this.leftForearmsRelaxed,
    this.leftForearmsExtended,
    this.rightForearmsRelaxed,
    this.rightForearmsExtended,
    this.leftUpperarmsRelaxed,
    this.leftUpperarmsExtended,
    this.rightUpperarmsRelaxed,
    this.rightUpperarmsExtended,
    this.waist,
    this.hip,
    this.leftThighRelaxed,
    this.leftThighExtended,
    this.rightThighRelaxed,
    this.rightThighExtended,
    this.leftCalfRelaxed,
    this.leftCalfExtended,
    this.rightCalfRelaxed,
    this.rightCalfExtended,
    this.gender,
    this.membershipId,
    this.bodyFatPercentage,
    this.bodyMassIndex,
    this.basalMetabolismRate,
    this.image,
    this.fitnessCenter,
    this.course,
    this.dietPlan,
  });

  int? id;
  User? user;
  dynamic age;
  int? weight;
  int? heightCm;
  double? heightFt;
  int? neck;
  int? shoulders;
  int? chestExtended;
  int? chestNormal;
  int? leftForearmsRelaxed;
  int? leftForearmsExtended;
  int? rightForearmsRelaxed;
  int? rightForearmsExtended;
  int? leftUpperarmsRelaxed;
  int? leftUpperarmsExtended;
  int? rightUpperarmsRelaxed;
  int? rightUpperarmsExtended;
  int? waist;
  int? hip;
  int? leftThighRelaxed;
  int? leftThighExtended;
  int? rightThighRelaxed;
  int? rightThighExtended;
  int? leftCalfRelaxed;
  int? leftCalfExtended;
  int? rightCalfRelaxed;
  int? rightCalfExtended;
  String? gender;
  dynamic membershipId;
  int? bodyFatPercentage;
  int? bodyMassIndex;
  int? basalMetabolismRate;
  dynamic image;
  List<dynamic>? fitnessCenter;
  List<dynamic>? course;
  List<dynamic>? dietPlan;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: (json["id"] == null) ? null : json["id"],
    user: User.fromJson(json["user"]),
    age: (json["age"] == null) ? null : json["age"],
    weight: (json["weight"] == null) ? null : json["weight"],
    heightCm: (json["height_cm"] == null) ? null : json["height_cm"],
    heightFt: (json["height_ft"] == null) ? null : json["height_ft"],
    neck: (json["neck"] == null) ? null : json["neck"],
    shoulders: (json["shoulders"] == null) ? null : json["shoulders"],
    chestExtended: (json["chest_extended"] == null) ? null : json["chest_extended"],
    chestNormal: (json["chest_normal"] == null) ? null : json["chest_normal"],
    leftForearmsRelaxed: (json["left_forearms_relaxed"] == null) ? null : json["left_forearms_relaxed"],
    leftForearmsExtended: (json["left_forearms_extended"] == null) ? null : json["left_forearms_extended"],
    rightForearmsRelaxed: (json["right_forearms_relaxed"] == null) ? null : json["right_forearms_relaxed"],
    rightForearmsExtended: (json["right_forearms_extended"] == null) ? null : json["right_forearms_extended"],
    leftUpperarmsRelaxed: (json["left_upperarms_relaxed"] == null) ? null : json["left_upperarms_relaxed"],
    leftUpperarmsExtended: (json["left_upperarms_extended"] == null) ? null : json["left_upperarms_extended"],
    rightUpperarmsRelaxed: (json["right_upperarms_relaxed"] == null) ? null : json["right_upperarms_relaxed"],
    rightUpperarmsExtended: (json["right_upperarms_extended"] == null) ? null : json["right_upperarms_extended"],
    waist: (json["waist"] == null) ? null : json["waist"],
    hip: (json["hip"] == null) ? null : json["hip"],
    leftThighRelaxed: (json["left_thigh_relaxed"] == null) ? null : json["left_thigh_relaxed"],
    leftThighExtended: (json["left_thigh_extended"] == null) ? null : json["left_thigh_extended"],
    rightThighRelaxed: (json["right_thigh_relaxed"] == null) ? null : json["right_thigh_relaxed"],
    rightThighExtended: (json["right_thigh_extended"] == null) ? null : json["right_thigh_extended"],
    leftCalfRelaxed: (json["left_calf_relaxed"] == null) ? null : json["left_calf_relaxed"],
    leftCalfExtended: (json["left_calf_extended"] == null) ? null : json["left_calf_extended"],
    rightCalfRelaxed: (json["right_calf_relaxed"] == null) ? null : json["right_calf_relaxed"],
    rightCalfExtended: (json["right_calf_extended"] == null) ? null : json["right_calf_extended"],
    gender: (json["gender"] == null) ? null : json["gender"],
    membershipId: (json["membership_id"] == null) ? null : json["membership_id"],
    bodyFatPercentage: (json["body_fat_percentage"] == null) ? null : json["body_fat_percentage"],
    bodyMassIndex: (json["body_mass_index"] == null) ? null : json["body_mass_index"],
    basalMetabolismRate: (json["basal_metabolism_rate"] == null) ? null : json["basal_metabolism_rate"],
    image: (json["image"] == null) ? null : json["image"],
    fitnessCenter: (json["fitness_center"] == null) ? [] : List<dynamic>.from(json["fitness_center"].map((x) => x)),
    course: (json["course"] == null) ? [] : List<dynamic>.from(json["course"].map((x) => x)),
    dietPlan: (json["diet_plan"] == null) ? [] : List<dynamic>.from(json["diet_plan"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user!.toJson(),
    "age": age,
    "weight": weight,
    "height_cm": heightCm,
    "height_ft": heightFt,
    "neck": neck,
    "shoulders": shoulders,
    "chest_extended": chestExtended,
    "chest_normal": chestNormal,
    "left_forearms_relaxed": leftForearmsRelaxed,
    "left_forearms_extended": leftForearmsExtended,
    "right_forearms_relaxed": rightForearmsRelaxed,
    "right_forearms_extended": rightForearmsExtended,
    "left_upperarms_relaxed": leftUpperarmsRelaxed,
    "left_upperarms_extended": leftUpperarmsExtended,
    "right_upperarms_relaxed": rightUpperarmsRelaxed,
    "right_upperarms_extended": rightUpperarmsExtended,
    "waist": waist,
    "hip": hip,
    "left_thigh_relaxed": leftThighRelaxed,
    "left_thigh_extended": leftThighExtended,
    "right_thigh_relaxed": rightThighRelaxed,
    "right_thigh_extended": rightThighExtended,
    "left_calf_relaxed": leftCalfRelaxed,
    "left_calf_extended": leftCalfExtended,
    "right_calf_relaxed": rightCalfRelaxed,
    "right_calf_extended": rightCalfExtended,
    "gender": gender,
    "membership_id": membershipId,
    "body_fat_percentage": bodyFatPercentage,
    "body_mass_index": bodyMassIndex,
    "basal_metabolism_rate": basalMetabolismRate,
    "image": image,
    "fitness_center": List<dynamic>.from(fitnessCenter!.map((x) => x)),
    "course": List<dynamic>.from(course!.map((x) => x)),
    "diet_plan": List<dynamic>.from(dietPlan!.map((x) => x)),
  };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? mobile;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: (json["first_name"] == null) ? null : json["first_name"],
    lastName: (json["last_name"] == null) ? null : json["last_name"],
    email: (json["email"] == null) ? null : json["email"],
    mobile: (json["mobile"] == null) ? null : json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile": mobile,
  };
}
