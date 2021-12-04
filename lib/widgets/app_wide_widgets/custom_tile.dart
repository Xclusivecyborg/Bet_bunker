import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:spinchat/utils/constants/color_constants.dart';

class CustomTile extends StatelessWidget {
  final String? username;
  final Function()? ontap;
  final bool? chatPage;
  final bool? isUserLoggedIn;
  final bool isWhite;
  final Widget? leading;
  final Timestamp? timeCreated;
  const CustomTile({
    Key? key,
    this.username,
    this.ontap,
    @required this.chatPage,
    @required this.isUserLoggedIn,
    required this.isWhite,
    @required this.leading,
    this.timeCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        onTap: ontap,
        leading: leading ?? const CircleAvatar(),
        title: Text(
          username!,
          style: GoogleFonts.poppins(
            color: AppColors.naveyBlue,
            fontSize: 20.0,
          ),
        ),
        subtitle:
            chatPage! ? Text(isUserLoggedIn! ? 'online' : 'offline') : null,
        trailing: chatPage!
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: isUserLoggedIn!
                            ? AppColors.myGreen
                            : AppColors.myLightGrey),
                  ),
                  timeCreated != null
                      ? Text(
                          formatDateTime(timeCreated!),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        )
                      : const Text(''),
                ],
              )
            : TextButton(
                onPressed: () {},
                child: Text(
                  'Message',
                  style: GoogleFonts.poppins(
                      color: isWhite ? AppColors.myGreen : AppColors.naveyBlue),
                ),
              ),
      
      ),
    );
  }
}

String formatDateTime(Timestamp dateTime) {
  var time = DateFormat.jm().format(dateTime.toDate());
  return '$time ';
}
