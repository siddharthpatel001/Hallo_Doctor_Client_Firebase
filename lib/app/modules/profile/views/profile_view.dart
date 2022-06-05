import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/widgets/header_curve_widget.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/widgets/profile_button.dart';
import 'package:hallo_doctor_client/app/utils/localization.dart';
import '../controllers/profile_controller.dart';
import 'widgets/display_image_widget.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        elevation: 0,
        title: Text(
          'Profile'.tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        CustomPaint(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          painter: HeaderCurvedContainer(),
        ),
        Obx(
          () => Column(
            children: [
              InkWell(
                  onTap: () {},
                  child: DisplayImage(
                    imagePath: controller.profilePic.value,
                    onPressed: () {
                      controller.toEditImage();
                    },
                  )),
              Card(
                margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                elevation: 3,
                child: Column(
                  children: [
                    ProfileButton(
                      icon: Icons.person,
                      text: controller.username.value,
                      onTap: () {},
                      hideArrowIcon: true,
                    ),
                    ProfileButton(
                      icon: Icons.email,
                      text: controller.email.value,
                      onTap: () {
                        controller.toUpdateEmail();
                      },
                    ),
                    ProfileButton(
                      icon: Icons.password,
                      text: 'Change Password'.tr,
                      onTap: () {
                        controller.toChangePassword();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.logout();
                        },
                        child: Text('Logout'.tr),
                      ),
                    ),
                    //uncomment if you wanto test something
                    // ElevatedButton(
                    //   onPressed: () {
                    //     //controller.testButton();
                    //     LocalizationService().changeLocale('France');
                    //   },
                    //   child: Text('test button'),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Center(
                  child:
                      Text('App Version : '.tr + controller.appVersion.value),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => editPage);
                      },
                      child: Text(
                        getValue,
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  )
                ],
              ),
            )
          ],
        ),
      );
}
