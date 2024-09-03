class LoginCredentials {
  final String username;
  final String password;

  LoginCredentials({required this.username, required this.password});

  // Sobrescribir el operador ==
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginCredentials &&
        other.username == username &&
        other.password == password;
  }

  // Sobrescribir el hashCode
  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
