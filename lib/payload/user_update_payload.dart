class UserUpdatePayload {
  final List<String> areasOfInterest; // Use List<String> instead of String[]
  final List<String> languagePreferences; // Use List<String> instead of String[]
  final List<String> talLeaderPreferences; // Use List<String> instead of String[]


  UserUpdatePayload({
    required this.areasOfInterest,
    required this.languagePreferences,
    required this.talLeaderPreferences,
  });

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'areasOfInterest': areasOfInterest,
      'languagePreferences': languagePreferences,
      'talLeaderPreferences': talLeaderPreferences,
    };
  }


}