import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/utils/search/search_doctor_delegate.dart';

import '../controllers/search_doctor_controller.dart';

class SearchDoctorView extends GetView<SearchDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Doctor'.tr),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                controller.doctor.value = (await showSearch(
                  context: context,
                  delegate: SearchDoctorDelegat(),
                ))!;
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Obx(
          () => Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: controller.doctor.value.doctorName == null
                ? Center(
                    child: Text(
                      'Search Doctor'.tr,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView(children: [
                    Card(
                      child: ListTile(
                        onTap: () {
                          Get.toNamed('/detail-doctor',
                              arguments: controller.doctor.value);
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider(
                              controller.doctor.value.doctorPicture!),
                        ),
                        title: Text(controller.doctor.value.doctorName!),
                        trailing: RatingBarIndicator(
                            rating: 4.5,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                      ),
                    ),
                  ]),
          ),
        ));
  }
}
