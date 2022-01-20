import 'package:get/get.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(index) => _selectedIndex.value = index;
  final count = 0.obs;
  @override
  void onClose() {}
  void increment() => count.value++;
}
