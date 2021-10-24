import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:spinchat/widgets/custom_snackbar.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app.locator.dart';

class FirebaseAuthService {
  static FirebaseAuthService? _instance;
  static FirebaseAuth? _auth;
  final _snackbar = locator<SnackbarService>();

  static Future<FirebaseAuthService> getInstance() async {
    _instance ??= FirebaseAuthService();
    _auth ??= FirebaseAuth.instance;
    return _instance!;
  }

  Future<UserCredential>? signUp(String? email, String? password) {
    try {
      final newUSer = _auth!
          .createUserWithEmailAndPassword(email: email!, password: password!);
      return newUSer;
    } on FirebaseException {
      throw Failure(message: 'Unable to register Ueer');
    } on SocketException {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.Failure,
          message: 'Please check your internet connection');
    } catch (e) {
      Failure(message: e.toString());
    }
  }

  Future<UserCredential>? login(String? email, String? password) {
    try {
      final newUSer =
          _auth!.signInWithEmailAndPassword(email: email!, password: password!);
      return newUSer;
    } catch (e) {
      Failure(message: e.toString());
    }
  }

  Future? resetPassword(String? email) {
    try {
      final passwordReset = _auth!.sendPasswordResetEmail(email: email!);

      return passwordReset;
    } on SocketException {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.Failure,
          message: 'Please check your internet connection');
    } catch (e) {
      Failure(message: e.toString());
    }
  }

  User? getCurrentUSer() {
    try {
      final user = _auth!.currentUser;
      return user;
    } catch (e) {
      print(e);
    }
  }

  void logout() {
    _auth!.signOut();
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
