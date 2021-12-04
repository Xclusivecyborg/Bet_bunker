import 'package:firebase_auth/firebase_auth.dart';
import '../app.logger.dart';

class FirebaseAuthService {
  final log = getLogger('Firebase auth');
  static FirebaseAuthService? _instance;
  static FirebaseAuth? _auth;

  static Future<FirebaseAuthService> getInstance() async {
    _instance ??= FirebaseAuthService();
    _auth ??= FirebaseAuth.instance;
    return _instance!;
  }

  Future<UserCredential>? signUp(String? email, String? password) {
    try {
      final newUSer = _auth!
          .createUserWithEmailAndPassword(email: email!, password: password!);
      return newUSer;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<UserCredential>? login(String? email, String? password) {
    try {
      final newUSer =
          _auth!.signInWithEmailAndPassword(email: email!, password: password!);
      return newUSer;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future? resetPassword(String? email) {
    try {
      final passwordReset = _auth!.sendPasswordResetEmail(email: email!);
      return passwordReset;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  User? getCurrentUSer() {
    try {
      final user = _auth!.currentUser;
      return user;
    } catch (e) {
      log.e(e.toString());
    }
  }


  void logout() {
    _auth!.signOut();
  }
}

class Failure {
  final String? message;

  Failure({this.message});

  @override
  String toString() {
    return message!;
  }
}
