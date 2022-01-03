import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.logger.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:spinchat/app/models.dart/posts_model.dart';
import 'package:spinchat/app/services/firebase_storage.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/utils/storage_keys.dart';
import 'package:spinchat/widgets/package_widgets/custom_snackbar.dart';
import 'package:spinchat/widgets/package_widgets/custom_toast.dart';
import 'package:spinchat/widgets/package_widgets/setup_ui_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostsViewModel extends FormViewModel {
  final log = getLogger('Chat View Screen');
  //Services
  final _fireStore = locator<FirestoreService>();
  final _snackbar = locator<SnackbarService>();
  final _navigation = locator<NavigationService>();
  final _storage = locator<SharedPreferenceLocalStorage>();
  final _firebaseStorage = locator<FirebaseDataStorage>();
  final _dialogService = locator<DialogService>();

  String? get currentUserEmail => _storage.getString(StorageKeys.userEmail);
  String? get userId => _storage.getString(StorageKeys.currentUserId);
  String? get currentUsername => _storage.getString(StorageKeys.username);

  bool mediaAdded = false;
  String textBody = 'away';
  String? downloadUrl;
  File? photoFile;

  void unPickImage() {
    photoFile = null;
    mediaAdded = false;
    notifyListeners();
  }

  void onChange(String value) {
    textBody = value;
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
      );

      if (image != null) {
        mediaAdded = true;
        photoFile = File(image.path);
        notifyListeners();
      }
    } on PlatformException catch (e) {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.failure,
          duration: const Duration(seconds: 2),
          message: '${e.message}');
      log.e('Unable to pick Image: $e');
    }
  }

  Future uploadFile() async {
    try {
      final tasksnapshot = await _firebaseStorage.uploadPostImage(
          image: photoFile, path: 'Posts/${photoFile!}/');
      final photoUrl = await tasksnapshot.ref.getDownloadURL();
      downloadUrl = photoUrl;
    } on FirebaseException catch (e) {
      _snackbar.showCustomSnackBar(
          variant: SnackBarType.failure,
          duration: const Duration(seconds: 3),
          message: '${e.message}');
    } catch (e) {
      log.e(e.toString());
    }
    notifyListeners();
  }

  Future createPost() async {
    try {
      customtoast(toastmessage: 'Creating...');
      if (mediaAdded && photoFile != null) {
        await uploadFile();
        await _fireStore.post(
            data: BetPosts.toFireStore(
          body: textBody,
          sentBy: currentUsername,
          createdAt: DateTime.now(),
          createdBy: userId,
          photoUrl: downloadUrl,
        ));
        pop();
        customtoast(toastmessage: 'Post created successfully');
      }
      if (!mediaAdded && photoFile == null) {
        await _fireStore.post(
            data: BetPosts.toFireStore(
          body: textBody,
          sentBy: currentUsername,
          createdAt: DateTime.now(),
          createdBy: userId,
          photoUrl: '',
        ));

        pop();
        customtoast(toastmessage: 'Post created successfully');
      }
    } on SocketException {
      pop();
      customtoast(toastmessage: 'Please check your internet connection');
    } catch (e) {
      log.e(e.toString());
    }
    notifyListeners();
  }

  void pop() {
    _navigation.back();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.schedulePost,
    );
  }

  Future<void> scheduleMessage(double delay, String message) async {
    delay = delay * 60; //Converting from hour to minutes
    int value = delay.toInt();

    if (textBody.trim().isNotEmpty) {
      customtoast(toastmessage: 'Creating in $value minutes');
      _navigation.clearStackAndShow(Routes.homeScreen);
      Future.delayed(Duration(minutes: value), () async {
        await createPost();
      });
    } else {
      customtoast(toastmessage: 'Message body is empty');
    }
  }

  @override
  void setFormStatus() {}
}
