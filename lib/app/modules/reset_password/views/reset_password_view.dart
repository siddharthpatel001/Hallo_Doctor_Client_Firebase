import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'.tr),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Reset Password View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
