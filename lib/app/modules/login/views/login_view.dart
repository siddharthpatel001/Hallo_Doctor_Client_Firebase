import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/divider_or.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/label_button.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/title_app.dart';
import 'package:hallo_doctor_client/app/modules/widgets/submit_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    final node = FocusScope.of(context);
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  TitleApp(),
                  SizedBox(height: 50),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          validator: ((value) {
                            if (value!.length < 3) {
                              return 'Name must be more than two characters'.tr;
                            } else {
                              return null;
                            }
                          }),
                          onSaved: (username) {
                            controller.username = username ?? '';
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
                        SizedBox(height: 30),
                        GetBuilder<LoginController>(
                          builder: (controller) => TextFormField(
                            obscureText: controller.passwordVisible,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )),
                                fillColor: Colors.grey[200],
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      controller.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.blue[300]),
                                  onPressed: () {
                                    controller.passwordIconVisibility();
                                  },
                                )),
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be empty'.tr;
                              } else {
                                return null;
                              }
                            }),
                            onSaved: (password) {
                              controller.password = password ?? '';
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/forgot-password');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password ?'.tr,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .020),
                  submitButton(
                      onTap: () {
                        controller.login();
                      },
                      text: 'Login'.tr),
                  SizedBox(
                    height: 10,
                  ),
                  DividerOr(),
                  SizedBox(
                    height: 10,
                  ),
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
                  SizedBox(height: 20),
                  LabelButton(
                    onTap: () {
                      Get.toNamed('/register');
                    },
                    title: 'Don\'t have an account, '.tr,
                    subTitle: 'Register'.tr,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
