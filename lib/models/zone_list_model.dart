// To parse this JSON data, do
//
//     final zoneListModel = zoneListModelFromJson(jsonString);

import 'dart:convert';

ZoneListModel zoneListModelFromJson(String str) => ZoneListModel.fromJson(json.decode(str));

String zoneListModelToJson(ZoneListModel data) => json.encode(data.toJson());

class ZoneListModel {
  ZoneListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<ZoneResult>? results;

  factory ZoneListModel.fromJson(Map<String, dynamic> json) => ZoneListModel(
    count: json["count"] == null ? null : json["count"],
    next: json["next"] == null ? null : json["next"],
    previous: json["previous"] == null ? null : json["previous"],
    results: json["results"] == null ? null : List<ZoneResult>.from(json["results"].map((x) => ZoneResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class ZoneResult {
  ZoneResult({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory ZoneResult.fromJson(Map<String, dynamic> json) => ZoneResult(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
