
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_tracker/core/errors/auth_failure.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

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


  // 🔹 Google Login
  Future<User?> googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // user canceled

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      print("${result.user!.email.toString()} ?????????");
      return result.user;
    }on FirebaseException catch(e){
      throw AuthFailure.fromCode(e.code);
    }catch (e) {
      throw AuthFailure("Google sign-in failed");
    }
  }

  // 🔹 Forgot Password
  Future<void> resetPassword(String email) async {
    try {
     await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure.fromCode(e.code);
    } catch (_) {
      throw AuthFailure("Failed to send reset email");
    }
  }

  Future<void> logout()  async {
  await _googleSignIn.signOut();
  await _auth.signOut();
}

  Stream<User?> authStateChanges() => _auth.authStateChanges();
}