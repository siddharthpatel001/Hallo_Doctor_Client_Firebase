import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        leadingWidth: 25,
        title: InkWell(
          // onTap: () =>
          //     Get.toNamed('/detail-doctor', arguments: controller.doctor),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundImage:
                      NetworkImage(controller.doctor.doctorPicture!)),
              SizedBox(
                width: 10,
              ),
              Text(controller.doctor.doctorName!)
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: StreamBuilder<types.Room>(
          initialData: controller.room,
          stream: FirebaseChatCore.instance.room(controller.room.id),
          builder: (context, snapshot) {
            return StreamBuilder<List<types.Message>>(
              initialData: const [],
              stream: FirebaseChatCore.instance.messages(snapshot.data!),
              builder: (context, snapshot) {
                return SafeArea(
                  bottom: false,
                  child: Chat(
                    isAttachmentUploading:
                        controller.isAttachmentUploading.value,
                    messages: snapshot.data ?? [],
                    onAttachmentPressed: () => handleAtachmentPressed(context),
                    onMessageTap: controller.handleMessageTap,
                    onPreviewDataFetched: controller.handlePreviewDataFetched,
                    onSendPressed: controller.handleSendPressed,
                    user: types.User(
                      id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void handleAtachmentPressed(context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    controller.handleImageSelection();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'.tr),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    controller.handleFileSelection();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'.tr),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'.tr),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
