// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart'; // ChangeNotifier lives here
// import '../../../core/services/auth_service.dart';
//
//
// // class AuthViewModel extends ChangeNotifier{
// //   final AuthService _authService=AuthService();
// //   User? _currentUser;  // ← Add this field (Firebase User)
// //   bool loading=false;
// //   String? error;
// //   User? get currentUser => _currentUser;  // getter (safe)
// //   void setCurrentUser(User? user) {
// //     if (_currentUser != user) {
// //       _currentUser = user;
// //       notifyListeners();  // extra safety
// //     }
// //   }
// //   Future<void> login(String email, String password)async{
// //     try{
// //       loading=true;
// //       notifyListeners();
// //       await _authService.login(email, password);
// //       // _currentUser = user;
// //     }catch(e){
// //       error=e.toString();
// //     }finally {
// //       loading = false;
// //       notifyListeners();
// //     }
// //
// //   }
// //
// //   Future<void> register(String email,String password)async{
// //     try{
// //       loading=true;
// //       notifyListeners();
// //       await _authService.register(email, password);
// //     }catch(e){
// //       error=e.toString();
// //     }
// //     loading=false;
// //     notifyListeners();
// //   }
//
//   // login(email, password){
//   //   return _authService.login(email, password);
//   // }
// // }
//
// // In AuthViewModel (or any class with access to ref)
//
// class AuthViewModel extends ChangeNotifier {
//   // Remove this line completely:
//   // final AuthService _authService = AuthService();
//   final AuthService _authService=AuthService();
//   User? _currentUser;  // ← Add this field (Firebase User)
//   bool loading=false;
//   String? error;
//   User? get currentUser => _currentUser;
//   // Instead, use ref.read or ref.watch when needed
//   Future<void> login(String email, String password) async {
//     try {
//       loading = true;
//       error = null;
//       notifyListeners();
//
//       // Use the provider here
//       final user = await ref.read(authServiceProvider).login(email, password);
//
//       currentUser = user;  // if you still keep this field
//
//     } catch (e) {
//       error = e.toString();
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }
// }
// lib/features/auth/view_models/auth_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:job_tracker/core/errors/auth_failure.dart';
import 'package:job_tracker/core/services/firestore_service.dart';
import '../../../core/services/auth_service.dart';
import 'auth_state.dart';

final authServiceProvider = Provider((ref) => AuthService());
final firestoreServiceProvider = Provider((ref) => FirestoreService());
// Firebase auth state stream
final authStateProvider = StreamProvider((ref) {
  return ref.read(authServiceProvider).authStateChanges();
});



class AuthViewModel extends StateNotifier<AuthState> {
  final AuthService _auth;
  final FirestoreService _firestore;

  AuthViewModel(this._auth, this._firestore) : super(const AuthState());
  // AuthViewModel(this._auth) : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(loading: true, error: null);

    try {
      await _auth.login(email, password);
    } on AuthFailure catch (e) {
      state = state.copyWith(error: e.message);
    } finally {
      state = state.copyWith(loading: false);
    }
  }


  Future<void> register(String email, String password,String name) async {
    state = state.copyWith(loading: true, error: null);
    // await _auth.register(email, password);
    state = state.copyWith(loading: true, error: null);

    try {
      final user = await _auth.register(email, password);

      if (user != null) {
        await _firestore.createUser(
          uid: user.uid,
          name: name,
          email: email,
        );
      }
    } on AuthFailure catch (e) {
      print("$e");
      state = state.copyWith(error: e.message);
    } catch (e) {
      print("$e");
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(loading: false);
    }


  }

  Future<void> googleLogin() async {
    try {
      state = AuthState(loading: true);
      await _auth.googleLogin();
      state = AuthState();
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      state = AuthState(loading: true);
      await _auth.resetPassword(email);
      state = AuthState();
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.logout();
  }


}

final authViewModelProvider =
StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.read(authServiceProvider),
    ref.read(firestoreServiceProvider),
  );
});

// final authViewModelProvider =
// StateNotifierProvider<AuthViewModel, AuthState>((ref) {
//   return AuthViewModel(ref.read(authServiceProvider));
// });
