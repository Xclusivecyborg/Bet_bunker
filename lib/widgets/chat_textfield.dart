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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
          width: 350,
          decoration: BoxDecoration(
            color: AppColors.whiteGrey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: onPressed,
          child: const Icon(
            CupertinoIcons.paperplane_fill,
            size: 30,
          ),
        )
      ],
    );
  }
}


// class ChatTextfield extends StatelessWidget {
//   final IconData? icon;
//   final String? hint;
//   final String? label;
//   final bool? obscure;
//   final TextEditingController? controller;
//   const ChatTextfield({
//     Key? key,
//     this.icon,
//     @required this.hint,
//     this.obscure = false,
//     @required this.label,
//     @required this.controller,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 16, top: 10),
//       child: Stack(
//         children: [
//           Text(
//             label!,
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.w500,
//               color: AppColors.lighterGrey,
//               fontSize: 11,
//             ),
//           ),
//           TextFormField(
//             key: const Key('My Textfield '),
//             controller: controller,
//             obscureText: obscure!,
//             decoration: InputDecoration(
//               suffixIcon: Icon(
//                 icon,
//                 size: 15,
//               ),
//               hintText: hint!,
//               hintStyle: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.black,
//                 fontSize: 16,
//               ),
//               border: InputBorder.none,
//             ),
//           ),
//         ],
//       ),
//       height: 60,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.whiteGrey,
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//   }
// }
