import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'auth_service.dart';

class UserService {
  static User? user;
  set currentUser(User? user) => UserService.user = user;
  User? get currentUser {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return auth.currentUser;
    } else {
      print('User Null');
      return null;
    }
  }

  Future<String> getUsername() async {
    return currentUser!.displayName!;
  }

  String? getProfilePicture() {
    String? profilePic;
    try {
      profilePic = currentUser?.photoURL ?? "";
    } catch (e) {
      profilePic = '';
    }
    return profilePic;
  }

  //Upload image file to firebase storage & update current user profile pic
  Future<String> updateProfilePic(File filePath) async {
    try {
      String fileName = basename(filePath.path);
      var ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
      final result = await ref.putFile(File(filePath.path));
      final fileUrl = await result.ref.getDownloadURL();
      await updateProfileUrl(fileUrl);
      return fileUrl;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //Update current user profile url
  Future updateProfileUrl(String url) async {
    try {
      currentUser!.updatePhotoURL(url);
    } catch (err) {
      Future.error(err.toString());
    }
  }

  Future updateEmail(String email) async {
    try {
      currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (err) {
      return Future.error(err.message!);
    }
  }

  Future changePassword(String currentPassword, String newPassword) async {
    try {
      bool validatePassword =
          await AuthService().verifyPassword(currentPassword);
      if (validatePassword) {
        currentUser!.updatePassword(newPassword);
      }
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  String getUserId() {
    return currentUser!.uid;
  }
}
