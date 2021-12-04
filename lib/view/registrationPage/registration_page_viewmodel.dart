import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.logger.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:spinchat/app/models.dart/user_model.dart';
import 'package:spinchat/app/services/firebse_auth_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/utils/storage_keys.dart';
import 'package:spinchat/widgets/package_widgets/custom_snackbar.dart';
import 'package:spinchat/widgets/package_widgets/setup_ui_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegistrationPageViewModel extends BaseViewModel {
  final log = getLogger('Registration');
  GlobalKey<FormState> resetForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final _fireStore = FirebaseFirestore.instance;
  final _navigation = locator<NavigationService>();
  final _snackbar = locator<SnackbarService>();
  final _authservice = locator<FirebaseAuthService>();
  final _dialog = locator<DialogService>();
  final _storage = locator<SharedPreferenceLocalStorage>();

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
          await _storage.setBool(StorageKeys.registered, true);
          _navigation.back();
          _snackbar.showCustomSnackBar(
              variant: SnackBarType.success,
              duration: const Duration(seconds: 3),
              message: 'Registration Successful');
          _navigation.navigateTo(Routes.loginScreen);
        }
      } else if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          userNameController.text.isEmpty ||
          confirmPassword.text.isEmpty) {
        _snackbar.showCustomSnackBar(
            variant: SnackBarType.failure, message: 'Please fill all fields');
      }
    } on FirebaseException catch (e) {
      _navigation.back();
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.failure,
          duration: const Duration(seconds: 2),
          message: '${e.message}');
    } on SocketException {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.failure,
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
    try {
      await _fireStore.collection('users').doc(uid).set(Users.toFireStore(
          userId: uid,
          email: emailController.text,
          userName: userNameController.text,
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          aboutMe: '',
          loggedIn: false,
          photoUrl: ''));
    } catch (e) {
      log.e(Failure(message: e.toString()));
    }
    notifyListeners();
  }
}
