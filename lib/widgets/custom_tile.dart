

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:spinchat/widgets/roundedButton.dart';

class CustomTile extends StatelessWidget {
  final String? username;
  final Function()? ontap;
  CustomTile({
    Key? key,
    this.username,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(5),
      child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/rectangle.png'),
          ),
          title: Text(
            username!,
            style: GoogleFonts.spinnaker(
              color: kMynaveyBlue,
              fontSize: 20.0,
            ),
          ),
          trailing: CustomButton(
            width: MediaQuery.of(context).size.width / 5,
            label: 'Message',
            onTap: ontap,
            color: kMynaveyBlue,
          )),
    );
  }
}