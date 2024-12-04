class FavPayload {
  final List<String> requestId; // Use List<String> instead of String[]
  final String type;
  final String? userId;

  FavPayload({
    required this.requestId,
    required this.type,
    required this.userId,
  });

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'type': type,
      'userId': userId,
    };
  }

  // Override the toString method to print the object in a readable format
  @override
  String toString() {
    return 'FavPayload(requestId: $requestId, type: $type, userId: $userId)';
  }
}