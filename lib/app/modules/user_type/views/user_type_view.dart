import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/common/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/image_constants.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/user_type_controller.dart';

class UserTypeView extends GetView<UserTypeController> {
  const UserTypeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        controller.count.value;
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.px),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.px,
                ),
                CommonWidgets.appIcons(
                  assetName: ImageConstants.imgSplash,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const Spacer(),
                Text(
                  StringConstants.connectingYouToTrustedHands,
                  style: MyTextStyle.titleStyle20gr,
                ),
                SizedBox(
                  height: 20.px,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            controller.changeTabIndex(0);
                          },
                          child: Container(
                            height: 145.px,
                            margin: EdgeInsets.only(right: 5.px),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.px),
                                color: controller.tabIndex.value == 0
                                    ? primaryColor
                                    : primary3Color,
                                border: Border.all(
                                    color: primaryColor, width: 2.px)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: controller.tabIndex.value == 0
                                      ? primary3Color
                                      : primaryColor,
                                  size: 25.px,
                                ),
                                SizedBox(
                                  height: 5.px,
                                ),
                                Text(
                                  StringConstants.iNeedService,
                                  style: controller.tabIndex.value == 0
                                      ? MyTextStyle.titleStyle18bw
                                      : MyTextStyle.titleStyle18gr,
                                )
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            controller.changeTabIndex(1);
                          },
                          child: Container(
                            height: 145.px,
                            margin: EdgeInsets.only(left: 5.px),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.px),
                                color: controller.tabIndex.value == 1
                                    ? primaryColor
                                    : primary3Color,
                                border: Border.all(
                                    color: primaryColor, width: 2.px)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonWidgets.appIcons(
                                    assetName: controller.tabIndex.value == 1
                                        ? IconConstants.icServicemanWhite
                                        : IconConstants.icServiceman,
                                    width: 35.px,
                                    height: 35.px),
                                SizedBox(
                                  height: 5.px,
                                ),
                                Text(
                                  StringConstants.iNeedWork,
                                  style: controller.tabIndex.value == 1
                                      ? MyTextStyle.titleStyle18bw
                                      : MyTextStyle.titleStyle18gr,
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20.px,
                ),
                CommonWidgets.commonElevatedButton(
                    onPressed: () {
                      controller.clickOnNextButton();
                    },
                    child: Text(
                      StringConstants.next,
                      style: MyTextStyle.titleStyle16bw,
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }
}
