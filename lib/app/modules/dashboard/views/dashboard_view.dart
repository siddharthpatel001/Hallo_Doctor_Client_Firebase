import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/appointment/views/appointment_view.dart';
import 'package:hallo_doctor_client/app/modules/doctor_category/views/doctor_category_view.dart';
import 'package:hallo_doctor_client/app/modules/home/views/home_view.dart';
import 'package:hallo_doctor_client/app/modules/list_chat/views/list_chat_view.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/profile_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final List<Widget> bodyContent = [
    HomeView(),
    DoctorCategoryView(),
    AppointmentView(),
    ListChatView(),
    ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue[700],
            unselectedItemColor: Colors.blue[300],
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.blue[500],
                  ),
                  label: "Home".tr),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.contacts,
                    color: Colors.blue[500],
                  ),
                  label: "Doctor".tr),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.video_camera_front,
                    color: Colors.blue[500],
                  ),
                  label: "Appointment".tr),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message,
                    color: Colors.blue[500],
                  ),
                  label: "Chat".tr),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue[500],
                  ),
                  label: "Profile".tr),
            ],
            currentIndex: controller.selectedIndex,
            onTap: (index) {
              controller.selectedIndex = index;
            },
          )),
      body: Obx(
        () => Center(
          child: IndexedStack(
              index: controller.selectedIndex, children: bodyContent),
        ),
      ),
    );
  }
}
