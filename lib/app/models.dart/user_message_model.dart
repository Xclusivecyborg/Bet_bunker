import 'package:cloud_firestore/cloud_firestore.dart';

class UserMessage {
  final String? messageBody;
  final String? messageSender;
  final Timestamp? time;

  UserMessage({this.messageBody, this.messageSender, this.time});
}
