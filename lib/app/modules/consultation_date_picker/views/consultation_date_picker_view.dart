import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_client/app/utils/constants/style_constants.dart';
import 'package:intl/intl.dart';
import '../controllers/consultation_date_picker_controller.dart';

class ConsultationDatePickerView
    extends GetView<ConsultationDatePickerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chose Timeslot'.tr),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Chose Date'.tr,
              style: titleTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              daysCount: 10,
              selectionColor: secondaryColor,
              onDateChange: (date) {
                controller.updateScheduleAtDate(
                    date.day, date.month, date.year);
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Chose Time'.tr,
              style: titleTextStyle,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: controller.obx(
                (timeSlot) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: timeSlot!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    var timeStartFormat =
                        DateFormat.Hm().format(timeSlot[index].timeSlot!);
                    var timeEnd = timeSlot[index]
                        .timeSlot!
                        .add(Duration(minutes: timeSlot[index].duration!));
                    var timeEndFormat = DateFormat.Hm().format(timeEnd);
                    if (timeSlot[index].available!) {
                      return InkWell(
                        onTap: () {
                          controller.selectedTimeSlot.value = timeSlot[index];
                        },
                        child: Obx(
                          () => Container(
                            alignment: Alignment.center,
                            child: Text(
                              timeStartFormat +
                                  ' - ' +
                                  timeEndFormat +
                                  '\n Available'.tr,
                              textAlign: TextAlign.center,
                            ),
                            decoration: (controller.selectedTimeSlot.value ==
                                    timeSlot[index])
                                ? BoxDecoration(
                                    color: Colors.green[100],
                                    border: Border.all(
                                        color: Colors.green, width: 5),
                                    borderRadius: BorderRadius.circular(15),
                                  )
                                : BoxDecoration(
                                    color: Colors.green[400],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          timeStartFormat +
                              ' - ' +
                              timeEndFormat +
                              '\n Unavailable'.tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                if (controller.selectedTimeSlot.value.timeSlotId == null) {
                  Fluttertoast.showToast(msg: 'Please select time slot'.tr);
                } else {
                  controller.confirm();
                }
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: secondaryColor,
                ),
                child: Text(
                  'Confirm'.tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
