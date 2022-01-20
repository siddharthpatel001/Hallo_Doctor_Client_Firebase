import 'package:get/get.dart';

import '../controllers/doctor_category_controller.dart';

class DoctorCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorCategoryController>(
      () => DoctorCategoryController(),
    );
  }
}
