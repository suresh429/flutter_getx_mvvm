class ReviewModel {
  String? id;
  String? userId;
  String? senderProfileImageUrl;
  String? senderName;
  String? text;
  int? whenSent;
  String? type;
  bool isDeleted = false;

  ReviewModel({
    this.id,
    this.userId,
    this.senderProfileImageUrl,
    this.senderName,
    this.text,
    this.whenSent,
    this.type,
    this.isDeleted = false,
  });

  /// Factory to create from Firebase snapshot value
  factory ReviewModel.fromMap(Map<dynamic, dynamic> map) {
    final data = Map<String, dynamic>.from(map);
    return ReviewModel(
      userId: data['userId'] as String?,
      senderProfileImageUrl: data['senderProfileImageUrl'] as String?,
      senderName: data['senderName'] as String?,
      text: data['text'] as String?,
      whenSent: data['whenSent'] is int
          ? data['whenSent'] as int
          : int.tryParse(data['whenSent']?.toString() ?? ''),
      type: data['type'] as String?,
    );
  }

  /// Convert back to Firebase format
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'senderProfileImageUrl': senderProfileImageUrl,
      'senderName': senderName,
      'text': text,
      'whenSent': whenSent,
      'type': type,
    };
  }
}
