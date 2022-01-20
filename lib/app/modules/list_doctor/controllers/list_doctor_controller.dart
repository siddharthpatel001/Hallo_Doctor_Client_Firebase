import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_category_model.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';

class ListDoctorController extends GetxController
    with StateMixin<List<Doctor>> {
  DoctorCategory doctorCategory = Get.arguments;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('doctor category Name : ' + doctorCategory.categoryName!);
    DoctorService().getListDoctorByCategory(doctorCategory).then((value) {
      if (value.isEmpty) return change([], status: RxStatus.empty());
      print('doctor : ' + value.toString());
      change(value, status: RxStatus.success());
    }).catchError((err) {
      change([], status: RxStatus.error(err.toString()));
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
