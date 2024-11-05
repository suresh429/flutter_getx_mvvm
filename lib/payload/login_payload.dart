class LoginPayload {
  final String account;
  final String password;
  final bool rememberMe;
  final String sourceOfLogin;

  LoginPayload({
    required this.account,
    required this.password,
    required this.rememberMe,
    required this.sourceOfLogin,
  });

  Map<String, dynamic> toJson() {
    return {
      'account': account,
      'password': password,
      'rememberMe': rememberMe,
      'sourceOfLogin': sourceOfLogin,
    };
  }
}
