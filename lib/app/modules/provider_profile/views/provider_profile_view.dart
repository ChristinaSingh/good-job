import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/provider_profile_controller.dart';

class ProviderProfileView extends GetView<ProviderProfileController> {
  const ProviderProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        controller.count.value;
        return CommonWidgets.customProgressBar(
          inAsyncCall: controller.inAsyncCall.value,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.px,
                  ),
                  if (controller.userDetails != null)
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.px),
                          decoration: CommonWidgets.kGradientBoxDecoration(
                              showGradientBorder: true, borderRadius: 70.px),
                          child: CommonWidgets.imageView(
                              image: controller
                                      .userDetails.value?.userData?.image ??
                                  '',
                              width: 140.px,
                              height: 140.px,
                              defaultNetworkImage:
                                  StringConstants.defaultNetworkImage,
                              borderRadius: 85.px),
                        ),
                        SizedBox(
                          height: 5.px,
                        ),
                        Text(
                          controller.userDetails.value?.userData?.userName ??
                              '',
                          style: MyTextStyle.titleStyle18bb,
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 5.px,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.itemList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            controller.clickOnItem(index);
                          },
                          leading: CommonWidgets.appIcons(
                              assetName:
                                  controller.itemList[index]['image'] ?? '',
                              height: 40.px,
                              width: 40.px),
                          title: Text(
                            controller.itemList[index]['title'] ?? '',
                            style: MyTextStyle.titleStyle14bb,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20.px,
                            color: Colors.black54,
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
