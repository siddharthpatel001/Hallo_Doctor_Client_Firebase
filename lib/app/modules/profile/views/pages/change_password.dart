import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/profile/controllers/profile_controller.dart';
import 'package:hallo_doctor_client/app/modules/widgets/submit_button.dart';

class ChangePasswordPage extends GetView<ProfileController> {
  final _formKey = GlobalKey<FormBuilderState>();

  ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Change Password'.tr,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                      child: FormBuilderTextField(
                        // Handles Form Validation for First Name
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.minLength(context, 3)
                        ]),
                        decoration:
                            InputDecoration(labelText: 'Curren Password'),
                        name: 'currentPassword',
                        keyboardType: TextInputType.visiblePassword,
                        onEditingComplete: () => node.nextFocus(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                      child: FormBuilderTextField(
                        // Handles Form Validation for First Name
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.minLength(context, 3)
                        ]),
                        decoration:
                            InputDecoration(labelText: 'New Password'.tr),
                        name: 'newPassword',
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (value) =>
                            controller.newPassword.value = value!,
                        onSubmitted: (value) =>
                            controller.newPassword.value = value!,
                        onEditingComplete: () => node.nextFocus(),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                        child: FormBuilderTextField(
                          // Handles Form Validation for First Name
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.equal(
                                context, controller.newPassword.value),
                            FormBuilderValidators.minLength(context, 3)
                          ]),
                          decoration: InputDecoration(
                              labelText: 'Confirm New Password'.tr),
                          name: 'confirmNewPassword',
                          keyboardType: TextInputType.visiblePassword,
                          onEditingComplete: () {
                            _formKey.currentState!.save();
                            _formKey.currentState!.validate();
                            node.nextFocus();
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 150, left: 20, right: 20),
                      child: submitButton(
                          onTap: () {
                            _formKey.currentState!.save();
                            print('current password : ' +
                                _formKey
                                    .currentState!.value['currentPassword']);
                            print('password : ' + controller.newPassword.value);
                            print('new password : ' +
                                _formKey
                                    .currentState!.value['confirmNewPassword']);
                            if (_formKey.currentState!.validate()) {
                              // controller.updateEmail(
                              //     _formKey.currentState!.value['email']);
                              controller.changePassword(
                                  _formKey
                                      .currentState!.value['currentPassword'],
                                  _formKey.currentState!
                                      .value['confirmNewPassword']);
                            } else {
                              print('Validation Failed');
                            }
                          },
                          text: 'Save'),
                    )
                  ],
                )),
          ),
        ));
  }
}
