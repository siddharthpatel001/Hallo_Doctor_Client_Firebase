import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:get/get.dart';

import '../controllers/video_call_controller.dart';

class VideoCallView extends GetView<VideoCallController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<VideoCallController>(
          builder: (_) {
            return Stack(
              children: [
                Center(
                  child: _remoteVideo(),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 100,
                    height: 150,
                    child: Center(
                      child: controller.localUserJoined
                          ? RtcLocalView.SurfaceView()
                          : CircularProgressIndicator(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: controller.toggleLotcalAudioMuted,
                          child: controller.localAudioMute == false
                              ? Icon(Icons.mic_off)
                              : Icon(Icons.mic),
                          heroTag: 'micOff',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: controller.switchCamera,
                          child: Icon(Icons.switch_camera),
                          heroTag: 'cameraSwitch',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            controller.completedConsultation();
                          },
                          child: Icon(Icons.call_end),
                          backgroundColor: Colors.red,
                          heroTag: 'endMeeting',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _remoteVideo() {
    if (controller.remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: controller.remoteUid!,
        channelId: controller.room,
      );
    } else {
      return Text(
        'Please wait for remote user to join'.tr,
        textAlign: TextAlign.center,
      );
    }
  }
}
