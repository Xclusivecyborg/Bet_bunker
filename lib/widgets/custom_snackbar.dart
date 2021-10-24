import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';

class AppSnackBar {
  static void setupSnackbarUi() {
    final service = locator<SnackbarService>();

    service.registerCustomSnackbarConfig(
      variant: SnackBarType.Success,
      config: SnackbarConfig(
        backgroundColor: kMynaveyBlue,
        textColor: KmyGreen,
        borderRadius: 1,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        // animationDuration: const Duration(seconds: 3),
        margin: const EdgeInsets.only(bottom: 0, right: 0, left: 0),
        barBlur: 0.6,
        messageColor: KmyGreen,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
      ),
    );

    service.registerCustomSnackbarConfig(
      variant: SnackBarType.Failure,
      config: SnackbarConfig(
        backgroundColor: kMyRed,
        textColor: KMyWhite,
        borderRadius: 1,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        // animationDuration: const Duration(seconds: 3),
        margin: const EdgeInsets.only(bottom: 0, right: 0, left: 0),
        barBlur: 0.6,
        messageColor: KMyWhite,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
      ),
    );
  }
}

enum SnackBarType { Success, Failure }
