import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.logger.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:spinchat/app/models.dart/chat_model.dart';
import 'package:spinchat/app/models.dart/user_model.dart';
import 'package:spinchat/app/services/firebase_storage.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/utils/storage_keys.dart';
import 'package:spinchat/widgets/package_widgets/custom_snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatViewModel extends BaseViewModel {
  final log = getLogger('Chat View Screen');
  //Services
  final _fireStore = locator<FirestoreService>();
  final _snackbar = locator<SnackbarService>();
  final _storage = locator<SharedPreferenceLocalStorage>();
  final _navigation = locator<NavigationService>();
  final _firebaseStorage = locator<FirebaseDataStorage>();

  //EditingContollers for the settings page
  TextEditingController searchResults = TextEditingController();
  TextEditingController aboutMe = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  ///Required Parameters
  List<dynamic> usersFollowing = [];
  List<Users> usersnapshot = [];
  late List<Users> matchingUsers = [];

  //This is for usernames
  late List<Users> matchingUsernames = [];
  bool isWhite = false;
  File? imagePicked;
  bool? get userStatus => _storage.getBool(StorageKeys.isLoggedIn);
  String? get userId => _storage.getString(StorageKeys.currentUserId);
  String? get currentUsername => _storage.getString(StorageKeys.username);
  String? get myphotoUrl => _storage.getString(StorageKeys.photoUrl);
  String? get currentUserEmail => _storage.getString(StorageKeys.userEmail);

//This is the first method that is called when the UI is built
//This is called in the onModelReady function provided by stacked
//onModelReady is Similar to initState in a stateful widget
  void initialise() {
    getUsers();
  }

  void onSearchUsername(String input) {
    matchingUsernames = [
      ...usersnapshot.where(
          (user) => user.userName!.toLowerCase().contains(input.toLowerCase()))
    ];
    log.i(matchingUsers);
    notifyListeners();
  }

  void getUsersByUsername() {
    matchingUsernames = [
      ...usersnapshot.where((user) => user.userName!
          .toLowerCase()
          .contains(searchResults.text.toLowerCase()))
    ];
    log.i(matchingUsers);
    notifyListeners();
  }

  void onSearchUser(String input) {
    matchingUsers = [
      ...usersnapshot.where(
          (user) => user.userName!.toLowerCase().contains(input.toLowerCase()))
    ];
    log.i(matchingUsers);
    notifyListeners();
  }

// Pick Image with Image picker on device
  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (image != null) {
        final pickedImage = File(image.path);
        imagePicked = pickedImage;
        uploadFile();
      }
    } on PlatformException catch (e) {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.failure,
          duration: const Duration(seconds: 2),
          message: '${e.message}');
      log.e('Unable to pick Image: $e');
    }
    notifyListeners();
  }

//Upload things to firebase storage
  Future uploadFile() async {
    try {
      final tasksnapshot = await _firebaseStorage.uploadTask(
        image: imagePicked,
        fileName: userId,
      );
      final photoUrl = await tasksnapshot.ref.getDownloadURL();
      await _fireStore
          .updateDocument(collPath: 'users', docPath: userId!, data: {
        'photoUrl': photoUrl,
      });
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.success, message: 'Photo updated successfully');
    } on FirebaseException catch (e) {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.failure,
          duration: const Duration(seconds: 3),
          message: '${e.message}');
    } on SocketException {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.failure,
          message: 'Please check your internet connection');
    } catch (e) {
      log.e(e.toString());
    }
    notifyListeners();
  }

//Update user details on firestore
  Future? updateDetails({String? photoUrlString}) async {
    if (aboutMe.text.isNotEmpty && username.text.isNotEmpty) {
      await _fireStore
          .updateDocument(collPath: 'users', docPath: userId!, data: {
        'aboutMe': aboutMe.text,
        'userName': username.text,
      }).then((value) async {
        await _storage.setString(StorageKeys.username, username.text);
        _snackbar.showCustomSnackBar(
            variant: SnackBarType.success,
            duration: const Duration(seconds: 3),
            message: 'Details updated successfully');
      });
    } else if (username.text.isNotEmpty) {
      await _fireStore
          .updateDocument(collPath: 'users', docPath: userId!, data: {
        'userName': username.text,
      }).then((value) async {
        await _storage.setString(StorageKeys.username, username.text);
        _snackbar.showCustomSnackBar(
            variant: SnackBarType.success,
            duration: const Duration(seconds: 3),
            message: 'Username updated successfully');
      });
    } else if (aboutMe.text.isNotEmpty) {
      await _fireStore
          .updateDocument(collPath: 'users', docPath: userId!, data: {
        'aboutMe': aboutMe.text,
      }).then((value) {
        _snackbar.showCustomSnackBar(
            variant: SnackBarType.success,
            duration: const Duration(seconds: 3),
            message: 'Bio updated successfully');
      });
    } else {
      return null;
    }
  }

  ///ALL METHODS TO GET USERS
//Gets all users method
  Future<List<Users>> getUsers() async {
    var usersList = await _fireStore.getUSers();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> userData =
        usersList!.docs;
    List<Users> newSnapshot = userData.map((e) => Users.fromMap(e)).toList();
    log.i(newSnapshot);
    List<Users> currentUsers = [];
    for (var element in newSnapshot) {
      if (element.userId!.contains(userId!)) {
        currentUsers.add(element);
      }
    }
    //This removes the current user from the list of users being returned
    ///So the currentuser doesn't attempt to send message to himself
    newSnapshot.removeWhere((element) => currentUsers.contains(element));
    usersnapshot = newSnapshot;
    notifyListeners();
    return newSnapshot;
  }

  /////Method to create a chatroom for 2 users each
  void createChatRoom({@required String? friendUsername}) {
    String getdocPath = chatRoomId(currentUsername!, friendUsername!);
    try {
      _fireStore.createChatRoom(
          collPath: 'messages',
          docPath: getdocPath,
          data: Chat.toFireStore(
            chatRoomId: getdocPath,
            createdAt: DateTime.now(),
            sender: currentUserEmail,
            users: [currentUsername!, friendUsername],
          ));
    } catch (e) {
      log.e(e);
    }
  }

  /// NAVIGATION METHODS

//Method to format the chatRoom Id such that if user a creates a chatroom Id,
//User b also uses the same Id without having to create another
  String chatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b _$a";
    } else {
      return "$a _$b";
    }
  }

//Navigate to the chat screen
  void naviagteToChatScreen(
      {required String user,
      required String uid,
      required String networkLink,
      required bool isUserOnline,
      required String about}) {
    _navigation.navigateTo(Routes.chatScreen,
        arguments: ChatScreenArguments(
          uid: uid,
          aboutMe: about,
          usernameChattingWith: user,
          networkUrl: networkLink,
          isOnline: isUserOnline,
        ));
    createChatRoom(
      friendUsername: user,
    );
  }

//Pop navigation
  void popNavigation() {
    _navigation.back();
  }
}
