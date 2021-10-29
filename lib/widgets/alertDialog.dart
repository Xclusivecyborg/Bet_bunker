import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:spinchat/widgets/text_styles.dart';

import 'package:stacked_services/stacked_services.dart';

class SignOutDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const SignOutDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      title: Text(
        'Logging in',
        style: AppTextStyle.darkGreySize20Bold,
      ),
      content: Center(
        child: CircularProgressIndicator(
          color: kMynaveyBlue,
        ),
      ),
      // actions: [
      //   TextButton(
      //     child: Text(
      //       'Cancel',
      //       style: AppTextStyle.darkGreySize16,
      //     ),
      //     onPressed: () {
      //       completer(DialogResponse(confirmed: false));
      //     },
      //   ),
      //   TextButton(
      //     child: Text(
      //       'Sign Out',
      //       style: AppTextStyle.darkGreySize16,
      //     ),
      //     onPressed: () {
      //       completer(DialogResponse(confirmed: true));
      //     },
      //   ),
      // ],
    );
  }
}
