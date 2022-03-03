import 'package:get/get.dart';

import '../controllers/list_chat_controller.dart';

class ListChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListChatController>(
      () => ListChatController(),
    );
  }
}
