import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:spinchat/view/chatscreen/chat_screen_viewmodel.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:stacked/stacked.dart';

class MessageTextWidget extends StatelessWidget {
  final String? messageBody;
  final String? messageSender;
  final bool? isMe;
  final Timestamp? timeCreated;

  const MessageTextWidget(
      {Key? key,
      @required this.messageBody,
      @required this.messageSender,
      this.isMe,
      this.timeCreated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewmodel>.reactive(
      viewModelBuilder: () => ChatScreenViewmodel(),
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment:
              isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Material(
              color: isMe! ? AppColors.orange : AppColors.myLightGrey,
              borderRadius: isMe!
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(
                        20,
                      ),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))
                  : const BorderRadius.only(
                      topRight: Radius.circular(
                        20,
                      ),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: Text(
                  '$messageBody',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isMe! ? AppColors.white : AppColors.black,
                  ),
                ),
              ),
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
        ),
      ),
    );
  }
}

String formatDateTime(Timestamp dateTime) {
  var time = DateFormat.jm().format(dateTime.toDate());
  return '$time ';
}
