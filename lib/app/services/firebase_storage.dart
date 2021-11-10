import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseDataStorage {
  static FirebaseDataStorage? _instance;
  static   FirebaseStorage? _storage; 

// Returns an instance of firebase_storage.
static Future<FirebaseDataStorage> getInstance() async {
    _instance ??= FirebaseDataStorage();
    _storage ??= FirebaseStorage.instance;
    return _instance!;
  }


//Upload a particular image to firebase storage
  UploadTask uploadTask({File? image, String? fileName}) {
    Reference reference = _storage!.ref().child(fileName!);
    UploadTask upload = reference.putFile(image!);
    return upload;
  }
}
