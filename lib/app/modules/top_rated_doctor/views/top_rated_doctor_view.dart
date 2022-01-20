import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../controllers/top_rated_doctor_controller.dart';

class TopRatedDoctorView extends GetView<TopRatedDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Doctor'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: controller.obx(
          (listDoctor) => ListView.builder(
              shrinkWrap: true,
              itemCount: listDoctor!.length,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            listDoctor[index].doctorPicture!),
                      ),
                      title: Text(listDoctor[index].doctorName!),
                      trailing: RatingBarIndicator(
                          rating: 4.5,
                          itemCount: 5,
                          itemSize: 20.0,
                          itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              )),
                    ),
                  )),
        ),
      ),
    );
  }
}
