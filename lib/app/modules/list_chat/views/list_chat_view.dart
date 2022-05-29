import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/service/chat_service.dart';
import '../../../service/user_service.dart';
import '../controllers/list_chat_controller.dart';

class ListChatView extends GetView<ListChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'.tr),
        centerTitle: true,
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Text('The chat is empty'.tr),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final room = snapshot.data![index];
              print('room : ' + room.imageUrl.toString());
              return _buildChatItem(room);
            },
          );
        },
      ),
    );
  }

  Widget _buildAvatar(String imgUrl) {
    return Container(
        margin: const EdgeInsets.only(right: 16),
        child: CircleAvatar(
          backgroundImage: NetworkImage(imgUrl),
          radius: 20,
        ));
  }

  Widget _buildName(String name) => Text(name);

  Widget _buildChatItem(types.Room room) => FutureBuilder<Doctor>(
      future: ChatService().getDoctorByUserId(room.users[1].id),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return SizedBox();
        }
        return GestureDetector(
          onTap: () {
            Get.toNamed('/chat', arguments: [room, snapshot.data]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                _buildAvatar(snapshot.data!.doctorPicture!),
                _buildName(snapshot.data!.doctorName!),
              ],
            ),
          ),
        );
      });
}
