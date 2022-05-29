import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/order_service.dart';
import 'package:hallo_doctor_client/app/service/problem_service.dart';

class ConsultationConfirmController extends GetxController {
  TimeSlot timeSlot = Get.arguments;
  var problemVisible = false.obs;

  @override
  void onClose() {}

  sendProblem(String problem) {
    EasyLoading.show();
    ProblemService().sendProblem(problem, timeSlot).then((value) {
      Get.back();
      Get.defaultDialog(
          title: 'Info'.tr,
          onConfirm: () => Get.back(),
          middleText: 'Payment for '.tr +
              timeSlot.doctor!.doctorName! +
              ' will be delayed until the problem is resolved'.tr);
      EasyLoading.dismiss();
    });
  }

  confirmConsultation() async {
    try {
      EasyLoading.show();
      await OrderService().confirmOrder(timeSlot);
      EasyLoading.dismiss();
      Get.offNamedUntil('/review', ModalRoute.withName('/appointment-detail'),
          arguments: timeSlot);
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
