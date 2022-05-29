import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/appointment_detail/views/widgets/doctor_tile.dart';
import 'package:hallo_doctor_client/app/utils/styles/styles.dart';
import 'package:hallo_doctor_client/app/utils/timeformat.dart';

import '../controllers/appointment_detail_controller.dart';
import 'widgets/videocall_button.dart';

class AppointmentDetailView extends GetView<AppointmentDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Consultation Detail'.tr),
          centerTitle: true,
          actions: [
            //list if widget in appbar actions
            PopupMenuButton(
              color: Colors.white,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "Reschedule Appointment".tr,
                  ),
                ),
              ],
              onSelected: (int item) => {
                if (item == 0)
                  {
                    //cancel appointment click
                    Get.defaultDialog(
                        title: 'Reschedule Appointment'.tr,
                        content: Text(
                          'You can only reschedule this appointment once, Are you sure want to reschedule this appointment'
                              .tr,
                          textAlign: TextAlign.center,
                        ),
                        onCancel: () {},
                        onConfirm: () {
                          Get.back();
                          controller.rescheduleAppointment();
                        })
                  }
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: controller.obx(
            (timeSlot) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Appointment With'.tr,
                    style: Styles.appointmentDetailTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DoctorTile(
                  imgUrl: timeSlot!.doctor!.doctorPicture!,
                  name: timeSlot.doctor!.doctorName!,
                  orderTime: timeSlot.purchaseTime!,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Schedule Detail'.tr,
                    style: Styles.appointmentDetailTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 240,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x04000000),
                          blurRadius: 10,
                          spreadRadius: 10,
                          offset: Offset(0.0, 8.0),
                        )
                      ],
                      color: Colors.white),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Table(
                        children: [
                          TableRow(children: [
                            SizedBox(
                                height: 50, child: Text('Appointment Time'.tr)),
                            SizedBox(
                                height: 50,
                                child: Text(TimeFormat().formatDate(
                                    controller.selectedTimeslot.timeSlot!))),
                          ]),
                          TableRow(children: [
                            SizedBox(height: 50, child: Text('Duration'.tr)),
                            SizedBox(
                                height: 50,
                                child: Text(': ' +
                                    controller.selectedTimeslot.duration
                                        .toString() +
                                    ' Minute'.tr)),
                          ]),
                          TableRow(
                            children: [
                              SizedBox(
                                height: 50,
                                child: Text('Price'.tr),
                              ),
                              SizedBox(
                                height: 50,
                                child: Text(
                                  ': \$' +
                                      controller.selectedTimeslot.price
                                          .toString() +
                                      ' (Paid)'.tr,
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              SizedBox(
                                height: 50,
                                child: Text('Status'.tr),
                              ),
                              SizedBox(
                                height: 50,
                                child: Text(
                                  controller.selectedTimeslot.status ?? '',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() => VideoCallButton(
                      function: () {
                        controller.startVideoCall();
                      },
                      text: 'Start Consultation'.tr,
                      active: controller.videoCallStatus.value,
                      nonActiveMsg:
                          'the doctor has canceled the appointment, and your payment has been refunded'
                              .tr,
                    )),
                SizedBox(
                  height: 10,
                ),
                controller.selectedTimeslot.status == 'refund'
                    ? Text(
                        'the doctor has canceled the appointment, and your payment has been refunded'
                            .tr,
                        style: Styles.greyTextInfoStyle,
                      )
                    : Text(
                        'the start consultation button will be active when the doctor starts the consultation'
                            .tr,
                        style: Styles.greyTextInfoStyle,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
