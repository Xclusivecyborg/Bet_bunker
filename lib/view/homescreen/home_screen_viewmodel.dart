import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.logger.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:spinchat/app/models.dart/posts_model.dart';
import 'package:spinchat/app/services/firebse_auth_service.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/utils/storage_keys.dart';
import 'package:spinchat/widgets/package_widgets/custom_snackbar.dart';
import 'package:spinchat/widgets/package_widgets/custom_toast.dart';
import 'package:spinchat/widgets/package_widgets/setup_ui_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeScreenViewModel extends BaseViewModel {
  final log = getLogger('Home Screen');
  //Services
  final fireStore = locator<FirestoreService>();
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
  bool? get themePref => _storage.getBool(StorageKeys.themePref);
  List<BetPosts> posts = [];
  bool isbusy = false;
  bool isLiked = false;
  initialize() {
    getUserDetails();
    fetchPosts();
  }

  void toggleLike() {
    isLiked = !isLiked;
    notifyListeners();
  }

  void toggleTheme(val) {
    _storage.setBool(StorageKeys.themePref, val);
    log.e(val);
    notifyListeners();
  }

  Future<void> like(bool liked, BetPosts post) async {
    await fireStore.likePost(isLiked: liked, uid: userId, post: post);
  }

  void getUserDetails() async {
    await fireStore.getMyDetails(userId)!.then((value) {
      String userUsername = value['userName']!;
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

  ///Fetch Posts from firestore

  Future fetchPosts() async {
    isbusy = true;
    try {
      final newPosts = await fireStore.getPosts();
      List<BetPosts> post =
          newPosts!.docs.map((e) => BetPosts.fromMap(e)).toList();
      posts = post;
      isbusy = false;
    } on FirebaseException catch (e) {
      isbusy = false;
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.failure,
          duration: const Duration(seconds: 2),
          message: '${e.message}');
    } on SocketException {
      isbusy = false;
      customtoast(toastmessage: 'Please check your internet and try again');
    } catch (e) {
      log.e(e.toString());
    }

    notifyListeners();
  }

  /// Navigate to Settings Screen
  void navigateToSettings() {
    _navigation.navigateTo(Routes.settingsPage);
  }

  void navigateToPost() {
    _navigation.navigateTo(Routes.posts);
  }

  void navigateToProfile(
      {required String id,
      required String bio,
      required String photo,
      required String username}) {
    _navigation.navigateTo(Routes.profile,
        arguments: ProfileArguments(
          uid: id,
          aboutMe: bio,
          networkUrl: photo,
          username: username,
        ));
  }

  ///Logout functionality
  void logout() async {
    _dialog.showCustomDialog(
      variant: DialogType.signOut,
    );
    await fireStore.updateDocument(
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
