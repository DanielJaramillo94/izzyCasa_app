import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  UserData? userData;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final StreamController<UserData?> _userStatusController =
      StreamController<UserData?>();

  Stream<UserData?> get userStatusStream => _userStatusController.stream;

  AuthProvider() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      _userStatusController.add(UserData.fromFirebaseUser(user));
      userData = UserData.fromFirebaseUser(user);
      notifyListeners();
    });
  }

  bool get isAuthenticated => _firebaseAuth.currentUser != null;

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

  @override
  void dispose() {
    _userStatusController.close();
    super.dispose();
  }
}

class UserData {
  UserData(this.email);

  final String email;

  static UserData? fromFirebaseUser(User? user) {
    return user != null ? UserData(user.email!) : null;
  }
}
