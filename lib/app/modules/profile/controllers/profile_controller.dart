import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/chat/views/list_users_view.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/pages/change_password.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/pages/edit_image_page.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/pages/update_email_page.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  AuthService authService = Get.find();
  UserService userService = Get.find();
  var username = ''.obs;
  var profilePic = ''.obs;
  var appVersion = ''.obs;
  var email = ''.obs;
  var newPassword = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }

  @override
  void onReady() {
    super.onReady();
    var user = userService.currentUser;
    print('user : ' + user.toString());
    profilePic.value = userService.getProfilePicture()!;
    username.value = user!.displayName!;
    email.value = user.email!;
  }

  @override
  void onClose() {}

  void logout() async {
    Get.defaultDialog(
      title: 'Logout'.tr,
      middleText: 'Are you sure you want to Logout'.tr,
      radius: 15,
      textCancel: 'Cancel'.tr,
      textConfirm: 'Logout'.tr,
      onConfirm: () {
        authService.logout().then(
              (value) => Get.offAllNamed('/login'),
            );
      },
    );
  }

  toEditImage() {
    Get.to(() => EditImagePage());
  }

  toUpdateEmail() {
    Get.to(() => UpdateEmailPage());
  }

  toChangePassword() {
    Get.to(() => ChangePasswordPage());
  }

  void updateProfilePic(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    userService.updateProfilePic(filePath).then((updatedUrl) {
      profilePic.value = updatedUrl;
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void updateEmail(String email) async {
    // if (!(await checkGoogleLogin())) return;
    try {
      EasyLoading.show();
      UserService().updateEmail(email).then((value) {
        Get.back();
        this.email.value = email;
        update();
      }).catchError((err) {
        Fluttertoast.showToast(msg: err.toString());
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void changePassword(String currentPassword, String newPassword) async {
    // if (!(await checkGoogleLogin())) return;

    try {
      await UserService().changePassword(currentPassword, newPassword);
      currentPassword = '';
      newPassword = '';
      Get.back();
      Fluttertoast.showToast(msg: 'Successfully change password'.tr);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    EasyLoading.dismiss();
  }

//user for testing something
  Future testButton() async {
    try {
      print('my uid : ' + UserService().currentUser!.uid);
      Get.to(() => ListUser());
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Future<bool> checkGoogleLogin() async {
  //   bool loginGoogle = await AuthService().checkIfGoogleLogin();
  //   print('is login google : ' + loginGoogle.toString());
  //   if (loginGoogle) {
  //     Fluttertoast.showToast(
  //         msg: 'your login method, it is not possible to change this data');
  //     return false;
  //   }
  //   return loginGoogle;
  // }
}
