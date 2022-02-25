import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/videocall_service.dart';
import 'package:hallo_doctor_client/app/utils/environment.dart';

class VideoCallController extends GetxController {
  TimeSlot timeSlot = Get.arguments[0]['timeSlot'];
  String token = Get.arguments[0]['token'];
  String room = Get.arguments[0]['room'];
  bool videoCallEstablished = false;
  VideoCallService videoCallService = Get.find();
  // Instantiate the client
  late final AgoraClient? client;
  @override
  void onInit() {
    super.onInit();
    client = AgoraClient(
      agoraEventHandlers: AgoraEventHandlers(
        userOffline: (i, j) {
          switch (j) {
            case UserOfflineReason.Quit:
              client!.sessionController.endCall();
              completedConsultation();
              break;
            default:
              return;
          }
        },
        joinChannelSuccess: (channel, uid, elapsed) {
          videoCallEstablished = true;
          print('video call establish');
        },
      ),
      agoraConnectionData: AgoraConnectionData(
        tempToken: token,
        appId: Environment.agoraAppId,
        channelName: room,
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
    );
    initAgora();
    print('init video call');
  }

  void initAgora() async {
    await client!.initialize();
  }

  @override
  void onReady() async {
    super.onReady();
    update();
  }

  @override
  void onClose() async {
    //signaling.hangUp(localRenderer);
    client!.sessionController.endCall();
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
}
