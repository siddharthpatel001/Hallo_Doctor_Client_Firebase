import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  AuthService authService = Get.find();
  var loginFormKey = GlobalKey<FormState>();
  final count = 0.obs;
  var username = '';
  var password = '';
  bool passwordVisible = false;
  @override
  void onInit() {
    super.onInit();
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  void passwordIconVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  void loginGoogle() {
    authService.loginGoogle().then((value) => Get.offAllNamed('/dashboard'));
  }

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();

      EasyLoading.show();

      authService.login(username, password).then((value) {
        Get.offAllNamed('/dashboard');
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    }
  }
}
