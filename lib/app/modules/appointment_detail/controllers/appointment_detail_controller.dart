import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
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
  late String token;
  var database = FirebaseDatabase.instance.ref();
  StreamSubscription? _roomCreateSubscription;
  StreamSubscription? _roomRemoveSubscription;

  @override
  void onInit() async {
    super.onInit();
    DoctorService().getDoctorDetail(selectedTimeslot.doctorid!).then(
      (doc) {
        selectedTimeslot.doctor = doc;
        change(selectedTimeslot, status: RxStatus.success());
      },
    );
    _roomCreateSubscription = database
        .child('room/' + selectedTimeslot.timeSlotId!)
        .onChildAdded
        .listen((event) async {
      await Future.delayed(const Duration(seconds: 3), () {
        videoCallStatus.value = true;
        if (event.snapshot.key == 'token') {
          print('room added token : ' + event.snapshot.value.toString());
          token = event.snapshot.value.toString();
        }
      });
    });
    _roomRemoveSubscription = database
        .child('room/' + selectedTimeslot.timeSlotId!)
        .onChildRemoved
        .listen((event) {
      videoCallStatus.value = false;
      print('room delete');
    });
  }

  @override
  void onClose() {
    _roomCreateSubscription!.cancel();
    _roomRemoveSubscription!.cancel();
  }

  void startVideoCall() {
    if (videoCallStatus.value) {
      videoCallStatus.value = false;
      //videoCallService.stopListeningRoom();
      Get.toNamed('/video-call', arguments: [
        {
          'timeSlot': selectedTimeslot,
          'room': selectedTimeslot.timeSlotId,
          'token': token
        }
      ]);
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
      order = await OrderService().getSuccessOrder(selectedTimeslot);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }
}
