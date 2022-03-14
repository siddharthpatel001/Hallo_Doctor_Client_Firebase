import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hallo_doctor_client/app/modules/doctor_category/controllers/doctor_category_controller.dart';
import 'package:hallo_doctor_client/app/modules/home/controllers/home_controller.dart';
import 'package:hallo_doctor_client/app/modules/profile/controllers/profile_controller.dart';
import 'package:hallo_doctor_client/app/service/notification_service.dart';
import 'package:hallo_doctor_client/app/service/timeslot_service.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<NotificationService>(
      () => NotificationService(),
    );
    Get.lazyPut<UserService>(() => UserService());
    Get.put(HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<DoctorCategoryController>(() => DoctorCategoryController());
    Get.lazyPut<AppointmentController>(() => AppointmentController());
    Get.lazyPut<TimeSlotService>(() => TimeSlotService());
  }
}
