// To parse this JSON data, do
//
//     final connectResponse = connectResponseFromJson(jsonString);

import 'dart:convert';

ConnectResponse connectResponseFromJson(String str) => ConnectResponse.fromJson(json.decode(str));

String connectResponseToJson(ConnectResponse data) => json.encode(data.toJson());

class ConnectResponse {
  final String? status;
  final int? statusCode;
  final String? message;
  final Data? data;

  ConnectResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  ConnectResponse copyWith({
    String? status,
    int? statusCode,
    String? message,
    Data? data,
  }) =>
      ConnectResponse(
        status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ConnectResponse.fromJson(Map<String, dynamic> json) => ConnectResponse(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? donationRequestInfo;
  final String? userInfo;
  final String? requestType;
  final int? connectionStatus;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.donationRequestInfo,
    this.userInfo,
    this.requestType,
    this.connectionStatus,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Data copyWith({
    String? donationRequestInfo,
    String? userInfo,
    String? requestType,
    int? connectionStatus,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        donationRequestInfo: donationRequestInfo ?? this.donationRequestInfo,
        userInfo: userInfo ?? this.userInfo,
        requestType: requestType ?? this.requestType,
        connectionStatus: connectionStatus ?? this.connectionStatus,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    donationRequestInfo: json["donation_request_info"],
    userInfo: json["user_info"],
    requestType: json["request_type"],
    connectionStatus: json["connectionStatus"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "donation_request_info": donationRequestInfo,
    "user_info": userInfo,
    "request_type": requestType,
    "connectionStatus": connectionStatus,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
