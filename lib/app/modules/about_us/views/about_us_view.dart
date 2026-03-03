import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../data/constants/image_constants.dart';
import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBar(title: StringConstants.aboutUs),
      body: Obx(() {
        controller.count.value;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 5.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CommonWidgets.appIcons(
                      assetName: ImageConstants.imgLogo,
                      height: 140.px,
                      width: 170.px),
                ),
                SizedBox(
                  height: 30.px,
                ),
                controller.inAsyncCall.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: primaryColor,
                      ))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstants.aboutUs,
                            style: MyTextStyle.titleStyle20bb,
                          ),
                          Text(
                            stripHtmlIfNeeded(
                              controller.privacyPolicyResult!.isNotEmpty
                                  ? '${controller.privacyPolicyResult![0].description}'
                                  : '',
                            ),
                            style: MyTextStyle.titleStyle14b,
                            textAlign: TextAlign.justify,
                          )
                        ],
                      )
              ],
            ),
          ),
        );
      }),
    );
  }

  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
}
