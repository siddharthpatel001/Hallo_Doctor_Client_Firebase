import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/divider_or.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/label_button.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/title_app.dart';
import 'package:hallo_doctor_client/app/modules/widgets/submit_button.dart';
import 'package:hallo_doctor_client/app/utils/helpers/validation.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      TitleApp(),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: ((value) {
                          if (value!.length < 6) {
                            return 'Name must be  6 or more characters'.tr;
                          } else {
                            return null;
                          }
                        }),
                        onSaved: (username) {
                          controller.username = username!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: ((value) {
                          return Validation().validateEmail(value);
                        }),
                        onSaved: (email) {
                          controller.email = email!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GetBuilder<RegisterController>(
                          builder: (controller) => TextFormField(
                                obscureText: controller.passwordVisible,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: () {
                                  node.nextFocus();
                                },
                                validator: ((value) {
                                  if (value!.length < 3) {
                                    return 'Password must be more thand four characters'
                                        .tr;
                                  } else {
                                    return null;
                                  }
                                }),
                                onSaved: (password) {
                                  controller.password = password!;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          controller.passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.blue[300]),
                                      onPressed: () {
                                        controller.passwordIconVisibility();
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        )),
                                    fillColor: Colors.grey[200],
                                    filled: true),
                              )),
                      SizedBox(
                        height: 20,
                      ),
                      submitButton(
                          onTap: () {
                            controller.signUpUser();
                          },
                          text: 'Register Now'.tr),
                      SizedBox(height: height * .01),
                      DividerOr(),
                      Container(
                        width: Get.width,
                        height: 50,
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () {
                            controller.loginGoogle();
                          },
                        ),
                      ),
                      LabelButton(
                        onTap: () {},
                        title: 'Already have an account ?'.tr,
                        subTitle: 'Login'.tr,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: BackButton()),
          ],
        ),
      ),
    );
  }
}
