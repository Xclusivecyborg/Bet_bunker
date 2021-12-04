import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/constants/color_constants.dart';

class CustomSearchField extends StatelessWidget {
  final IconData? preixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final Function(String) onChanged;
  final TextEditingController controller;
  const CustomSearchField({
    Key? key,
    @required this.hint,
    this.preixIcon,
    this.suffixIcon, required this.onChanged, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: TextFormField(
        onChanged: onChanged,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: Icon(preixIcon),
          hintText: hint!,
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: AppColors.lighterGrey,
            fontSize: 16,
          ),
          border: InputBorder.none,
        ),
      ),
      height: 43.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteGrey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
