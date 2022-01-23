import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/review_model.dart';
import 'package:hallo_doctor_client/app/service/review_service.dart';

class DetailDoctorController extends GetxController with StateMixin<Doctor> {
  final count = 0.obs;
  Doctor selectedDoctor = Get.arguments;
  List<ReviewModel> listReview = [];
  @override
  void onInit() {
    super.onInit();
    ReviewService().getDoctorReview(doctor: selectedDoctor).then((value) {
      print('ada kok datanya');
      listReview = value;
      change(selectedDoctor, status: RxStatus.success());
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
