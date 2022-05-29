import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/utils/styles/styles.dart';

// ignore: must_be_immutable
class VideoCallButton extends Container {
  final VoidCallback function;
  final String text;
  @override
  // ignore: overridden_fields
  final Color color;
  final Color textColor;
  final Color splashColor;
  final double fontSize;
  bool active;
  final String nonActiveMsg;

  VideoCallButton(
      {required this.function,
      required this.text,
      this.splashColor = Colors.blueGrey,
      this.fontSize = 16,
      this.color = Colors.blue,
      this.textColor = Colors.white,
      this.active = false,
      required this.nonActiveMsg});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: active
          ? function
          : () {
              Fluttertoast.showToast(msg: nonActiveMsg);
            },
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: active == true
                ? [Styles.secondaryBlueColor, Styles.primaryBlueColor]
                : [Colors.grey, Colors.grey],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_call_rounded,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
