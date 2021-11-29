import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.logger.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:spinchat/app/services/firebse_auth_service.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/utils/storage_keys.dart';
import 'package:spinchat/widgets/custom_snackbar.dart';
import 'package:spinchat/widgets/setup_ui_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeScreenViewModel extends BaseViewModel {
  final log = getLogger('Home Screen');
  //Services
  final _fireStore = locator<FirestoreService>();
  final _snackbar = locator<SnackbarService>();
  final _storage = locator<SharedPreferenceLocalStorage>();
  final _navigation = locator<NavigationService>();
  final _authservice = locator<FirebaseAuthService>();
  final _dialog = locator<DialogService>();

  String? get userId => _storage.getString(StorageKeys.currentUserId);
  String? get myPhoto => _storage.getString(StorageKeys.photoUrl);
  String? get myBio => _storage.getString(StorageKeys.aboutMe);
  String? get myUsername => _storage.getString(StorageKeys.username);
  bool isWhite = false;

  void initialise() {
    getUserDetails();
  }

  void toggleTheme(val) {
    isWhite = val;
    notifyListeners();
  }

  void getUserDetails() async {
    await _fireStore.getUSerDetails(userId).then((value) {
      String userUsername = value!['userName'];
      String photoLink = value['photoUrl'];
      String about = value['aboutMe'];
      String uid = value['userId'];
      _storage.setString(StorageKeys.username, userUsername);
      _storage.setString(StorageKeys.photoUrl, photoLink);
      _storage.setString(StorageKeys.aboutMe, about);
      _storage.setString(StorageKeys.currentUserId, uid);
    });
    notifyListeners();
  }

  /// Navigate to Settings Screen
  void navigateToSettings() {
    _navigation.navigateTo(Routes.settingsPage);
  }

  void navigateToProfile() {
    _navigation.navigateTo(Routes.profile,
        arguments: ProfileArguments(
          uid: userId!,
          aboutMe: myBio!,
          networkUrl: myPhoto!,
          username: myUsername!,
        ));
  }

  ///Logout functionality
  void logout() async {
    _dialog.showCustomDialog(
      variant: DialogType.signOut,
    );
    await _fireStore.updateDocument(
        collPath: 'users', docPath: userId!, data: {'loggedIn': false});
    _authservice.logout();
    _storage.clearStorage();
    _navigation.clearStackAndShow(Routes.landingPage);
    _snackbar.showCustomSnackBar(
        variant: SnackBarType.success,
        duration: const Duration(seconds: 4),
        message: 'Logout Successful');
  }
}
