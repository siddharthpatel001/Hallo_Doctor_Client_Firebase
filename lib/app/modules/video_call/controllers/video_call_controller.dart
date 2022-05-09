import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/videocall_service.dart';
import 'package:hallo_doctor_client/app/utils/environment.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

class VideoCallController extends GetxController {
  TimeSlot timeSlot = Get.arguments[0]['timeSlot'];
  String token = Get.arguments[0]['token'];
  String room = Get.arguments[0]['room'];
  bool videoCallEstablished = false;
  VideoCallService videoCallService = Get.find();
  bool localUserJoined = false;
  bool localAudioMute = false;
  int? remoteUid;
  // Instantiate the client
  late RtcEngine engine;
  @override
  void onInit() {
    super.onInit();
    initAgora();
  }

  @override
  void onReady() async {
    super.onReady();
    update();
  }

  @override
  void onClose() async {
    await destroyAgora();
  }

  completedConsultation() async {
    if (videoCallEstablished) {
      Get.offNamedUntil(
          '/consultation-confirm', ModalRoute.withName('/appointment-detail'),
          arguments: timeSlot);
    } else {
      printError(info: 'video call not establish yet');
      Get.back();
    }
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    engine = await RtcEngine.create(Environment.agoraAppId);
    await engine.enableVideo();
    engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          localUserJoined = true;
          videoCallEstablished = true;
          update();
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");

          remoteUid = uid;
          update();
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          remoteUid = null;
          completedConsultation();
          update();
        },
      ),
    );

    await engine.joinChannel(token, room, null, 0);
  }

  Future endMeeting() async {
    await destroyAgora();
    Get.back();
  }

  Future destroyAgora() async {
    await VideoCallService().removeRoom(room);
    await engine.leaveChannel();
    await engine.destroy();
  }

  Future switchCamera() async {
    try {
      await engine.switchCamera();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future toggleLotcalAudioMuted() async {
    try {
      localAudioMute = !localAudioMute;
      await engine.muteLocalAudioStream(localAudioMute);
      update();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
