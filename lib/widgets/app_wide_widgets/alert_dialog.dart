import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/app_styles.dart';
import 'package:spinchat/utils/constants/color_constants.dart';



class SignOutDialog extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const SignOutDialog({Key? key, required this.title, this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Text(
          title,
          style: AppTextStyles.darkGreySize20Bold,
        ),
        content: const SizedBox(
          height: 60,
          width: 30,
          child: Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: AppColors.naveyBlue,
            ),
          ),
        ),
        actions: actions,
      ),
    );
  }
}

class ScheduleDialog extends StatelessWidget {
  final String title;
  final List<Widget> action;
  const ScheduleDialog({
    Key? key,
    required this.title,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        elevation: 6,
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Stack(
          alignment: Alignment.center,
          children: const [
            Icon(
              CupertinoIcons.paperplane_fill,
              size: 70,
            ),
            Positioned(
              bottom: 2,
              right: 80,
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
        actions: action,
      ),
    );
  }
}
