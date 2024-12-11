class InvitePayload {
  final String email;
  final String firstName;
  final String lastName;

  InvitePayload({
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,

    };
  }
}
