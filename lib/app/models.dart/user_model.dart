import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? userName;
  final String? photoUrl;
  final String? userId;
  final String? email;
  final String? chattingWith;
  final String? createdAt;
  final String? aboutMe;
  final bool? loggedIn;

  Users(
      {this.userName,
      this.photoUrl,
      this.userId,
      this.email,
      this.chattingWith,
      this.createdAt,
      this.aboutMe,
      this.loggedIn});

  factory Users.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Users(
      userName: json['userName'],
      photoUrl: json['photoUrl'],
      userId: json['userId'],
      email: json['email'],
      chattingWith: json['chattingWith'],
      createdAt: json['createdAt'],
      aboutMe: json['aboutMe'],
      loggedIn: json['loggedIn'],
    );
  }

  @override
  String toString() {
    return 'userName: $userName, photoUrl: $photoUrl, userId: $userId, email: $email, chattingWith: $chattingWith, createdAt: $createdAt, aboutMe: $aboutMe, loggedIn: $loggedIn';
  }
}
