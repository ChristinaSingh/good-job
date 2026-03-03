import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonWidgets.appBar(title: StringConstants.contactUs),
        body: CommonWidgets.customProgressBar(
          inAsyncCall: controller.inAsyncCall.value,
          child: Padding(
            padding: EdgeInsets.all(16.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.contactInfoResult != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CommonWidgets.appIcons(
                          assetName: IconConstants.icPhoneCircle,
                          height: 50.px,
                          width: 50.px,
                        ),
                        title: Text(
                          StringConstants.contactNumber,
                          style: MyTextStyle.titleStyle12b,
                        ),
                        subtitle: Text(
                          '86426984265',
                          style: MyTextStyle.titleStyle14bb,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CommonWidgets.appIcons(
                          assetName: IconConstants.icEmailCircle,
                          height: 50.px,
                          width: 50.px,
                        ),
                        title: Text(
                          StringConstants.email,
                          style: MyTextStyle.titleStyle12b,
                        ),
                        subtitle: Text(
                          'goodjoblk@gmail.com',
                          style: MyTextStyle.titleStyle14bb,
                        ),
                      ),
                      Divider(),

                      // Divider(),
                      // ListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   leading: CommonWidgets.appIcons(
                      //     assetName: IconConstants.icLocationCircle,
                      //     height: 50.px,
                      //     width: 50.px,
                      //   ),
                      //   title: Text(
                      //     StringConstants.address,
                      //     style: MyTextStyle.titleStyle12b,
                      //   ),
                      //   subtitle: Text(
                      //     'Indore, 456010, Madhya Pradesh, India',
                      //     style: MyTextStyle.titleStyle14bb,
                      //   ),
                      // ),
                    ],
                  )
                else
                  Padding(
                    padding: EdgeInsets.only(top: 10.px),
                    child: Text(
                      "No contact information available.",
                      style: MyTextStyle.titleStyle14b,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
