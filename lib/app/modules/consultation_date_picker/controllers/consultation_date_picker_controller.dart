import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';
import 'package:hallo_doctor_client/app/service/timeslot_service.dart';

enum TimeSlotStatus { startUp, unselected, selected }

class ConsultationDatePickerController extends GetxController
    with StateMixin<List<TimeSlot>> {
  List<TimeSlot> allTimeSlot = List.empty();
  late List<TimeSlot> selectedDateTimeslot = List.empty();
  var selectedTimeSlot = TimeSlot().obs;
  Doctor doctor = Get.arguments[0];
  bool isReschedule = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments[1] != null) isReschedule = true;
    print('is Reschedule ' + isReschedule.toString());
    DoctorService().getDoctorTimeSlot(doctor).then((timeSlot) {
      allTimeSlot = timeSlot;
      updateScheduleAtDate(
          DateTime.now().day, DateTime.now().month, DateTime.now().year);
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error(error.toString()));
    });
  }

  @override
  void onClose() {}

  void updateScheduleAtDate(int date, int month, int year) {
    var schedule = allTimeSlot
        .where((timeSlot) =>
            timeSlot.timeSlot!.day.isEqual(date) &&
            timeSlot.timeSlot!.month.isEqual(month) &&
            timeSlot.timeSlot!.year.isEqual(year))
        .toList();
    print('Schedule for date ${date.toString()} is : ' +
        schedule.length.toString());
    change(schedule, status: RxStatus.success());
  }

  void confirm() async {
    try {
      if (isReschedule) {
        EasyLoading.show();
        await TimeSlotService()
            .rescheduleTimeslot(Get.arguments[1], selectedTimeSlot.value);
        Fluttertoast.showToast(
            msg: 'Appointment has been successfully rescheduled'.tr);
        EasyLoading.dismiss();
        Get.back();
      } else {
        Get.toNamed(
          '/detail-order',
          arguments: [selectedTimeSlot.value, doctor],
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
