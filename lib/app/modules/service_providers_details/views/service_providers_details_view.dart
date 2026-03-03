import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_service_provider_model.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../controllers/service_providers_details_controller.dart';

class ServiceProvidersDetailsView
    extends GetView<ServiceProvidersDetailsController> {
  const ServiceProvidersDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return CommonWidgets.customProgressBar(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          bottomNavigationBar: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CommonWidgets.commonElevatedButton(
                      onPressed: () {},
                      child: Text(
                        StringConstants.message,
                        style: MyTextStyle.titleStyle16gr,
                      ),
                      borderRadius: 30.px,
                      buttonMargin: EdgeInsets.symmetric(
                          horizontal: 6.px, vertical: 3.px),
                      buttonColor: const Color(0xFFCAE0DA)),
                ),
                Expanded(
                  flex: 1,
                  child: CommonWidgets.commonElevatedButton(
                      onPressed: () {
                        controller.clickOnBookButton();
                      },
                      child: Text(
                        StringConstants.book,
                        style: MyTextStyle.titleStyle16bw,
                      ),
                      borderRadius: 30.px,
                      showLoading: controller.isLoading.value,
                      buttonMargin: EdgeInsets.symmetric(
                          horizontal: 6.px, vertical: 3.px)),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: controller.userDetails != null
                ? Column(
                    children: [
                      Stack(
                        children: [
                          CommonWidgets.imageView(
                              image:
                                  controller.userDetails!.gallery![0].image ??
                                      '',
                              height: 300.px,
                              width: MediaQuery.of(context).size.width),
                          Positioned(
                            top: 40.px,
                            left: 20.px,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: CommonWidgets.appIcons(
                                  assetName: IconConstants.icBack,
                                  height: 36.px,
                                  width: 36.px),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.px),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.px,
                            ),
                            Text(
                              controller.userDetails!.serviceName ?? '',
                              style: MyTextStyle.titleStyle24bb,
                            ),
                            SizedBox(
                              height: 10.px,
                            ),
                            Text(
                              controller.userDetails!.userName ?? '',
                              style: MyTextStyle.titleStyle20gr,
                            ),
                            SizedBox(
                              height: 5.px,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 20.px,
                                  color: primaryColor,
                                ),
                                Expanded(
                                  child: Text(
                                    controller.userDetails!.address ?? '',
                                    style: MyTextStyle.titleStyle14b,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.px,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20.px,
                                  color: primaryColor,
                                ),
                                Text(
                                  '4.8 (3.279 reviews)',
                                  style: MyTextStyle.titleStyle14b,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.px,
                            ),
                            Text(
                              '\$${controller.userDetails!.perHourCharge ?? '0'}',
                              style: MyTextStyle.titleStyle30gr,
                            ),
                            SizedBox(
                              height: 20.px,
                            ),
                            Text(
                              StringConstants.about,
                              style: MyTextStyle.titleStyle20bb,
                            ),
                            RichText(
                              text: TextSpan(
                                style: MyTextStyle.titleStyle14b,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: StringConstants.test,
                                    style: MyTextStyle.titleStyle14b,
                                  ),
                                  TextSpan(
                                    text: StringConstants.readMore,
                                    style: MyTextStyle.titleStyle14gr,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.px,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  StringConstants.gallery,
                                  style: MyTextStyle.titleStyle20bb,
                                ),
                                Text(
                                  StringConstants.seeAll,
                                  style: MyTextStyle.titleStyleCustom(
                                      12, FontWeight.w700, Colors.redAccent),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.px,
                            ),
                            SizedBox(
                              height: 120.px,
                              child: showGalleryImages(),
                            ),
                            SizedBox(
                              height: 10.px,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  StringConstants.reviews,
                                  style: MyTextStyle.titleStyle20bb,
                                ),
                                Text(
                                  StringConstants.seeAll,
                                  style: MyTextStyle.titleStyleCustom(
                                      12, FontWeight.w700, Colors.redAccent),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.px,
                            ),
                            showReviewList()
                          ],
                        ),
                      )
                    ],
                  )
                : const SizedBox(),
          ),
        ),
      );
    });
  }

  Widget showGalleryImages() {
    return ListView.builder(
        itemCount: controller.userDetails!.gallery!.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.px)),
            elevation: 2.px,
            color: primary3Color,
            margin: EdgeInsets.all(5.px),
            child: Container(
              child: CommonWidgets.imageView(
                  image: controller.userDetails!.gallery![index].image ?? '',
                  width: 120.px,
                  height: 100.px),
            ),
          );
        });
  }

  Widget showReviewList() {
    return ListView.builder(
        itemCount: controller.reviewList.length,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          Reviews item = controller.reviewList[index];
          return Column(
            children: [
              Row(
                children: [
                  CommonWidgets.imageView(
                      image: item.userData!.image ??
                          StringConstants.defaultNetworkImage,
                      width: 55.px,
                      height: 55.px,
                      borderRadius: 28.px,
                      defaultNetworkImage: StringConstants.defaultNetworkImage),
                  SizedBox(
                    width: 5.px,
                  ),
                  Text(
                    item.userData!.userName ?? '',
                    style: MyTextStyle.titleStyle16bb,
                  ),
                  const Spacer(),
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star,
                    size: 15.px,
                    filledColor: Colors.orangeAccent,
                    emptyColor: Colors.grey,
                    initialRating: double.parse(item.rating ?? '3.0'),
                    maxRating: 5,
                  )
                ],
              ),
              SizedBox(
                height: 5.px,
              ),
              Text(
                item.message ?? '',
                style: MyTextStyle.titleStyle14b,
              ),
              SizedBox(
                height: 5.px,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1.px,
              ),
              SizedBox(
                height: 10.px,
              ),
            ],
          );
        });
  }
}
