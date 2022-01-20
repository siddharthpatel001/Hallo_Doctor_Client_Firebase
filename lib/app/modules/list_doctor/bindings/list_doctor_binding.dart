import 'package:get/get.dart';

import '../controllers/list_doctor_controller.dart';

class ListDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListDoctorController>(
      () => ListDoctorController(),
    );
  }
}
