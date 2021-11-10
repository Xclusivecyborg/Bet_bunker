import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:spinchat/app/services/firebase_storage.dart';
import 'package:spinchat/app/services/firebse_auth_service.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/app/services/storage_keys.dart';
import 'package:spinchat/widgets/custom_snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatViewModel extends BaseViewModel {
  //Services
  final _fireStore = locator<FirestoreService>();
  final _snackbar = locator<SnackbarService>();
  final _storage = locator<SharedPreferenceLocalStorage>();
  final _navigation = locator<NavigationService>();
  final _firebaseStorage = locator<FirebaseDataStorage>();
  final _authservice = locator<FirebaseAuthService>();

  //EditingContollers for the settings page
  TextEditingController searchResults = new TextEditingController();
  TextEditingController aboutMe = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController username = new TextEditingController();

//Required Parameters
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? snapshot;
  bool isWhite = false;
  bool? get userStatus => _storage.getBool(StorageKeys.isLoggedIn);
  String? get userId => _storage.getString(StorageKeys.currentUserId);
  String? get currentUsername => _storage.getString(StorageKeys.username);
  File? imagePicked;

  String dialCodeDigits = '+00';
  String? get photosUrl => _storage.getString(StorageKeys.photoUrl);

  void onchanged(val) {
    notifyListeners();
  }

  void toggleTheme(val) {
    isWhite = val;
    notifyListeners();
  }

  void initialise() {
    getUSersByUsername();
  }

// Pick Image with Image picker on device
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final pickedImage = File(image.path);
        this.imagePicked = pickedImage;
        uploadFile();
      }
    } on PlatformException catch (e) {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.Failure,
          duration: const Duration(seconds: 2),
          message: '${e.message}');
      print('Unable to pick Image: $e');
    }
    notifyListeners();
  }

//Upload things to firestore
  Future uploadFile() async {
    try {
      final tasksnapshot = await _firebaseStorage.uploadTask(
        image: imagePicked,
        fileName: userId,
      );
      final photoUrl = await tasksnapshot.ref.getDownloadURL();
      await _storage.setString(StorageKeys.photoUrl, photoUrl);

      await updateDetails(photoUrlString: photoUrl);
    } on FirebaseException catch (e) {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.Failure,
          duration: const Duration(seconds: 3),
          message: '${e.message}');
    } on SocketException {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.Failure,
          message: 'Please check your internet connection');
    } catch (e) {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.Failure, message: e.toString());
    }
    notifyListeners();
  }

//Update user details on firestore
  Future? updateDetails({String? photoUrlString}) {
    Map<String, dynamic> dataUsername = {
      'userName': username.text,
    };
    Map<String, dynamic> dataAboutMe = {
      'aboutMe': aboutMe.text,
    };
    Map<String, dynamic> photoUrl = {
      'photoUrl': photoUrlString,
    };
    Map<String, dynamic> generalUpdate = {
      'photoUrl': photoUrl,
      'aboutMe': aboutMe.text,
      'userName': username.text,
    };

    if (aboutMe.text.isNotEmpty &&
        username.text.isNotEmpty &&
        photoUrlString != null) {
      return _fireStore.updateDocument(
          collPath: 'users', docPath: userId!, data: generalUpdate);
    } else if (aboutMe.text.isNotEmpty) {
      return _fireStore.updateDocument(
          collPath: 'users', docPath: userId!, data: dataAboutMe);
    } else if (username.text.isNotEmpty) {
      return _fireStore.updateDocument(
          collPath: 'users', docPath: userId!, data: dataUsername);
    } else if (photoUrlString != null) {
      return _fireStore.updateDocument(
          collPath: 'users', docPath: userId!, data: photoUrl);
    } else {
      return null;
    }
  }

//Get Users Call
//Gets users based on the username provided
  void getUSersByUsername() async {
    await _fireStore.getUSers()!.then((value) {
      snapshot = value.docs;
    });
    notifyListeners();
  }

//This gets users via the onchanged function of the textfield
  void uSersByUsername() async {
    await _fireStore
        .getUSersByUsername(username: searchResults.text)!
        .then((value) {
      snapshot = value.docs;
    });
    notifyListeners();
  }

//THis gets the list of all users using the application
  void getUsers({String? val}) async {
    _fireStore.getUSersByUsername(username: val)!.then((value) {
      snapshot = value.docs;
    });
    notifyListeners();
  }

  //Navigation nethods
  void navigateToSettings() {
    _navigation.navigateTo(Routes.settingsPage);
  }

//Pop navigation
  void popNavigation() {
    _navigation.back();
  }

  void logout() async {
    await _fireStore.updateDocument(
        collPath: 'users', docPath: userId!, data: {'loggedIn': false});
    _authservice.logout();
    _storage.clearStorage();
    _navigation.navigateTo(Routes.landingPage);
  }
}
