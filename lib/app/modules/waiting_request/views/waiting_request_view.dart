import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/app/data/constants/image_constants.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/waiting_request_controller.dart';

class WaitingRequestView extends GetView<WaitingRequestController> {
  const WaitingRequestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        controller.count.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.8,
              child: CommonWidgets.appIcons(
                assetName: ImageConstants.imgWaitingBackground,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            CommonWidgets.appIcons(
              assetName: ImageConstants.imgWaitingLogo,
              width: 250.px,
              height: 250.px,
            ),
            Positioned(
                left: 20.px,
                top: 40.px,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CommonWidgets.appIcons(
                      assetName: IconConstants.icBack,
                      width: 36.px,
                      height: 36.px),
                )),
            Positioned(
                bottom: 10.px,
                right: 10.px,
                left: 10.px,
                child: CommonWidgets.commonElevatedButton(
                  onPressed: () {},
                  child: Text(
                    StringConstants.continueText,
                    style: MyTextStyle.titleStyle16bw,
                  ),
                ))
          ],
        );
      }),
    );
  }
}
