import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/data/constants/image_constants.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/add_review_controller.dart';

class AddReviewView extends GetView<AddReviewController> {
  const AddReviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonWidgets.appBar(),
        body: Obx(() {
          controller.count.value;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.px,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CommonWidgets.appIcons(
                        assetName: ImageConstants.imgBackgroundReview,
                        width: 280.px,
                        height: 280.px),
                    Positioned(
                        child: CommonWidgets.imageView(
                            image: controller.parameter[ApiKeyConstants.name] ??
                                StringConstants.defaultNetworkImage,
                            height: 192.px,
                            width: 192.px,
                            borderRadius: 96.px,
                            defaultNetworkImage:
                                StringConstants.defaultNetworkImage))
                  ],
                ),
                SizedBox(
                  height: 20.px,
                ),
                Text(
                  'Hows the job done by ${controller.parameter[ApiKeyConstants.name]}?',
                  style: MyTextStyle.titleStyle16bb,
                ),
                SizedBox(
                  height: 10.px,
                ),
                RatingBar(
                    alignment: Alignment.center,
                    filledIcon: Icons.star,
                    filledColor: Colors.orangeAccent,
                    emptyIcon: Icons.star,
                    emptyColor: Colors.grey.withOpacity(0.5),
                    initialRating: controller.ratingValue.value,
                    size: 35.px,
                    maxRating: 5,
                    onRatingChanged: (value) {
                      controller.ratingValue.value = value;
                      controller.increment();
                    }),
                Padding(
                  padding: EdgeInsets.all(10.px),
                  child: CommonWidgets.commonTextFieldForLoginSignUP(
                      controller: controller.messageController,
                      hintText: 'Leave a Review',
                      hintStyle: MyTextStyle.titleStyle14b,
                      maxLines: 5),
                ),
                SizedBox(
                  height: 20.px,
                ),
                CommonWidgets.commonElevatedButton(
                    onPressed: () {
                      controller.callingAddReview();
                    },
                    buttonMargin: EdgeInsets.all(10.px),
                    child: Text(
                      StringConstants.submit,
                      style: MyTextStyle.titleStyle16bw,
                    ),
                    showLoading: controller.inAsyncCall.value)
              ],
            ),
          );
        }));
  }
}
