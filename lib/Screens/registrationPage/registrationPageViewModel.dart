import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/services/authService.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class RegistrationPageViewModel extends BaseViewModel {
// FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  updateUserinfo({@required userDetails}) {
    try {
      fireStore.collection('users').add(userDetails);
    } catch (e) {
      print(Failure(message: e.toString()));
    }
  }
}
