import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/video_call_controller.dart';

class VideoCallView extends GetView<VideoCallController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: controller.client!,
              layoutType: Layout.floating,
            ),
            AgoraVideoButtons(
              client: controller.client!,
              enabledButtons: [
                BuiltInButtons.switchCamera,
                BuiltInButtons.toggleMic
              ],
              extraButtons: [
                FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.call_end),
                    onPressed: () => Get.defaultDialog(
                          title: 'End the Consultation',
                          content: Text(
                            'are you sure you want to end Consultation',
                          ),
                          textCancel: 'Cancel',
                          textConfirm: 'Yes',
                          onConfirm: () {
                            controller.completedConsultation();
                          },
                        ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
