import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/modules/home/views/components/icon_card.dart';
import 'package:hallo_doctor_client/app/modules/home/views/components/list_doctor_card.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';
import 'package:hallo_doctor_client/app/utils/constants/style_constants.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final CarouselController caoruselController = CarouselController();
    return Scaffold(
      backgroundColor: mBackgroundColor,
      body: SafeArea(
        child: Obx(
          () => CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      padding: EdgeInsets.fromLTRB(17, 15, 17, 10),
                      child: Container(
                        child: Row(
                          children: [
                            controller.userPicture.value.isEmpty
                                ? Image.asset('assets/images/user.png')
                                : CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        controller.userPicture.value),
                                  ),
                            Padding(
                              padding: EdgeInsets.only(left: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Welcome Back,'.tr,
                                    style: mWelcomeTitleStyle,
                                  ),
                                  Text(
                                    controller
                                        .userService.currentUser!.displayName!,
                                    style: mUsernameTitleStyle,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.notifications_none)),
                            ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GetBuilder<HomeController>(
                        builder: (_) {
                          return CarouselSlider(
                            carouselController: caoruselController,
                            options: CarouselOptions(
                                height: 200,
                                autoPlay: true,
                                aspectRatio: 2.0,
                                viewportFraction: 0.9,
                                onPageChanged: (index, reason) {
                                  controller.carouselChange(index);
                                }),
                            items: imgListAssetSlider(
                                controller.listImageCarousel),
                          );
                        },
                      ),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.listImageCarousel.isNotEmpty
                            ? controller.listImageCarousel
                                .asMap()
                                .entries
                                .map((entry) {
                                return GestureDetector(
                                  onTap: () => caoruselController
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: 12.0,
                                    height: 12.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black)
                                            .withOpacity(
                                                controller.getcaoruselIndex ==
                                                        entry.key
                                                    ? 0.9
                                                    : 0.4)),
                                  ),
                                );
                              }).toList()
                            : imgListAsset.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => caoruselController
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: 12.0,
                                    height: 12.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black)
                                            .withOpacity(
                                                controller.getcaoruselIndex ==
                                                        entry.key
                                                    ? 0.9
                                                    : 0.4)),
                                  ),
                                );
                              }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconCard(
                            iconData: Icons.category,
                            text: "Doctor Specialist".tr,
                            onTap: () {
                              controller.toDoctorCategory();
                            },
                          ),
                          IconCard(
                            iconData: Icons.list_alt_rounded,
                            text: "Top Rated Doctor".tr,
                            onTap: () {
                              controller.toTopRatedDoctor();
                            },
                          ),
                          IconCard(
                            iconData: Icons.search,
                            text: "Search Doctor".tr,
                            onTap: () {
                              controller.toSearchDoctor();
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Top Rated Doctor'.tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextButton(
                              onPressed: () {
                                controller.toTopRatedDoctor();
                              },
                              child: Text('View All'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[300])),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        displacement: 10,
                        onRefresh: () => test(),
                        child: FutureBuilder<List<Doctor>>(
                          future: DoctorService().getTopRatedDoctor(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                              default:
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('error '.tr +
                                        snapshot.error.toString()),
                                  );
                                } else if (snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Top Rated Doctor is empty '.tr,
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (contex, index) =>
                                          DoctorCard(
                                            doctorName: snapshot
                                                .data![index].doctorName,
                                            doctorSpecialty: snapshot
                                                .data![index]
                                                .doctorCategory!
                                                .categoryName,
                                            imageUrl: snapshot
                                                .data![index].doctorPicture,
                                            onTap: () {
                                              Get.toNamed('/detail-doctor',
                                                  arguments:
                                                      snapshot.data![index]);
                                            },
                                          ));
                                }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> test() async {
    return Future.delayed(Duration(seconds: 5));
  }
}

final List<String> imgListAsset = [
  'assets/images/carousel1.jpg',
  'assets/images/carousel1.jpg'
];

List<Widget> imgListAssetSlider(List<String?> imgCarouselList) {
  if (imgCarouselList.isEmpty) {
    return imgListAsset
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                      ],
                    )),
              ),
            ))
        .toList();
  }
  return imgCarouselList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item ?? "",
                          fit: BoxFit.cover, width: 1000.0),
                    ],
                  )),
            ),
          ))
      .toList();
}
