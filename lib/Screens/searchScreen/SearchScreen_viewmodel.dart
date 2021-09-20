import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spinchat/services/authService.dart';
import 'package:stacked/stacked.dart';

class SearchScreenViewmodel extends BaseViewModel {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  FirebaseFirestore get firestore => _fireStore;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? snapshot;

  getUSersByUsername(String? username) async {
    await firestore
        .collection('users')
        .where('name', isEqualTo: username)
        .get()
        .then((value) {
      snapshot = value.docs;
      notifyListeners();
    });
    print(snapshot!.first.id);
  }
}
