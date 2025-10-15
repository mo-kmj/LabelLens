// lib/services/auth_service.dart
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  User? get currentUser => _auth.currentUser;  // Added this getter to fix profile_page error
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Initialize Google Sign-In (call once at app start, e.g., in main())
  static Future<void> initialize() async {
    if (kIsWeb) {
      // Replace with your actual client ID from Google Cloud Console
      // await _googleSignIn.initialize(clientId: 'your_web_client_id.apps.googleusercontent.com');
      await _googleSignIn.initialize();  // Omit clientId for testing, but add for production
      if (!_googleSignIn.supportsAuthenticate()) {
        throw UnsupportedError('Web platform does not support authenticate()');
      }
    }
  }

  // Sign up with email and password (Gmail only)
  Future<String?> signUpWithEmail(String email, String password) async {
    try {
      if (!email.endsWith('@gmail.com')) {
        return 'Only @gmail.com email addresses are allowed';
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return 'Password is too weak';
        case 'email-already-in-use':
          return 'An account already exists for this email';
        case 'invalid-email':
          return 'Invalid email address';
        default:
          return e.message ?? 'An error occurred';
      }
    } catch (e) {
      return 'An unexpected error occurred';
    }
  }

  // Sign in with email and password
  Future<String?> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email';
        case 'wrong-password':
          return 'Incorrect password';
        case 'invalid-email':
          return 'Invalid email address';
        case 'user-disabled':
          return 'This account has been disabled';
        default:
          return e.message ?? 'An error occurred';
      }
    } catch (e) {
      return 'An unexpected error occurred';
    }
  }

  // Sign in with Google
  Future<String?> signInWithGoogle() async {
    try {
      await initialize();  // Ensure initialized for web

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;  // Synchronous in v7+

      // Get accessToken via authorization for scopes
      final List<String> scopes = ['email', 'profile'];
      final GoogleSignInClientAuthorization? authorization = await _googleSignIn.authorizationClient
          .authorizationForScopes(scopes);

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: authorization?.accessToken,
      );

      await _auth.signInWithCredential(credential);
      notifyListeners();
      return null;
    } on GoogleSignInException catch (e) {
      switch (e.code.name) {
        case 'canceled':
          return 'Sign in was cancelled';
        case 'interrupted':
          return 'Sign in was interrupted';
        default:
          return 'Google sign in failed: ${e.description ?? e.toString()}';
      }
    } catch (e) {
      return 'Google sign in failed: ${e.toString()}';
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    notifyListeners();
  }

  // Reset password
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'Invalid email address';
        case 'user-not-found':
          return 'No user found with this email';
        default:
          return e.message ?? 'An error occurred';
      }
    } catch (e) {
      return 'An unexpected error occurred';
    }
  }
}