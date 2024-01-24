import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance Firebase Auth
  final _authService = FirebaseAuth.instance;

  // sign in
  Future<UserCredential> handleLogin(String email, String password) async {
    try {
      final credential = await _authService.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  // sign up

  Future<void> handleSignUp(String email, String password) async {
    try {
      final credential = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("credential: $credential");
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> handleSignOut() async {
    await _authService.signOut();
  }
}
