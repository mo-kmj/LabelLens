// lib/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';  // Import your AuthService

class AuthProvider with ChangeNotifier {
  User? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();  // Delegate to service

  User? get user => _user;
  bool get isLoggedIn => _user != null;
  Stream<User?> get authStateChanges => _auth.authStateChanges();  // This getter fixes the error

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Delegate sign-up to service
  Future<String?> signUpWithEmail(String email, String password) async {
    final error = await _authService.signUpWithEmail(email, password);
    if (error == null) notifyListeners();
    return error;
  }

  // Delegate sign-in with email to service
  Future<String?> signInWithEmail(String email, String password) async {
    final error = await _authService.signInWithEmail(email, password);
    if (error == null) notifyListeners();
    return error;
  }

  // Delegate Google sign-in to service
  Future<String?> signInWithGoogle() async {
    final error = await _authService.signInWithGoogle();
    if (error == null) notifyListeners();
    return error;
  }

  // Delegate sign-out to service
  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }

  // Delegate password reset to service
  Future<String?> resetPassword(String email) async {
    return await _authService.resetPassword(email);
  }
}