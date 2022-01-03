import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/view/chatscreen/chat_screen_viewmodel.dart';
import 'package:spinchat/view/posts/posts_viewmodel.dart';

List<Widget> getPostSchedule(
    {required BuildContext context, required PostsViewModel model}) {
  return [
    Center(
      child: Column(children: [
        TextButton(
          onPressed: () async {
            await model.scheduleMessage(0.168, model.textBody);
            model.pop();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '10 minutes from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            await model.scheduleMessage(0.5, model.textBody);
            model.pop();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '30 minutes from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            model.pop();
            model.scheduleMessage(1, model.textBody);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '1 hour from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            model.pop();
            model.scheduleMessage(2, model.textBody);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '2 hours from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            model.pop();
            model.scheduleMessage(5, model.textBody);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '5 hours from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ]),
    )
  ];
}

List<Widget> getMesageSchedule(
    {required BuildContext context,
    required ChatScreenViewmodel model,
    required String friend}) {
  return [
    Center(
      child: Column(children: [
        TextButton(
          onPressed: () async {
            await model.scheduleMessage(0.168, model.messageText,
                friend: friend);
            model.pop();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '10 minutes from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            await model.scheduleMessage(0.5, model.messageText, friend: friend);
            model.pop();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '30 minutes from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            model.pop();
            model.scheduleMessage(1, model.messageText, friend: friend);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '1 hour from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            model.pop();
            model.scheduleMessage(2, model.messageText, friend: friend);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '2 hours from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            model.pop();
            model.scheduleMessage(5, model.messageText, friend: friend);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            '5 hours from now',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ]),
    )
  ];
}
