import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spinchat/app/services/firebse_auth_service.dart';

import '../app.logger.dart';

class FirestoreService {
    final log = getLogger('FireStore service');
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
          .where('userName', isLessThanOrEqualTo: username)
          .get();
      return snapshots;
    } catch (e) {
      log.e(Failure(message: e.toString()));
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>>? getUSers() {
    try {
      final snapshots = _fireStore!.collection('users').get();
      return snapshots;
    } catch (e) {
     log.e(Failure(message: e.toString()));
    }
  }

  Future<void> updateDocument(
      {required String collPath,
      required String docPath,
      required Map<String, dynamic> data}) {
    return _fireStore!.collection(collPath).doc(docPath).update(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUSerDetails(
      String? uid) async {
    try {
      final snapshots = _fireStore!.collection('users').doc(uid).get();
      return snapshots;
    } catch (e) {
      log.e(Failure(message: e.toString()));
    }
  }
}
