class LikeUnlikePayload {
  final String requestId;
  final String type;
  final String userId;

  LikeUnlikePayload({
    required this.requestId,
    required this.type,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'type': type,
      'userId': userId,

    };
  }
}
