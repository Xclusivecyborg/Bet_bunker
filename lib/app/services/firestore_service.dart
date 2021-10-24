import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spinchat/app/services/authService.dart';

class FirestoreService {
  static FirestoreService? _instance;
  static FirebaseFirestore? _fireStore;

  static Future<FirestoreService> getInstance() async {
    _instance ??= FirestoreService();
    _fireStore ??= FirebaseFirestore.instance;
    return _instance!;
  }

  getUSersByUsername({required String? username, required snapshot}) async {
    try {
      await _fireStore!
          .collection('users')
          .where('name', isLessThanOrEqualTo: username)
          .get()
          .then((value) {
        snapshot = value.docs;
      });

      print(snapshot!.first.id);
    } catch (e) {
      print(Failure(message: e.toString()));
    }
  }
}
