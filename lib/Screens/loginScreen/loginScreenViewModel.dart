import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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

class LoginScreenViewModel extends FormViewModel {
  GlobalKey<FormState> resetForm = GlobalKey<FormState>();
  final _navigation = locator<NavigationService>();
  final _storage = locator<SharedPreferenceLocalStorage>();
  final _dialog = locator<DialogService>();
  final _authservice = locator<FirebaseAuthService>();
  final _snackbar = locator<SnackbarService>();
  User? get loggedInUSer => _authservice.getCurrentUSer();
  bool isLoading = true;
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<UserCredential?> login() async {
    try {
      if (resetForm.currentState!.validate()) {
        _dialog.showCustomDialog(
          variant: DialogType.signOut,
        );
        final createdUser = await _authservice.login(
            newEmailController.text, newPasswordController.text);
        if (createdUser != null) {
          _storage.setString(StorageKeys.userEmailKey, loggedInUSer!.email!);
          _navigation.back();
          _snackbar.showCustomSnackBar(
              variant: SnackBarType.Success,
              duration: const Duration(seconds: 2),
              message: 'Loggin Successful for ${loggedInUSer!.email!}');
          _navigation.navigateTo(Routes.chatView);
          print(loggedInUSer!.uid);
          return createdUser;
        }
      } else if (newEmailController.text.isEmpty ||
          newPasswordController.text.isEmpty ||
          newEmailController.text == '' ||
          newPasswordController.text == '') {
        _snackbar.showCustomSnackBar(
            variant: SnackBarType.Failure, message: 'Please fill all fields');
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

  @override
  void setFormStatus() {}
}
