import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/widgets/submit_button.dart';

import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Review Doctor'.tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: CachedNetworkImageProvider(
                          controller.timeSlot.doctor!.doctorPicture!),
                    ),
                    title: Text(controller.timeSlot.doctor!.doctorName!),
                  ),
                  Divider(),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Your Review'.tr),
                    maxLines: 10,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) => controller.review = value,
                  ),
                  Divider(),
                  Obx(() => RatingBar.builder(
                        initialRating: controller.rating.value,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          print(rating);
                        },
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  submitButton(
                      onTap: () {
                        controller.saveReiew();
                      },
                      text: "Send".tr)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
