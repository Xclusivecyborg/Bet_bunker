import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatscreen/chat_screen_viewmodel.dart';
import 'package:spinchat/widgets/chat_textfield.dart';
import 'package:spinchat/widgets/message_widget.dart';
import 'package:spinchat/widgets/profile/users_circle_avatar.dart';
import 'package:spinchat/widgets/status_dot.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {Key? key,
      @required this.usernameChattingWith,
      @required this.networkUrl,
      @required this.isOnline})
      : super(key: key);
  final String? usernameChattingWith;
  final String? networkUrl;
  final bool? isOnline;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewmodel>.reactive(
        onModelReady: (model) => model.initialize(user2: usernameChattingWith!),
        viewModelBuilder: () => ChatScreenViewmodel(),
        builder: (context, model, child) {
         
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 2,
              backgroundColor: AppColors.white,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    child: LeadingAvatar(
                        photo: networkUrl!,
                      ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$usernameChattingWith',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                          fontSize: 17,
                        ),
                      ),
                      Row(
                        children: [
                          onlineStatusDot(isOnline: isOnline!),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            isOnline! ? "Online" : 'Offline',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: AppColors.myDarkGrey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                    stream: model.messageSnapshot,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<MessageTextWidget> messageList = [];
                      for (var message in snapshot.data!.docs.reversed) {
                        final messageBody = message['text'];
                        final String? messageSender = message['sender'];
                        final time = message['createdAt'];
                        final currentUser = model.loggedInUSer!.email;
                        final messageWidget = MessageTextWidget(
                          
                          timeCreated: time,
                          messageBody: messageBody,
                          messageSender: messageSender,
                          isMe: currentUser == messageSender,
                        );
                        messageList.add(messageWidget);
                      }
                      return Expanded(
                        child: ListView(
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          controller: model.scrollController,
                          padding: const EdgeInsets.all(10),
                          children: messageList,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ChatTextfield(
                    hint: 'Type your message',
                    controller: model.messageController,
                    onPressed: () {
                      model.sendMessage(friendUsername: usernameChattingWith);
                      model.messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
