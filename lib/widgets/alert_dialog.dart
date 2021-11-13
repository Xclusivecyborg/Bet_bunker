import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/widgets/text_styles.dart';

import 'package:stacked_services/stacked_services.dart';

class SignOutDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  final String title;

  const SignOutDialog(
      {Key? key,
      required this.request,
      required this.completer,
      required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Text(
          title,
          style: AppTextStyle.darkGreySize20Bold,
        ),
        content: const SizedBox(
          height: 60,
          width: 30,
          child:  Center(
            child: CircularProgressIndicator(
              color: AppColors.naveyBlue,
            ),
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
      ),
    );
  }
}
