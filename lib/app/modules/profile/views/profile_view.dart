import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // This forces Obx to rebuild when count changes
        controller.count.value;

        return CommonWidgets.customProgressBar(
          inAsyncCall: controller.inAsyncCall.value,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.px),

                  // Reactive user details
                  if (controller.userDetails.value != null)
                    Column(
                      children: [
                        Container(
                          width: 152.px,
                          height: 152.px,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(76.px),
                            border:
                                Border.all(color: primaryColor, width: 2.px),
                          ),
                          child: CommonWidgets.imageView(
                            image:
                                controller.userDetails.value!.userData!.image ??
                                    StringConstants.defaultNetworkImage,
                            width: 150.px,
                            height: 150.px,
                            defaultNetworkImage:
                                StringConstants.defaultNetworkImage,
                            borderRadius: 75.px,
                          ),
                        ),
                        SizedBox(height: 5.px),
                        Text(
                          controller.userDetails.value!.userData!.userName ??
                              '',
                          style: MyTextStyle.titleStyle18bb,
                        ),
                      ],
                    ),

                  SizedBox(height: 5.px),

                  // List of items
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
                          assetName: controller.itemList[index]['image'] ?? '',
                          height: 40.px,
                          width: 40.px,
                        ),
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
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
