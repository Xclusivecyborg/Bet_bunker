import 'package:flutter/material.dart';
import 'package:spinchat/view/chatscreen/chatScreenViewmodel.dart';
import 'package:spinchat/utils/constants/color_constants.dart';
import 'package:stacked/stacked.dart';

class MessageTextWidget extends StatelessWidget {
  MessageTextWidget(
      {Key? key,
      @required this.messageBody,
      @required this.messageSender,
      this.isMe,
      this.timeCreated})
      : super(key: key);

  final messageBody;
  final String? messageSender;
  final bool? isMe;
  final timeCreated;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewmodel>.reactive(
      viewModelBuilder: () => ChatScreenViewmodel(),
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment:
              isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Material(
              color: isMe! ? AppColors.naveyBlue : AppColors.white,
              borderRadius: isMe!
                  ? BorderRadius.only(
                      topLeft: Radius.circular(
                        20,
                      ),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))
                  : BorderRadius.only(
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
                  style: TextStyle(
                    color: isMe! ? AppColors.white : AppColors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            messageSender != null ? Text('$messageSender') : Text(''),
          ],
        ),
      ),
    );
  }
}
