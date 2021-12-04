import 'package:cloud_firestore/cloud_firestore.dart';

class UserMessage {
  final String? text;
  final String? sender;
  final Timestamp? createdAt;

  UserMessage({
    this.text,
    this.sender,
    this.createdAt,
  });

  factory UserMessage.fromJson(Map<String, dynamic> json) {
    return UserMessage(
      createdAt: json["createdAt"] ?? '',
      sender: json["sender"] ?? '',
      text: json["text"] ?? '',
    );
  }

  static Map<String, dynamic> toFireStore({
    String? text,
    String? sender,
     DateTime? createdAt,
  }) {
    return {
      'createdAt': createdAt,
      'text': text,
      'sender': sender,
    };
  }
}
