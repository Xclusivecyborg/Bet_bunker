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

  Future<QuerySnapshot<Map<String, dynamic>>>? getUSersByUsername(
      {required String? username}) {
    try {
      final snapshots = _fireStore!
          .collection('users')
          .where('name', isLessThanOrEqualTo: username)
          .get();
      return snapshots;
    } catch (e) {
      print(Failure(message: e.toString()));
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>>? getUSers() {
    try {
      final snapshots = _fireStore!.collection('users').get();
      return snapshots;
    } catch (e) {
      print(Failure(message: e.toString()));
    }
  }
}
