import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:spinchat/app/services/firebse_auth_service.dart';
import 'package:spinchat/widgets/custom_snackbar.dart';
import 'package:spinchat/widgets/setup_ui_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegistrationPageViewModel extends BaseViewModel {
  GlobalKey<FormState> resetForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _navigation = locator<NavigationService>();
  final _snackbar = locator<SnackbarService>();
  final _authservice = locator<FirebaseAuthService>();
  final _dialog = locator<DialogService>();

  void signUp() async {
    try {
      if (resetForm.currentState!.validate()) {
        _dialog.showCustomDialog(
          variant: DialogType.register,
        );
        final registeredUSer = await _authservice.signUp(
            emailController.text, passwordController.text);
        if (registeredUSer != null) {    
          updateUserinfo(registeredUSer.user!.uid);
          _navigation.back();
          _snackbar.showCustomSnackBar(
              variant: SnackBarType.Success,
              duration: const Duration(seconds: 3),
              message: 'Registration Successful');
          _navigation.navigateTo(Routes.loginScreen);
        } else if (emailController.text.isEmpty ||
            passwordController.text.isEmpty ||
            emailController.text == '' ||
            passwordController.text == '') {
          _snackbar.showCustomSnackBar(
              variant: SnackBarType.Failure, message: 'Please fill all fields');
        }
      }
    } on FirebaseException catch (e) {
      _navigation.back();
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.Failure,
          duration: const Duration(seconds: 2),
          message: '${e.message}');
    } on SocketException {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.Failure,
          message: 'Please check your internet connection');
    }
    notifyListeners();
  }

  void navigateToLogin() {
    _navigation.replaceWith(Routes.loginScreen);
  }

  String? confirmPasswordFields(String? value) {
    if (value! != passwordController.text) {
      return 'Passwords do not match!.';
    }
  }

  void updateUserinfo(String uid) async {
    Map<String, dynamic> userMap = {
      'userId': uid,
      'chattingWith': '',
      'email': emailController.text,
      'userName': userNameController.text,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    try {
      await _fireStore.collection('users').doc(uid).set(userMap);
    } catch (e) {
      print(Failure(message: e.toString()));
    }
    notifyListeners();
  }
}
