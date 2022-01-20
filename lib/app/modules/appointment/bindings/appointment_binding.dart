import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/timeslot_service.dart';

import '../controllers/appointment_controller.dart';

class AppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentController>(
      () => AppointmentController(),
    );
    Get.lazyPut<TimeSlotService>(
      () => TimeSlotService(),
    );
  }
}
