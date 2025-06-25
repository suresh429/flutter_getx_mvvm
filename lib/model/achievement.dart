class Achievement {
  String id;
  String awardTitle;
  String awardIssuedBy;
  String awardDescription;
  DateTime updatedAt;
  DateTime createdAt;

  Achievement({
    required this.id,
    required this.awardTitle,
    required this.awardIssuedBy,
    required this.awardDescription,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    id: json["_id"],
    awardTitle: json["awardTitle"],
    awardIssuedBy: json["awardIssuedBy"],
    awardDescription: json["awardDescription"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "awardTitle": awardTitle,
    "awardIssuedBy": awardIssuedBy,
    "awardDescription": awardDescription,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}
