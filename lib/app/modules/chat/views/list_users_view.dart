import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ListUser extends GetView<ChatController> {
  void _handlePressed(types.User otherUser, BuildContext context) async {
    print('other user uid : ' + otherUser.id);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    Get.toNamed('/chat', arguments: room);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Users'.tr),
      ),
      body: StreamBuilder<List<types.User>>(
        stream: FirebaseChatCore.instance.users(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Text('No users'.tr),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];

              return GestureDetector(
                onTap: () {
                  //handlePressed(user, context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      // _buildAvatar(user),
                      // Text(getUserName(user)),
                      GestureDetector(
                        onTap: () => _handlePressed(user, context),
                        child: Text(
                          getUserName(user),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  Color getUserAvatarNameColor(types.User user) {
    final index = user.id.hashCode % colors.length;
    return colors[index];
  }

  String getUserName(types.User user) =>
      '${user.displayName ?? ''} ${user.lastName ?? ''}'.trim();
}

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];
