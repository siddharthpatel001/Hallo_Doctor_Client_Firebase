import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset Password.?'.tr,
                style: GoogleFonts.nunito(
                    fontSize: 30, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter Email address associated with your account'.tr,
                style: GoogleFonts.nunito(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              ),
              FormBuilder(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(context),
                      FormBuilderValidators.required(context)
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              RoundedLoadingButton(
                resetAfterDuration: true,
                resetDuration: Duration(seconds: 7),
                child: Text('Reset Password'.tr,
                    style: TextStyle(color: Colors.white)),
                controller: controller.roundedBtnController,
                onPressed: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    controller
                        .resetPassword(_formKey.currentState!.value['email']);
                  } else {
                    controller.roundedBtnController.error();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
