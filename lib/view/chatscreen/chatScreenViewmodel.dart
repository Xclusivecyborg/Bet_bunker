import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChatScreenViewmodel extends BaseViewModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  User? get loggedInUSer => getCurrentUSer();

  User? getCurrentUSer() {
    try {
      final user = _auth.currentUser;
      return user;
    } catch (e) {
      print(e);
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
      print(e);
    }
  }

  void logOut() {
    _auth.signOut();
  }
}
