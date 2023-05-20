import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final StreamController<UserData?> _userStatusController =
      StreamController<UserData?>();

  Stream<UserData?> get userStatusStream => _userStatusController.stream;

  AuthProvider() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      _userStatusController.add(UserData.fromFirebaseUser(user));
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void dispose() {
    _userStatusController.close();
  }
}

class UserData {
  UserData(this.email);

  final String email;

  static UserData? fromFirebaseUser(User? user) {
    return user != null ? UserData(user.email!) : null;
  }
}
