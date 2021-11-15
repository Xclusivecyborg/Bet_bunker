import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/color_constants.dart';

class AppTextStyles {
  static TextStyle header1 = GoogleFonts.spinnaker(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.myLightGrey,
  );
  static TextStyle bottombar = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.myRed,
  );

  static TextStyle child1 = GoogleFonts.spinnaker(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static TextStyle header2 = GoogleFonts.spinnaker(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.myDarkGrey,
  );
  static TextStyle hearderBold = GoogleFonts.spinnaker(
    color: AppColors.black,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyText = GoogleFonts.spinnaker(
    color: AppColors.black,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}
