class Experience {
  String? id;
  String? role;
  String? company;
  int? experienceStartDate;
  int? experienceEndDate;
  String? logoUrl;
  int? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic description;
  dynamic designation;

  Experience({
    this.id,
    this.role,
    this.company,
    this.experienceStartDate,
    this.experienceEndDate,
    this.logoUrl,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.description,
    this.designation,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json["_id"],
    role: json["role"],
    company: json["company"],
    experienceStartDate: json["experienceStartDate"],
    experienceEndDate: json["experienceEndDate"],
    logoUrl: json["logoUrl"],
    status: json["status"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    description: json["description"],
    designation: json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "role": role,
    "company": company,
    "experienceStartDate": experienceStartDate,
    "experienceEndDate": experienceEndDate,
    "logoUrl": logoUrl,
    "status": status,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "description": description,
    "designation": designation,
  };

  Experience copyWith({
    String? id,
    String? role,
    String? company,
    int? experienceStartDate,
    int? experienceEndDate,
    String? logoUrl,
    int? status,
    DateTime? updatedAt,
    DateTime? createdAt,
    dynamic description,
    dynamic designation,
  }) {
    return Experience(
      id: id ?? this.id,
      role: role ?? this.role,
      company: company ?? this.company,
      experienceStartDate: experienceStartDate ?? this.experienceStartDate,
      experienceEndDate: experienceEndDate ?? this.experienceEndDate,
      logoUrl: logoUrl ?? this.logoUrl,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      designation: designation ?? this.designation,
    );
  }
}
