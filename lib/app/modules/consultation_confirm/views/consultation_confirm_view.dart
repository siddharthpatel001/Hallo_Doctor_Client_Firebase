import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_client/app/modules/widgets/submit_button.dart';

import '../controllers/consultation_confirm_controller.dart';

class ConsultationConfirmView extends GetView<ConsultationConfirmController> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation Confirmation'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Obx(() => Column(
                  children: [
                    Text(
                      'Has the consultation with the ${controller.timeSlot.doctor!.doctorName} been completed?',
                      style: GoogleFonts.nunito(fontSize: 25),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    submitButton(
                        onTap: () {
                          Get.defaultDialog(
                              title: 'Confirm',
                              middleText:
                                  'payment for doctor amsyari will be made if you confirm this transaction',
                              textCancel: 'Cancel',
                              textConfirm: 'Confirm',
                              onConfirm: () {
                                controller.confirmConsultation();
                              });
                        },
                        text: 'Yes & Give Review'),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        controller.problemVisible.value =
                            !controller.problemVisible.value;
                      },
                      child: Text('No, there is a problem'),
                    ),
                    Visibility(
                      visible: controller.problemVisible.value,
                      child: Container(
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              FormBuilderRadioGroup(
                                decoration:
                                    InputDecoration(labelText: 'Problem'),
                                name: 'my_problem',
                                validator:
                                    FormBuilderValidators.required(context),
                                options: [
                                  'Black screen, no consultation happened',
                                  'No sound',
                                  'Video call quality is very bad',
                                  'No consultation at all',
                                  'Other'
                                ]
                                    .map((lang) =>
                                        FormBuilderFieldOption(value: lang))
                                    .toList(growable: false),
                              ),
                              FormBuilderTextField(
                                name: 'specify',
                                decoration: InputDecoration(
                                    labelText:
                                        'Please, explain the problem briefly'),
                                validator: (val) {
                                  if (_formKey.currentState
                                              ?.fields['my_problem']?.value ==
                                          'Other' &&
                                      (val == null || val.isEmpty)) {
                                    return 'Kindly explain your problem';
                                  }
                                },
                                initialValue: '',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      controller.sendProblem('problem : ' +
                                          _formKey.currentState!
                                              .value['my_problem'] +
                                          ' detail: ' +
                                          _formKey
                                              .currentState!.value['specify']);
                                    }
                                  },
                                  child: Text('Send'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
