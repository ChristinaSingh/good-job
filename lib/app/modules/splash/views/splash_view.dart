import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/constants/image_constants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        controller.count.value;
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.px,
              ),
              Align(
                alignment: Alignment.center,
                child: CommonWidgets.appIcons(
                  assetName: ImageConstants.imgSplash,
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: 300.px,
                ),
              ),
              SizedBox(
                height: 30.px,
              ),
              Text(
                StringConstants.hello,
                style: MyTextStyle.titleStyle30gr,
              )
            ],
          ),
        );
      }),
    );
  }
}
