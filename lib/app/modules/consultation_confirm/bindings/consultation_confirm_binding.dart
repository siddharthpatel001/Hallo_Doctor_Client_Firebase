import 'package:get/get.dart';

import '../controllers/consultation_confirm_controller.dart';

class ConsultationConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultationConfirmController>(
      () => ConsultationConfirmController(),
    );
  }
}
