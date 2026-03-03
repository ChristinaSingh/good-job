import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/provider_working_process_controller.dart';

class ProviderWorkingProcessView
    extends GetView<ProviderWorkingProcessController> {
  const ProviderWorkingProcessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Scaffold(

          backgroundColor: primary3Color,
          appBar: CommonWidgets.appBar(title: "",

          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CommonWidgets.commonElevatedButton(
              onPressed: () {
                controller.clickOnCollectAmountButton();
              },
              child: Text(
                'Click to complete booking request ',
                style: MyTextStyle.titleStyle16bw,
                textAlign: TextAlign.center,
              ),
              buttonColor: primaryColor,
              showLoading: controller.inAsyncCall.value,
              buttonMargin:
                  EdgeInsets.symmetric(horizontal: 5.px, vertical: 10.px)),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 5.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 230.px,
                    width: 230.px,
                    padding: EdgeInsets.all(25.px),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(115.px),
                        color: primaryColor.withOpacity(0.4)),
                    child: Container(
                      height: 180.px,
                      width: 180.px,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90.px),
                          color: primaryColor),
                      child: CommonWidgets.imageView(
                          image: controller.bookingData.image ??
                              StringConstants.defaultNetworkImage,
                          height: 80.px,
                          width: 80.px,
                          defaultNetworkImage:
                              StringConstants.defaultNetworkImage,
                          borderRadius: 40.px),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.px,
                ),
                Text(
                  StringConstants.services,
                  style: MyTextStyle.titleStyle16bb,
                ),
                SizedBox(
                  height: 3.px,
                ),
                Text(
                  controller.bookingData.serviceName ?? '',
                  style: MyTextStyle.titleStyle14gr,
                ),
                SizedBox(
                  height: 3.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${controller.bookingData.amount}.00',
                      style: MyTextStyle.titleStyle16gr,
                    ),
                    Text(
                      '01',
                      style: MyTextStyle.titleStyle14gr,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.px,
                ),
                Text(
                  StringConstants.payment,
                  style: MyTextStyle.titleStyle16bb,
                ),
                SizedBox(
                  height: 3.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service Charge',
                      style: MyTextStyle.titleStyle14gr,
                    ),
                    Text(
                      '\$${controller.bookingData.amount}.00',
                      style: MyTextStyle.titleStyle14gr,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub Total',
                      style: MyTextStyle.titleStyle14gr,
                    ),
                    Text(
                      '\$00.00',
                      style: MyTextStyle.titleStyle14gr,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringConstants.total,
                      style: MyTextStyle.titleStyle16bb,
                    ),
                    Text(
                      '\$${controller.bookingData.amount}.00',
                      style: MyTextStyle.titleStyle14gr,
                    ),
                  ],
                ),
              ],
            ),
          ));
    });
  }
}
