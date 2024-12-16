
import 'dart:convert';

ShareModel shareModelFromJson(String str) => ShareModel.fromJson(json.decode(str));

String shareModelToJson(ShareModel data) => json.encode(data.toJson());

class ShareModel {
  String status;
  String message;
  int statusCode;
  Data data;

  ShareModel({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory ShareModel.fromJson(Map<String, dynamic> json) => ShareModel(
    status: json["status"],
    message: json["message"],
    statusCode: json["statusCode"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "statusCode": statusCode,
    "data": data.toJson(),
  };
}

class Data {
  int likeCount;
  int noOfViews;
  int shareCount;
  int noOfImpressions;
  int commentCount;
  int noOfButtonClicks;
  int postEngaged;

  Data({
    required this.likeCount,
    required this.noOfViews,
    required this.shareCount,
    required this.noOfImpressions,
    required this.commentCount,
    required this.noOfButtonClicks,
    required this.postEngaged,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    likeCount: json["likeCount"],
    noOfViews: json["noOfViews"],
    shareCount: json["shareCount"],
    noOfImpressions: json["noOfImpressions"],
    commentCount: json["commentCount"],
    noOfButtonClicks: json["noOfButtonClicks"],
    postEngaged: json["postEngaged"],
  );

  Map<String, dynamic> toJson() => {
    "likeCount": likeCount,
    "noOfViews": noOfViews,
    "shareCount": shareCount,
    "noOfImpressions": noOfImpressions,
    "commentCount": commentCount,
    "noOfButtonClicks": noOfButtonClicks,
    "postEngaged": postEngaged,
  };
}
