import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential>? signUp(String? email, String? password) {
    try {
      final newUSer = _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return newUSer;
    } on FirebaseException {
      throw Failure(message: 'Unable to register USer');
    } on SocketException {
      throw Failure(
          message: 'Could not register due to bad network connection');
    } catch (e) {
      Failure(message: e.toString());
    }
  }

  Future<UserCredential>? login(String? email, String? password) {
    try {
      final newUSer =
          _auth.signInWithEmailAndPassword(email: email!, password: password!);
      return newUSer;
    } on FirebaseAuthException {
      throw Failure(message: 'Unable to Sign in USer');
    } on SocketException {
      throw Failure(message: 'Could not Sign In due to bad network connection');
    } catch (e) {
      Failure(message: e.toString());
    }
  }

  Future? resetPassword(String? email) {
    try {
      final passwordReset = _auth.sendPasswordResetEmail(email: email!);
      return passwordReset;
    } catch (e) {
      Failure(message: e.toString());
    }
  }

  void logout() {
    _auth.signOut();
  }
}

class Failure {
  final String? message;

  Failure({this.message});

  @override
  String toString() {
    return this.message!;
  }
}
