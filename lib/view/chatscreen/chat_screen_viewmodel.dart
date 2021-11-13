import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/app/app.logger.dart';
import 'package:stacked/stacked.dart';

class ChatScreenViewmodel extends BaseViewModel {
  final log = getLogger('ChatScreenViewmodel');
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  User? get loggedInUSer => getCurrentUSer();

  User? getCurrentUSer() {
    try {
      final user = auth.currentUser;
      return user;
    } catch (e) {
      log.e(e);
    }
  }

  Timestamp timeStamp = Timestamp.fromMicrosecondsSinceEpoch(
      Timestamp.now().microsecondsSinceEpoch);

  void sendMessage({@required String? messageText}) {
    try {
      fireStore.collection('messages').doc().set(
        {
          'text': messageText,
          'sender': loggedInUSer!.email,
          'createdAt': timeStamp
        },
      );
    } catch (e) {
      log.e(e);
    }
  }

  void logOut() {
    auth.signOut();
  }
}
