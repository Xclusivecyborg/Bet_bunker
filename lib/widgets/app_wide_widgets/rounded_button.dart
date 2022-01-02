import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Function()? onTap;

  final double? width;
  const CustomButton({
    Key? key,
    this.label = 'Label',
    this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: width ?? MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.naveyBlue,
              AppColors.myGreen,
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            label!,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
