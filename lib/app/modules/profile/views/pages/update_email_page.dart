import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/profile/controllers/profile_controller.dart';
import 'package:hallo_doctor_client/app/modules/widgets/submit_button.dart';

class UpdateEmailPage extends GetView<ProfileController> {
  final _formKey = GlobalKey<FormBuilderState>();

  UpdateEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Update Email'.tr,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'What\'s Your New Email Address?'.tr,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                    child: FormBuilderTextField(
                      // Handles Form Validation for First Name
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context)
                      ]),
                      decoration:
                          InputDecoration(labelText: 'New Email Address'),
                      name: 'email',
                      keyboardType: TextInputType.emailAddress,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: submitButton(
                      onTap: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          controller.updateEmail(
                              _formKey.currentState!.value['email']);
                        } else {
                          print("validation failed");
                        }
                      },
                      text: 'Save'),
                )
              ],
            ),
          ),
        ));
  }
}
