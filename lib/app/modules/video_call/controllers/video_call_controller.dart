import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/videocall_service.dart';

class VideoCallController extends GetxController {
  TimeSlot timeSlot = Get.arguments;
  VideoCallService videoCallService = Get.find();
  // Instantiate the client
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      tempToken:
          '0065918380664394b78bd3b16842b254f3cIAAR6GCW14nJZvuBajnHyFvhBNEj5pMASoleOEGbx+m0Jgx+f9gAAAAAEABLPQ3JMezpYQEAAQAw7Olh',
      appId: "5918380664394b78bd3b16842b254f3c",
      channelName: "test",
    ),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );
  @override
  void onInit() {
    super.onInit();
    initAgora();
    print('init video call');
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  void onReady() async {
    super.onReady();
    update();
  }

  @override
  void onClose() async {
    //signaling.hangUp(localRenderer);
  }

  registerSignalingListener() {
    // signaling.onAddRemoteStream = ((stream) {
    //   remoteRenderer.srcObject = stream;
    //   update();
    // });
    // signaling.onRemoveRemoteStream = ((stream) {
    //   remoteRenderer.srcObject = null;
    //   print('** REMOTE REMOVE');
    // });
    // signaling.onRemoteHangUp = ((value) async {
    //   await completedConsultation();
    // });
  }

  hangUp() async {
    Get.back();
  }

  completedConsultation() async {
    Get.offNamed('/consultation-confirm', arguments: timeSlot);
  }
}
