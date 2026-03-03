import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/local_data.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        controller.count.value;
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 3.px),
            child: Column(
              children: [
                // 🔹 Location Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_rounded,
                        size: 25.px, color: primaryColor),
                    SizedBox(width: 5.px),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(StringConstants.currentLocation,
                                style: MyTextStyle.titleStyle12b),
                            SizedBox(width: 5.px),
                            Icon(Icons.keyboard_arrow_down_outlined,
                                size: 20.px, color: primaryColor)
                          ],
                        ),
                        Text('${LocalData.address} ',
                            style: MyTextStyle.titleStyle16bb),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        controller.clickOnNotification();
                      },
                      child: CommonWidgets.appIcons(
                        assetName: IconConstants.icNotification,
                        height: 50.px,
                        width: 50.px,
                      ),
                    ),
                  ],
                ),

                // 🔹 Search Bar
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.px),
                  ),
                  color: const Color(0xFFEBEEED),
                  elevation: 2.px,
                  child: Container(
                    height: 55.px,
                    padding: EdgeInsets.only(left: 10.px),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CommonWidgets.appIcons(
                          assetName: IconConstants.icSearch,
                          height: 25.px,
                          width: 25.px,
                        ),
                        SizedBox(width: 5.px),
                        Text(StringConstants.search,
                            style: MyTextStyle.titleStyle16b),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.px),

                // 🔹 Carousel Banner
                CarouselSlider(
                  items: List.generate(
                    controller.bannerData.length,
                    (index) => Stack(
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: CommonWidgets.appIcons(
                            borderRadius: 20.px,
                            width: double.infinity,
                            height: 150.px,
                            assetName:
                                controller.bannerData[index]['image'] ?? '',
                          ),
                        ),
                        Positioned(
                          left: 10.px,
                          top: 20.px,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.bannerData[index]['title'] ?? '',
                                  style: MyTextStyle.titleStyle24bw),
                              Text(
                                  controller.bannerData[index]['description'] ??
                                      '',
                                  style: MyTextStyle.titleStyle16w),
                              GestureDetector(
                                onTap: () {
                                  controller.clickOnServiceItem(
                                      controller.bannerData[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.px, vertical: 6.px),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.px),
                                    color: primaryColor,
                                  ),
                                  child: Text(StringConstants.bookNow,
                                      style: MyTextStyle.titleStyle16w),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  options: CarouselOptions(
                    height: 150.px,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1200),
                    autoPlayCurve: Curves.easeIn,
                    onPageChanged: (index, reason) {
                      controller.cardIndex.value = index;
                    },
                  ),
                ),

                // 🔹 Carousel Indicator
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.px, horizontal: 16.px),
                  padding: EdgeInsets.all(4.px),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(.4.px),
                    borderRadius: BorderRadius.circular(12.px),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.bannerData.length,
                      (index) => Padding(
                        padding: EdgeInsets.all(2.px),
                        child: Container(
                          width: 8.px,
                          height: 8.px,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.px),
                            color: controller.cardIndex.value == index
                                ? primaryColor
                                : primaryColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // 🔹 AVAILABLE SERVICES
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Available Services",
                      style: MyTextStyle.titleStyle16bb),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: LocalData.categoryList
                      .where((e) =>
                          e['service_name'] == 'Plumber' ||
                          e['service_name'] == 'Electrician')
                      .length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 120 / 140,
                    mainAxisSpacing: 1.px,
                    crossAxisSpacing: 1.px,
                  ),
                  itemBuilder: (context, index) {
                    final available = LocalData.categoryList
                        .where((e) =>
                            e['service_name'] == 'Plumber' ||
                            e['service_name'] == 'Electrician')
                        .toList();
                    final item = available[index];
                    return GestureDetector(
                      onTap: () => controller.clickOnServiceItem(item),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.px)),
                        elevation: 5.px,
                        color: primary3Color,
                        child: SizedBox(
                          width: 120.px,
                          height: 140,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonWidgets.imageView(
                                image: item['ser_image'] ?? '',
                                width: 60.px,
                                height: 60.px,
                              ),
                              Text(
                                item['service_name'] ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20.px),

                // 🔹 COMING SOON
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Coming Soon", style: MyTextStyle.titleStyle16bb),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: LocalData.categoryList
                      .where((e) =>
                          e['service_name'] != 'Plumber' &&
                          e['service_name'] != 'Electrician')
                      .length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 120 / 140,
                    mainAxisSpacing: 1.px,
                    crossAxisSpacing: 1.px,
                  ),
                  itemBuilder: (context, index) {
                    final comingSoon = LocalData.categoryList
                        .where((e) =>
                            e['service_name'] != 'Plumber' &&
                            e['service_name'] != 'Electrician')
                        .toList();
                    final item = comingSoon[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.px)),
                      elevation: 3.px,
                      color: Colors.white,
                      child: SizedBox(
                        width: 120.px,
                        height: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidgets.imageView(
                              image: item['ser_image'] ?? '',
                              width: 60.px,
                              height: 60.px,
                            ),
                            Text(
                              item['service_name'] ?? '',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Coming Soon",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
