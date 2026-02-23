class AuthFailure {
  final String message;
  AuthFailure(this.message);

  factory AuthFailure.fromCode(String code) {
    switch (code) {
      case 'wrong-password':
        return AuthFailure("Incorrect password");
      case 'user-not-found':
        return AuthFailure("User not found");
      case 'invalid-email':
        return AuthFailure("Invalid email address");
      case 'invalid-credential':
        return AuthFailure("Invalid password");
      case 'too-many-requests':
        return AuthFailure("Too many attempts. Try later.");
      default:
        return AuthFailure("Something went wrong");
    }
  }
}