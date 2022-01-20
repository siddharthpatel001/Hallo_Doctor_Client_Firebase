import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/login/controllers/login_controller.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<LoginController>(() => LoginController());
    Get.put(AuthService());
  }
}
