// To parse this JSON data, do
//
//     final fitnessCenterListModel = fitnessCenterListModelFromJson(jsonString);

import 'dart:convert';

import 'home_page_model.dart';

FitnessCenterListModel fitnessCenterListModelFromJson(String str) => FitnessCenterListModel.fromJson(json.decode(str));

String fitnessCenterListModelToJson(FitnessCenterListModel data) => json.encode(data.toJson());

class FitnessCenterListModel {
  FitnessCenterListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<FitnessCenterModel>? results;

  factory FitnessCenterListModel.fromJson(Map<String, dynamic> json) => FitnessCenterListModel(
    count: json["count"] == null ? null : json["count"],
    next: json["next"] == null ? null : json["next"],
    previous: json["previous"] == null ? null : json["previous"],
    results: json["results"] == null ? null : List<FitnessCenterModel>.from(json["results"].map((x) => FitnessCenterModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class FitnessCenterModel {
  FitnessCenterModel({
    this.id,
    this.amenities,
    this.institution,
    this.plans,
    this.rules,
    this.category,
    this.name,
    this.description,
    this.mobile,
    this.email,
    this.logo,
    this.location,
    this.contact,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.addressLine4,
    this.instagramUrl,
    this.facebookUrl,
    this.youtubeUrl,
    this.zone,
    this.rating,
    this.workingTime
  });

  int? id;
  Amenities? amenities;
  Institution? institution;
  List<Plan>? plans;
  List<Amenities>? rules;
  List<Amenities>? category;
  List<WorkingTime>? workingTime;
  String? name;
  String? rating;
  String? description;
  String? mobile;
  String? email;
  String? logo;
  dynamic location;
  String? contact;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? addressLine4;
  String? instagramUrl;
  String? facebookUrl;
  String? youtubeUrl;
  int? zone;

  factory FitnessCenterModel.fromJson(Map<String, dynamic> json) => FitnessCenterModel(
    id: json["id"] == null ? null : json["id"],
    amenities: json["amenities"] == null ? null : Amenities.fromJson(json["amenities"]),
    institution: json["institution"] == null ? null : Institution.fromJson(json["institution"]),
    plans: json["plans"] == null ? null : List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
    rules: json["rules"] == null ? null : List<Amenities>.from(json["rules"].map((x) => Amenities.fromJson(x))),
    category: json["category"] == null ? null : List<Amenities>.from(json["category"].map((x) => Amenities.fromJson(x))),
    workingTime: json["working_time"] == null ? null : List<WorkingTime>.from(json["working_time"].map((x) => WorkingTime.fromJson(x))),
    name: json["name"] == null ? null : json["name"],
    rating: json["rating"] == null ? null : json["rating"],
    description: json["description"] == null ? null : json["description"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    email: json["email"] == null ? null : json["email"],
    logo: json["logo"] == null ? null : json["logo"],
    location: json["count"] == null ? null : json["location"],
    contact: json["contact"] == null ? null : json["contact"],
    addressLine1: json["address_line1"] == null ? null : json["address_line1"],
    addressLine2: json["address_line2"] == null ? null : json["address_line2"],
    addressLine3: json["address_line3"] == null ? null : json["address_line3"],
    addressLine4: json["address_line4"] == null ? null : json["address_line4"],
    instagramUrl: json["instagram_url"] == null ? null : json["instagram_url"],
    facebookUrl: json["facebook_url"] == null ? null : json["facebook_url"],
    youtubeUrl: json["youtube_url"] == null ? null : json["youtube_url"],
    zone: json["zone"] == null ? null : json["zone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amenities": amenities!.toJson(),
    "institution": institution!.toJson(),
    "plans": List<dynamic>.from(plans!.map((x) => x.toJson())),
    "rules": List<dynamic>.from(rules!.map((x) => x.toJson())),
    "category": List<dynamic>.from(category!.map((x) => x.toJson())),
    "name": name,
    "rating": rating,
    "description": description == null ? null : description,
    "working_time": workingTime == null ? null : List<dynamic>.from(workingTime!.map((x) => x.toJson())),
    "mobile": mobile == null ? null : mobile,
    "email": email == null ? null : email,
    "logo": logo == null ? null : logo,
    "location": location,
    "contact": contact == null ? null : contact,
    "address_line1": addressLine1 == null ? null : addressLine1,
    "address_line2": addressLine2 == null ? null : addressLine2,
    "address_line3": addressLine3 == null ? null : addressLine3,
    "address_line4": addressLine4 == null ? null : addressLine4,
    "instagram_url": instagramUrl == null ? null : instagramUrl,
    "facebook_url": facebookUrl == null ? null : facebookUrl,
    "youtube_url": youtubeUrl == null ? null : youtubeUrl,
    "zone": zone == null ? null : zone,
  };
}

class Amenities {
  Amenities({
    this.name,
    this.description,
    this.logo,
    this.id,
    this.fitnessCenter,
  });

  String? name;
  String? description;
  String? logo;
  int? id;
  int? fitnessCenter;

  factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    logo: json["logo"] == null ? null : json["logo"],
    id: json["id"] == null ? null : json["id"],
    fitnessCenter: json["fitness_center"] == null ? null : json["fitness_center"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "logo": logo == null ? null : logo,
    "id": id == null ? null : id,
    "fitness_center": fitnessCenter == null ? null : fitnessCenter,
  };
}

class Institution {
  Institution({
    this.id,
    this.name,
    this.zone,
  });

  int? id;
  String? name;
  Zone? zone;

  factory Institution.fromJson(Map<String, dynamic> json) => Institution(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    zone: json["zone"] == null ? null : Zone.fromJson(json["zone"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "zone": zone == null ? null : zone!.toJson(),
  };
}

class Zone {
  Zone({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Plan {
  Plan({
    this.id,
    this.name,
    this.description,
    this.amount,
    this.duration,
    this.isTrendingNow,
    this.fitnessCenter,
  });

  int? id;
  String? name;
  String? description;
  double? amount;
  String? duration;
  bool? isTrendingNow;
  int? fitnessCenter;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    amount: json["amount"] == null ? null : json["amount"],
    duration: json["duration"] == null ? null : json["duration"],
    isTrendingNow: json["is_trending_now"] == null ? null : json["is_trending_now"],
    fitnessCenter: json["fitness_center"] == null ? null : json["fitness_center"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "amount": amount,
    "duration": duration,
    "is_trending_now": isTrendingNow,
    "fitness_center": fitnessCenter,
  };
}
