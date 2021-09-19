import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class LoginScreenViewModel extends BaseViewModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? get loggedInUSer => getCurrentUSer();

  User? getCurrentUSer() {
    try {
      final user = _auth.currentUser;
      return user;
    } catch (e) {
      print(e);
    }
  }
}
