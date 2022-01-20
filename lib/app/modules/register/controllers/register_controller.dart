import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/login/controllers/login_controller.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  LoginController loginController = Get.find();
  AuthService authService = Get.find();
  final count = 0.obs;
  var formkey = GlobalKey<FormState>();
  var username = '';
  var email = '';
  var password = '';
  var passwordVisible = false;

  @override
  void onClose() {}

  void increment() => count.value++;

  void signUpUser() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      EasyLoading.show(
          status: 'loading...', maskType: EasyLoadingMaskType.black);
      authService.register(username, email, password).then((value) {
        Get.offAllNamed('/dashboard');
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    }
  }

  void passwordIconVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  void loginGoogle() {
    authService.loginGoogle().then((value) => Get.offAllNamed('/dashboard'));
  }
}
