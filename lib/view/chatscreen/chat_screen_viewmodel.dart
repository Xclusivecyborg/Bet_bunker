import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.logger.dart';
import 'package:spinchat/app/services/firebse_auth_service.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/utils/storage_keys.dart';
import 'package:stacked/stacked.dart';

class ChatScreenViewmodel extends BaseViewModel {
  final log = getLogger('ChatScreenViewmodel');
  
  ///SERVICES
  final _fireStore = locator<FirestoreService>();
   final _auth = locator<FirebaseAuthService>();


///Required Parameters in the view
  ScrollController scrollController = ScrollController();
  User? get loggedInUSer => _auth.getCurrentUSer();
  final _storage = locator<SharedPreferenceLocalStorage>();
  String? get currentUsername => _storage.getString(StorageKeys.username);
  String? messageText;
  TextEditingController messageController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>>? messageSnapshot;


//This is the first method that is called when the UI is built
//This is called in the onModelReady function provided by stacked
//onModelReady is Similar to initState in a stateful widget 
  void initialize({required String user2}) {
    messages(friendUsername: user2);
  }


  User? getCurrentUSer() {
    try {
      final user = _auth.getCurrentUSer();
      return user;
    } catch (e) {
      log.e(e);
    }
  }

//Method to format the chatRoom Id such that if user a creates a chatroom Id, 
//User b also uses the same Id without having to create another 
  String chatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b _$a";
    } else {
      return "$a _$b";
    }
  }


///Method that fetches the stream of messages 
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> messages(
      {required String friendUsername}) async {
    String getdocPath = chatRoomId(currentUsername!, friendUsername);
    final textmessages = _fireStore.fetchMessages(docPath: getdocPath);
    messageSnapshot = textmessages;
    notifyListeners();
  }


//Method that handles sending messages to the database
  void sendMessage({@required String? friendUsername}) async {
    String getdocPath = chatRoomId(currentUsername!, friendUsername!);
    messageText = messageController.text;
    Map<String, dynamic> dataToSend = {
      'text': messageText,
      'sender': loggedInUSer!.email,
      'createdAt': DateTime.now(),
    };

    if (messageText!.isNotEmpty) {
      await _fireStore.sendMessages(
          collection2: 'usersMessages',
          collPath: 'messages',
          docPath: getdocPath,
          data: dataToSend);
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    } else {}

    notifyListeners();
  }

  
}
