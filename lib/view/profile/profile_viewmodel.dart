import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.logger.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/utils/storage_keys.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final log = getLogger('Profile Viewmodel');
  final _storage = locator<SharedPreferenceLocalStorage>();
  final _fireStore = locator<FirestoreService>();
  String? get userId => _storage.getString(StorageKeys.currentUserId);
  bool? isFollow;

//=====> This is the method to follow a user<=====
  void follow(usersId, uid) {
    _fireStore.followUSer(usersId, uid);
  }

//=====> This is the method to unfollow a user<=====
  void unfollow(usersId, uid) {
    _fireStore.unfollowUSer(usersId, uid);
  }

//=====> This method checks to see if a user is being followed already or not<=====
  void isFollowing(uid, uid2) {
    final follows = _fireStore.isFollowing(uid, uid2);
    follows!.forEach((element) {
      isFollow = element;
      log.e(isFollow);
      notifyListeners();
    });
  }
}
