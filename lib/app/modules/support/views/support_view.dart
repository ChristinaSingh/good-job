import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/image_constants.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/text_styles.dart';
import '../controllers/support_controller.dart';

class SupportView extends GetView<SupportController> {
  const SupportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CommonWidgets.appBar(title: StringConstants.support),
        body: Obx(() {
          controller.count.value;
          return Padding(
            padding: EdgeInsets.all(15.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringConstants.howCanWeHelp,
                  style: MyTextStyle.titleStyle14bb,
                ),
                CommonWidgets.commonTextFieldForLoginSignUP(
                    hintText: StringConstants.message,
                    controller: controller.messageController,
                    isCard: true,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb,
                    maxLines: 7),
                SizedBox(
                  height: 50.px,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CommonWidgets.appIcons(
                      assetName: ImageConstants.imgLogo,
                      height: 245.px,
                      width: 310.px),
                ),
                const Spacer(),
                CommonWidgets.commonElevatedButton(
                    onPressed: () {
                      if (controller.messageController.text.isNotEmpty) {
                        controller.submitMessageButton();
                      } else {
                        CommonWidgets.showMyToastMessage(
                            'Please enter message ...');
                      }
                    },
                    child: Text(
                      StringConstants.submit,
                      style: MyTextStyle.titleStyle16bw,
                    ),
                    showLoading: controller.isLoading.value)
              ],
            ),
          );
        }));
  }
}
