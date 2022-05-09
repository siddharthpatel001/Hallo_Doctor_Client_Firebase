import 'package:flutter/material.dart';
import 'package:hallo_doctor_client/app/utils/styles/styles.dart';

class TitleApp extends StatelessWidget {
  const TitleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/ic_launcher.png',
          width: 45,
          height: 45,
        ),
        SizedBox(
          width: 10,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Halo',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Styles.secondaryBlueColor),
            children: [
              TextSpan(
                text: ' Doctor',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
