import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hallo_doctor_client/app/modules/profile/controllers/profile_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class EditImagePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    var image;
    var imageFile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit Image',
          //style: appbarTextStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 330,
              child: const Text(
                "Upload a photo of yourself ",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 330,
              child: GestureDetector(
                onTap: () async {
                  image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (image == null) return;

                  final location = await getApplicationDocumentsDirectory();
                  final name = p.basename(image.path);
                  imageFile = File('${location.path}/$name');
                  final newImage = await File(image.path).copy(imageFile.path);
                  controller.update();
                },
                child: GetBuilder<ProfileController>(
                  builder: (_) {
                    if (image != null) {
                      return Image.file(
                        imageFile,
                        height: 350,
                      );
                    } else {
                      return Image.asset('assets/images/user.png');
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (imageFile == null) return;
                        controller.updateProfilePic(imageFile);
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}