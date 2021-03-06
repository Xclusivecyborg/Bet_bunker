import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:spinchat/view/chatscreen/chat_screen_viewmodel.dart';
import 'package:spinchat/widgets/app_wide_widgets/alert_dialog.dart';
import 'package:spinchat/widgets/app_wide_widgets/dialog_actions.dart';
import 'package:spinchat/widgets/chat/chat_textfield.dart';
import 'package:spinchat/widgets/chat/message_widget.dart';
import 'package:spinchat/widgets/profile/users_circle_avatar.dart';
import 'package:spinchat/widgets/app_wide_widgets/status_dot.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {Key? key,
      this.usernameChattingWith,
      this.networkUrl,
      this.isOnline,
      this.aboutMe,
      required this.uid})
      : super(key: key);
  final String? usernameChattingWith;
  final String? networkUrl;
  final bool? isOnline;
  final String? aboutMe;
  final String uid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _light = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<ChatScreenViewmodel>.reactive(
        onModelReady: (model) => model.initialize(user2: usernameChattingWith!),
        viewModelBuilder: () => ChatScreenViewmodel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              elevation: 2,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () => model.pop(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: _light ? AppColors.naveyBlue : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      model.navigateToProfile(
                        uid: uid,
                        about: aboutMe!,
                        networkLink: networkUrl!,
                        user: usernameChattingWith!,
                      );
                    },
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
                            fontSize: 17,
                            color: _light ? AppColors.naveyBlue : null),
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
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
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
                    onLongPress: () {
                      return showDialog(
                        context: context,
                        builder: (context) => ScheduleDialog(
                          title: 'Schedule Message',
                          action: getMesageSchedule(
                              context: context,
                              model: model,
                              friend: usernameChattingWith!),
                        ),
                      );
                    },
                    onChanged: model.onChange,
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
