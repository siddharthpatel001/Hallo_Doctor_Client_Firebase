import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';

class SearchDoctorController extends GetxController {
  //TODO: Implement SearchDoctorController
  // Map<String, dynamic> data = {'emtpy':'emtpy'};
  // Doctor doctor = Doctor.fromJson(data);
  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
}
