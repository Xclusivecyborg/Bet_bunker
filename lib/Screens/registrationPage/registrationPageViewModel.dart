import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:spinchat/app/services/authService.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/app/services/storage_keys.dart';
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
  final _storage = locator<SharedPreferenceLocalStorage>();
  final _snackbar = locator<SnackbarService>();
  final _authservice = locator<FirebaseAuthService>();
  final _dialog = locator<DialogService>();

  void signUp() {
    try {
    
      if (resetForm.currentState!.validate()) {
        _dialog.showCustomDialog(
          variant: DialogType.signOut,
        );
        final registeredUSer =
            _authservice.signUp(emailController.text, passwordController.text);
        if (registeredUSer != null) {
          _storage.setBool(StorageKeys.userLoggedInKey, true);
          _storage.setString(StorageKeys.usernameKey, userNameController.text);
          updateUserinfo();
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

  String? confirmPasswordFields(String? value) {
    if (passwordController.text != confirmPassword.text) {
      return 'Passwords do not match!.';
    }
    notifyListeners();
  }

  void updateUserinfo() async {
    Map<String, dynamic> userMap = {
      'email': emailController.text,
      'name': userNameController.text
    };
    try {
      await _fireStore.collection('users').add(userMap);
    } catch (e) {
      print(Failure(message: e.toString()));
    }
    notifyListeners();
  }
}
