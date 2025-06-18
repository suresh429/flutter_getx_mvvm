// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  final String? id;
  final int? locationModelId;
  final String? name;
  final int? stateId;
  final String? stateCode;
  final String? stateName;
  final String? countryId;
  final String? countryName;
  final String? latitude;
  final String? longitude;
  final String? wikiDataId;

  LocationModel({
    this.id,
    this.locationModelId,
    this.name,
    this.stateId,
    this.stateCode,
    this.stateName,
    this.countryId,
    this.countryName,
    this.latitude,
    this.longitude,
    this.wikiDataId,
  });

  LocationModel copyWith({
    String? id,
    int? locationModelId,
    String? name,
    int? stateId,
    String? stateCode,
    String? stateName,
    String? countryId,
    String? countryName,
    String? latitude,
    String? longitude,
    String? wikiDataId,
  }) =>
      LocationModel(
        id: id ?? this.id,
        locationModelId: locationModelId ?? this.locationModelId,
        name: name ?? this.name,
        stateId: stateId ?? this.stateId,
        stateCode: stateCode ?? this.stateCode,
        stateName: stateName ?? this.stateName,
        countryId: countryId ?? this.countryId,
        countryName: countryName ?? this.countryName,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        wikiDataId: wikiDataId ?? this.wikiDataId,
      );

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    id: json["_id"],
    locationModelId: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    stateCode: json["state_code"],
    stateName: json["state_name"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    wikiDataId: json["wikiDataId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "id": locationModelId,
    "name": name,
    "state_id": stateId,
    "state_code": stateCode,
    "state_name": stateName,
    "country_id": countryId,
    "country_name": countryName,
    "latitude": latitude,
    "longitude": longitude,
    "wikiDataId": wikiDataId,
  };
}
