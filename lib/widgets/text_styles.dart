import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/constants.dart';


class AppTextStyle {
  // static const double _size10 = 11;
  static const double _size12 = 13;
  static const double _size14 = 14.5;
  static const double _size16 = 16.2;
  static const double _size18 = 19;
  static const double _size20 = 20.3;
  // static const double _size23 = 24;

  // static const FontWeight _thinWeight = FontWeight.w300;
  static const FontWeight _normalWeight = FontWeight.w400;
  static const FontWeight _boldWeight = FontWeight.w700;

  //

  //?Text Styles go below
  //colorSizeFontWeight
  static TextStyle darkGreySize12 =
      _base(_size12, _normalWeight, kMyLightGrey);

  ///Note: This is the normal text used in the app
  static TextStyle darkGreySize14 =
      _base(_size14, _normalWeight, kMyLightGrey);

  static TextStyle darkGreySize16 = _base(
    _size16,
    _normalWeight,
    kMyLightGrey,
  );

  //Light Grey
  static TextStyle lightGreySize12 =
      _base(_size12, _normalWeight, kMyMediumGrey);

  static TextStyle lightGreySize14 =
      _base(_size14, _normalWeight, kMyMediumGrey);

  static TextStyle lightGreySize16 =
      _base(_size16, _normalWeight, kMyMediumGrey);

  static TextStyle lightGreySize18 =
      _base(_size18, _normalWeight, kMyMediumGrey);

  //very dark text
  static TextStyle darkGreySize14Bold =
      _base(_size14, _boldWeight, kMyMediumGrey);

  static TextStyle darkGreySize16Bold =
      _base(_size16, _boldWeight, kMyMediumGrey);

  static TextStyle darkGreySize18Bold =
      _base(_size18, _boldWeight, kMyMediumGrey);

  static TextStyle blackSize18Bold =
      _base(_size18, _boldWeight, kMyMediumGrey);

  static TextStyle darkGreySize20Bold =
      _base(_size20, _boldWeight, kMyMediumGrey);

  static TextStyle errorSize14 =
      _base(_size14, _normalWeight, kMyMediumGrey);

  static TextStyle whiteSize14Bold =
      _base(_size14, _boldWeight, kMyMediumGrey);

  static TextStyle whiteSize18Bold =
      _base(_size18, _boldWeight, kMyMediumGrey);

  static TextStyle whiteSize20Bold =
      _base(_size20, _boldWeight, kMyMediumGrey);

  //!End

  //
  //#base style
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
    return GoogleFonts.lato(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? Colors.grey[600],
    );
  }
}
