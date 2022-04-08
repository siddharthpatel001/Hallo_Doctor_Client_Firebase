import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';
import 'package:hallo_doctor_client/app/service/notification_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

class DashboardController extends GetxController {
  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(index) => _selectedIndex.value = index;
  final count = 0.obs;
  NotificationService notificationService = Get.find<NotificationService>();

  @override
  void onInit() async {
    super.onInit();
    EasyLoading.show();
    notificationService.listenNotification();
    await UserService()
        .updateUserToken(await notificationService.getNotificationToken());
    if (await UserService().checkIfUserExist() == false) {
      EasyLoading.dismiss();
      AuthService().logout();
      return Get.offAllNamed('/login');
    }
    EasyLoading.dismiss();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
