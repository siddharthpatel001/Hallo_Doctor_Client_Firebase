import 'package:get/get.dart';

import '../controllers/search_doctor_controller.dart';

class SearchDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchDoctorController>(
      () => SearchDoctorController(),
    );
  }
}
