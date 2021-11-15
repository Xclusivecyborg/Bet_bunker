import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/color_constants.dart';

class AppTextStyles {
  static const double _size20 = 20.3;
  static const FontWeight _boldWeight = FontWeight.w700;
  static TextStyle header1 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.myLightGrey,
  );
  static TextStyle bottombar = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.myRed,
  );

  static TextStyle child1 = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static TextStyle header2 = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.myDarkGrey,
  );
  static TextStyle hearderBold = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyText = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static TextStyle darkGreySize20Bold =
      _base(_size20, _boldWeight, AppColors.myMediumGrey);

  static TextStyle _base(
    double size,
    FontWeight? fontWeight,
    Color? color,
  ) {
    return baseStyle(fontSize: size, fontWeight: fontWeight, color: color);
  }

  static TextStyle baseStyle({
    double fontSize = 13,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? Colors.grey[600],
    );
  }
}
