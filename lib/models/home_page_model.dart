// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

import 'fitness_center_list_model.dart';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  HomePageModel({
    this.content,
  });

  List<HomePageModelContent>? content;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
    content: List<HomePageModelContent>.from(json["content"].map((x) => HomePageModelContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content!.map((x) => x.toJson())),
  };
}

class HomePageModelContent {
  HomePageModelContent({
    this.model,
    this.title,
    this.slug,
    this.content,
    this.viewAll,
    this.bg,
    this.color,
  });

  String? model;
  String? title;
  String? slug;
  List<ContentContent>? content;
  bool? viewAll;
  String? bg;
  String? color;

  factory HomePageModelContent.fromJson(Map<String, dynamic> json) => HomePageModelContent(
    model: json["model"] == null ? null : json["model"],
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    content: json["content"] == null ? null : List<ContentContent>.from(json["content"].map((x) => ContentContent.fromJson(x))),
    viewAll: json["view_all"] == null ? null : json["view_all"],
    bg: json["bg"] == null ? null : json["bg"],
    color: json["color"] == null ? null : json["color"],
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "title": title,
    "slug": slug,
    "content": List<dynamic>.from(content!.map((x) => x.toJson())),
    "view_all": viewAll,
    "bg": bg,
    "color": color,
  };
}

class ContentContent {
  ContentContent({
    this.id,
    this.name,
    this.description,
    this.logo,
    this.amenities,
    this.institution,
    this.plans,
    this.rules,
    this.category,
    this.opensAt,
    this.closesAt,
    this.mobile,
    this.email,
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
    this.title,
    this.image,
  });

  int? id;
  String? name;
  String? description;
  String? logo;
  Amenities? amenities;
  Institution? institution;
  List<Plan>? plans;
  List<Amenities>? rules;
  List<Amenities>? category;
  String? opensAt;
  String? closesAt;
  String? mobile;
  String? email;
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
  String? title;
  String? image;

  factory ContentContent.fromJson(Map<String, dynamic> json) => ContentContent(
    id: json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    logo: json["logo"] == null ? null : json["logo"],
    amenities: json["amenities"] == null ? null : Amenities.fromJson(json["amenities"]),
    institution: json["institution"] == null ? null : Institution.fromJson(json["institution"]),
    plans: json["plans"] == null ? null : List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
    rules: json["rules"] == null ? null : List<Amenities>.from(json["rules"].map((x) => Amenities.fromJson(x))),
    category: json["category"] == null ? null : List<Amenities>.from(json["category"].map((x) => Amenities.fromJson(x))),
    opensAt: json["opens_at"] == null ? null : json["opens_at"],
    closesAt: json["closes_at"] == null ? null : json["closes_at"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    email: json["email"] == null ? null : json["email"],
    location: json["location"],
    contact: json["contact"] == null ? null : json["contact"],
    addressLine1: json["address_line1"] == null ? null : json["address_line1"],
    addressLine2: json["address_line2"] == null ? null : json["address_line2"],
    addressLine3: json["address_line3"] == null ? null : json["address_line3"],
    addressLine4: json["address_line4"] == null ? null : json["address_line4"],
    instagramUrl: json["instagram_url"] == null ? null : json["instagram_url"],
    facebookUrl: json["facebook_url"] == null ? null : json["facebook_url"],
    youtubeUrl: json["youtube_url"] == null ? null : json["youtube_url"],
    zone: json["zone"] == null ? null : json["zone"],
    title: json["title"] == null ? null : json["title"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "logo": logo == null ? null : logo,
    "amenities": amenities == null ? null : amenities!.toJson(),
    "institution": institution == null ? null : institution!.toJson(),
    "plans": plans == null ? null : List<dynamic>.from(plans!.map((x) => x.toJson())),
    "rules": rules == null ? null : List<dynamic>.from(rules!.map((x) => x.toJson())),
    "category": category == null ? null : List<dynamic>.from(category!.map((x) => x.toJson())),
    "opens_at": opensAt == null ? null : opensAt,
    "closes_at": closesAt == null ? null : closesAt,
    "mobile": mobile == null ? null : mobile,
    "email": email == null ? null : email,
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
    "title": title == null ? null : title,
    "image": image == null ? null : image,
  };
}