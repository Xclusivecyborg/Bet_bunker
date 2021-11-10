import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:spinchat/widgets/custom_snackbar.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app.locator.dart';

class GoogleAuthService {
  static GoogleAuthService? _instance;
  static GoogleSignIn? _googleAuth;
  final _snackbar = locator<SnackbarService>();

  static Future<GoogleAuthService> getInstance() async {
    _instance ??= GoogleAuthService();
    _googleAuth ??= GoogleSignIn();
    return _instance!;
  }

  Future googleSignIn() async {
    try {
      final user = await _googleAuth!.signIn();
      print(user!.id);
      return user;
    } on SocketException {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.Failure,
          message: 'Please check your internet connection');
    } catch (e) {
      throw Failure(message: e.toString());
    }
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
