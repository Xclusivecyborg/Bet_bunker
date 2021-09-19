import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants.dart';

// class RoundedButton extends StatefulWidget {
//   final String? title;
//   final Color? color;
//   final void Function()? onPressed;

//   RoundedButton({
//     Key? key,
//     @required this.title,
//     @required this.color,
//     @required this.onPressed,
//   }) : super(key: key);

//   @override
//   _RoundedButtonState createState() => _RoundedButtonState();
// }

// class _RoundedButtonState extends State<RoundedButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 16.0),
//       child: Material(
//         elevation: 5.0,
//         color: widget.color,
//         borderRadius: BorderRadius.circular(30.0),
//         child: MaterialButton(
//           onPressed: widget.onPressed,
//           minWidth: 200.0,
//           height: 42.0,
//           child: Text(
//             widget.title!,
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomButton extends StatelessWidget {
  final String? label;
  final Function()? onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    this.label = 'Label',
    this.onTap,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Center(
          child: Text(
            label!,
            style: TextStyle(color: KmyGreen),
          ),
        ),
      ),
    );
  }
}
