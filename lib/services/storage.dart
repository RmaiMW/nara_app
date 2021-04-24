import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepo {
  FirebaseStorage _storage =
  FirebaseStorage(storageBucket: "gs://nara-news-2d068.appspot.com");
  //AuthService _authRepo = AuthService();

  Future<String> uploadFile(File file) async {
    FirebaseUser user =await FirebaseAuth.instance.currentUser();
    var userId = user.uid;

    var storageRef = _storage.ref().child("user/profile/$userId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/profile/$uid").getDownloadURL();
  }
}