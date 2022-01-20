import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';

import '../controllers/consultation_date_picker_controller.dart';

class ConsultationDatePickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultationDatePickerController>(
      () => ConsultationDatePickerController(),
    );
    Get.lazyPut<DoctorService>(() => DoctorService());
  }
}
