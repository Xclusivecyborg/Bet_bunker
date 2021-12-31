import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/constants/color_constants.dart';

class ChatTextfield extends StatelessWidget {
  final IconData? preixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final FocusNode? focusNode;
  final Function()? onPressed;
  final TextEditingController? controller;
  const ChatTextfield({
    Key? key,
    @required this.hint,
    this.preixIcon,
    this.suffixIcon,
    @required this.controller,
    this.onPressed,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _light = Theme.of(context).brightness == Brightness.light;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    suffixIcon: suffixIcon,
                    prefixIcon: Icon(preixIcon),
                    hintText: hint!,
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: AppColors.myDarkGrey,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          height: 50,
          width: MediaQuery.of(context).size.width / 1.3,
          decoration: BoxDecoration(
            color: _light ? AppColors.whiteGrey : null,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _light ? AppColors.white : Colors.transparent,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: onPressed,
          child: _light
              ? const Icon(
                  CupertinoIcons.paperplane_fill,
                  size: 30,
                )
              : const Icon(
                  CupertinoIcons.paperplane,
                  color: AppColors.myLightGrey,
                ),
        )
      ],
    );
  }
}