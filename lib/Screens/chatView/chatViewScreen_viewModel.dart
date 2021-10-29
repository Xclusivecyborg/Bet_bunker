import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? snapshot;
  final _fireStore = locator<FirestoreService>();

  void initialise() {
    getUSersByUsername();
  }

  void getUSersByUsername() async {
    await _fireStore.getUSers()!.then((value) {
      snapshot = value.docs;
    });
    notifyListeners();
  }
}
