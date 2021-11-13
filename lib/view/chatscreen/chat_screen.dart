import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/view/chatscreen/chat_screen_viewmodel.dart';
import 'package:spinchat/utils/constants.dart';
import 'package:spinchat/utils/constants/textstyle_constants.dart';
import 'package:spinchat/widgets/custom_listview_children.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? messageText;
  TextEditingController messageController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewmodel>.reactive(
      viewModelBuilder: () => ChatScreenViewmodel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  model.logOut();
                  Navigator.pop(context);
                  //Implement logout functionality
                }),
          ],
          title: const Text('⚡️Chat'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: model.fireStore
                    .collection('messages')
                    .orderBy('createdAt', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data!.docs;
                  List<MessageTextWidget> messageList = [];
                  for (var message in messages) {
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
                      padding: const EdgeInsets.all(10),
                      children: messageList,
                    ),
                  );
                },
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          //Do something with the user input.
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //Implement send functionality.
                        model.sendMessage(messageText: messageText);
                        messageController.clear();
                      },
                      child:const Text(
                        'Send',
                        style: AppTextStyles.kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
