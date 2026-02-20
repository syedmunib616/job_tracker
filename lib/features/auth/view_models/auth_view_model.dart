import '../../../core/services/auth_service.dart';

class AuthViewModel {
  final AuthService _authService=AuthService();

  login(email, password){
    return _authService.login(email, password);
  }
}