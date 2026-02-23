
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_tracker/core/errors/auth_failure.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
   try{
     final result = await _auth.signInWithEmailAndPassword(
       email: email,
       password: password,
     );
     return result.user;
   }on FirebaseAuthException catch(e){
     print("Firebase Login Error: ${e.code}");

     throw AuthFailure.fromCode(e.code);
   }
  }


  Future<User?> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    }on FirebaseAuthException catch(e){
      throw AuthFailure.fromCode(e.code);
    }
  }

  Future<void> logout() async => _auth.signOut();

  Stream<User?> authStateChanges() => _auth.authStateChanges();
}