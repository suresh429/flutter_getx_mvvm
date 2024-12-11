import 'dart:convert';

CommonModel commonModelFromJson(String str) => CommonModel.fromJson(json.decode(str));

String commonModelToJson(CommonModel data) => json.encode(data.toJson());

class CommonModel {
  String? status;
  String? message;
  int? statusCode;
  Data? data;

  CommonModel({
    this.status,
    this.message,
    this.statusCode,
    this.data,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
    status: json["status"],
    message: json["message"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "statusCode": statusCode,
    "data": data?.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
