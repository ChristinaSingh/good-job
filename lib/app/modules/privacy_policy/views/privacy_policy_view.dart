import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/image_constants.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBar(title: StringConstants.privacyPolicy),
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
                            StringConstants.privacyPolicy,
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
