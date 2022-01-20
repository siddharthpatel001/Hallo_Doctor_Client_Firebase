import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/order_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';
import 'package:hallo_doctor_client/app/service/order_service.dart';
import 'package:hallo_doctor_client/app/service/videocall_service.dart';

class AppointmentDetailController extends GetxController
    with StateMixin<TimeSlot> {
  final count = 0.obs;
  VideoCallService videoCallService = Get.find();
  var videoCallStatus = false.obs;
  //ParseObject? room;
  TimeSlot selectedTimeslot = Get.arguments;
  late Doctor doctor;
  late Order order;

  @override
  void onInit() async {
    super.onInit();
    DoctorService().getDoctorDetail(selectedTimeslot.doctorid!).then(
      (doc) {
        selectedTimeslot.doctor = doc;
        change(selectedTimeslot, status: RxStatus.success());
      },
    );

    bool isDoctorReady =
        true; //await videoCallService.getRoom(selectedTimeslot);
    if (isDoctorReady) {
      videoCallStatus.value = true;
      //videoCallService.startListeningRoomDeletion();
      videoCallService.onRoomAvailable = (value) {
        videoCallStatus.value = value;
      };
    } else {
      videoCallService.startListeningRoom(selectedTimeslot);
      videoCallService.onRoomAvailable = (value) {
        videoCallStatus.value = value;
      };
    }
  }

  @override
  void onClose() {
    //videoCallService.stopListeningRoom();
  }

  void startVideoCall() {
    if (videoCallStatus.value) {
      videoCallStatus.value = false;
      //videoCallService.stopListeningRoom();
      Get.toNamed('/video-call', arguments: selectedTimeslot);
    } else {
      Fluttertoast.showToast(
          msg:
              'the doctor has not started the meeting session, this button will automatically turn on when the doctor has started it',
          toastLength: Toast.LENGTH_LONG);
    }
  }

  toConsultationConfirm() {
    Get.toNamed('/consultation-confirm', arguments: selectedTimeslot);
  }

  Future getOrder() async {
    try {
      order = await OrderService().getOrder(selectedTimeslot);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }
}
