import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';

class TopRatedDoctorController extends GetxController
    with StateMixin<List<Doctor>> {
  //TODO: Implement TopRatedDoctorController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    DoctorService().getTopRatedDoctor().then((value) {
      change(value, status: RxStatus.success());
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
