import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/image_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  const OtpVerificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          controller.count.value;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.px,
                  ),
                  Text(StringConstants.checkYourSms,
                      style: MyTextStyle.titleStyle24bb),
                  SizedBox(
                    height: 5.px,
                  ),
                  Text(
                    StringConstants.pleasePutThe4DigitCodeSendToYou,
                    style: MyTextStyle.titleStyle16b,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 20.px,
                  ),
                  CommonWidgets.commonOtpView(
                      controller: controller.pin, width: 60.px, height: 60.px),
                  SizedBox(
                    height: 50.px,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CommonWidgets.appIcons(
                        assetName: ImageConstants.imgOtpVerification,
                        height: 200.px,
                        width: 140.px),
                  ),
                  const Spacer(),
                  CommonWidgets.commonElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        controller.clickOnOtpVerificationButton();
                      },
                      child: Text(
                        StringConstants.continueText,
                        style: MyTextStyle.titleStyle20bw,
                      ),
                      showLoading: controller.showLoading.value),
                ],
              ),
            ),
          );
        }));
  }
}
