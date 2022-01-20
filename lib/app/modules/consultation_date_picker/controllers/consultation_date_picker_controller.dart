import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';

enum TimeSlotStatus { startUp, unselected, selected }

class ConsultationDatePickerController extends GetxController
    with StateMixin<List<TimeSlot>> {
  List<TimeSlot> allTimeSlot = List.empty();
  late List<TimeSlot> selectedDateTimeslot = List.empty();
  var selectedTimeSlot = TimeSlot().obs;
  Doctor doctor = Get.arguments[0];

  @override
  void onInit() {
    super.onInit();
    DoctorService().getDoctorTimeSlot(doctor).then((timeSlot) {
      allTimeSlot = timeSlot;
      updateScheduleAtDate(DateTime.now().day);
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error(error.toString()));
    });
  }

  @override
  void onClose() {}

  void updateScheduleAtDate(int date) {
    var schedule = allTimeSlot
        .where((timeSlot) => timeSlot.timeSlot!.day.isEqual(date))
        .toList();
    print('Schedule for date ${date.toString()} is : ' +
        schedule.length.toString());
    change(schedule, status: RxStatus.success());
  }
}
