import 'package:get/get.dart';

import '../controllers/top_rated_doctor_controller.dart';

class TopRatedDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopRatedDoctorController>(
      () => TopRatedDoctorController(),
    );
  }
}
