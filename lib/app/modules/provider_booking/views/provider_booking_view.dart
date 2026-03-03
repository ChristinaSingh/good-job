import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/apis/api_models/get_booking_request_model.dart';
import '../../../data/constants/icons_constant.dart';
import '../../../data/constants/string_constants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/provider_booking_controller.dart';

class ProviderBookingView extends GetView<ProviderBookingController> {
  const ProviderBookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonWidgets.appBar(
            title: StringConstants.booking, wantBackButton: false),
        body: Obx(() {
          controller.count.value;
          return CommonWidgets.customProgressBar(
            inAsyncCall: controller.inAsyncCall.value,
            child: Padding(
              padding: EdgeInsets.all(10.0.px),
              child: Column(
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 0;
                                },
                                child: Text(
                                  StringConstants.upComing,
                                  style: controller.tabIndex.value == 0
                                      ? MyTextStyle.titleStyle12gr
                                      : MyTextStyle.titleStyleCustom(
                                          12, FontWeight.w400, Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 10.px,
                              ),
                              Container(
                                height: controller.tabIndex.value == 0 ? 3 : 2,
                                decoration: BoxDecoration(
                                  color: controller.tabIndex.value == 0
                                      ? primaryColor
                                      : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 1;
                                },
                                child: Text(
                                  StringConstants.completed,
                                  style: controller.tabIndex.value == 1
                                      ? MyTextStyle.titleStyle12gr
                                      : MyTextStyle.titleStyleCustom(
                                          12, FontWeight.w400, Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 10.px,
                              ),
                              Container(
                                height: controller.tabIndex.value == 1 ? 3 : 2,
                                decoration: BoxDecoration(
                                  color: controller.tabIndex.value == 1
                                      ? primaryColor
                                      : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 2;
                                },
                                child: Text(
                                  StringConstants.cancelled,
                                  style: controller.tabIndex.value == 2
                                      ? MyTextStyle.titleStyle12gr
                                      : MyTextStyle.titleStyleCustom(
                                          12, FontWeight.w400, Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 10.px,
                              ),
                              Container(
                                height: controller.tabIndex.value == 2 ? 3 : 2,
                                decoration: BoxDecoration(
                                  color: controller.tabIndex.value == 2
                                      ? primaryColor
                                      : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: showTabs(),
                  ))
                ],
              ),
            ),
          );
        }));
  }

  Widget showTabs() {
    switch (controller.tabIndex.value) {
      case 0:
        return (!controller.inAsyncCall.value &&
                controller.processingBooking.isEmpty)
            ? CommonWidgets.dataNotFound()
            : showUpcomingServices();
      case 1:
        return (!controller.inAsyncCall.value &&
                controller.completeBooking.isEmpty)
            ? CommonWidgets.dataNotFound()
            : showCompleteServices();
      case 2:
        return (!controller.inAsyncCall.value &&
                controller.rejectBooking.isEmpty)
            ? CommonWidgets.dataNotFound()
            : showCancelServices();

      default:
        return showUpcomingServices();
    }
  }

  Widget showUpcomingServices() {
    return ListView.builder(
      itemCount: controller.processingBooking.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        BookingRequestData item = controller.processingBooking[index];
        return GestureDetector(
          onTap: () {
            controller.clickOnProject(index);
            // controller.clickOnProject(index);
            // if (item.bookingRequestStatus == "INPROGRESS") {
            //   Get.toNamed(Routes.PROVIDER_WORKING_PROCESS, arguments: item);
            // } else {
            //   controller.clickOnProject(index);
            // }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.px),
            ),
            elevation: 2.px,
            color: primary3Color,
            margin: EdgeInsets.all(5.px),
            child: Container(
              padding: EdgeInsets.all(10.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CommonWidgets.imageView(
                        image:
                            item.image ?? StringConstants.defaultNetworkImage,
                        width: 100.px,
                        height: 100.px,
                        borderRadius: 10.px,
                        defaultNetworkImage:
                            StringConstants.defaultNetworkImage,
                      ),
                      SizedBox(width: 5.px),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? '',
                              style: MyTextStyle.titleStyle20gr,
                            ),
                            SizedBox(height: 5.px),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 20.px,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 5.px),
                                Expanded(
                                  child: Text(
                                    item.location ?? '',
                                    style: MyTextStyle.titleStyle12b,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.px),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      size: 20.px,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 5.px),
                                    Text(
                                      'Time: 9:30am',
                                      style: MyTextStyle.titleStyle10b,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      size: 20.px,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 5.px),
                                    Text(
                                      'Date: ${item.bookingDate}',
                                      style: MyTextStyle.titleStyle10b,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8.px),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 20.px,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 5.px),
                                Expanded(
                                  child: Text(
                                    "+91 ${item.mobile}" ?? '',
                                    style: MyTextStyle.titleStyle12b,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.px),
                            Row(
                              children: [
                                CommonWidgets.appIcons(
                                  assetName: IconConstants.icSend,
                                  height: 20.px,
                                  width: 20.px,
                                ),
                                SizedBox(width: 5.px),
                                Expanded(
                                  child: Text(
                                    'Distance to request in ${item.distance} miles',
                                    style: MyTextStyle.titleStyle12b,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.px),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.px),
                  if (item.upDown ?? false)
                    if (item.bookingRequestStatus == "INPROGRESS")
                      CommonWidgets.commonElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.PROVIDER_WORKING_PROCESS,
                              arguments: item);
                        },
                        child: Text(
                          StringConstants.workInProgress,
                          style: MyTextStyle.titleStyle16bw,
                        ),
                        buttonColor: primaryColor,
                        buttonMargin: EdgeInsets.symmetric(
                          horizontal: 5.px,
                          vertical: 10.px,
                        ),
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: CommonWidgets.commonElevatedButton(
                              onPressed: () {
                                controller.clickOnAcceptRejectButton(
                                    index, 'CANCEL');
                              },
                              child: Text(
                                StringConstants.decline,
                                style: MyTextStyle.titleStyle16bw,
                              ),
                              buttonColor: Colors.redAccent,
                              buttonMargin: EdgeInsets.symmetric(
                                horizontal: 5.px,
                                vertical: 10.px,
                              ),
                            ),
                          ),
                          Expanded(
                            child: item.bookingRequestStatus != 'ACCEPT'
                                ? CommonWidgets.commonElevatedButton(
                                    onPressed: () {
                                      controller.clickOnAcceptRejectButton(
                                          index, 'ACCEPT');
                                    },
                                    child: Text(
                                      StringConstants.accept,
                                      style: MyTextStyle.titleStyle16bw,
                                    ),
                                    buttonMargin: EdgeInsets.symmetric(
                                      horizontal: 5.px,
                                      vertical: 10.px,
                                    ),
                                  )
                                : CommonWidgets.commonElevatedButton(
                                    onPressed: () {
                                      controller.clickOnViewButton(index);
                                    },
                                    child: Text(
                                      StringConstants.directions,
                                      style: MyTextStyle.titleStyle16bw,
                                    ),
                                    buttonColor: primaryColor,
                                    buttonMargin: EdgeInsets.symmetric(
                                      horizontal: 5.px,
                                      vertical: 10.px,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                  GestureDetector(
                    onTap: () {
                      controller.changeUpDown(index);
                    },
                    child: CommonWidgets.appIcons(
                      assetName: item.upDown ?? false
                          ? IconConstants.icArrowUp
                          : IconConstants.icArrowDown,
                      height: 25.px,
                      width: 25.px,
                    ),
                  ),
                  SizedBox(height: 10.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget showCompleteServices() {
    return ListView.builder(
        itemCount: controller.completeBooking.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          BookingRequestData item = controller.completeBooking[index];
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.px)),
            elevation: 2.px,
            color: primary3Color,
            margin: EdgeInsets.all(5.px),
            child: Container(
              padding: EdgeInsets.all(10.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CommonWidgets.imageView(
                          image:
                              item.image ?? StringConstants.defaultNetworkImage,
                          width: 100.px,
                          height: 100.px,
                          borderRadius: 10.px,
                          defaultNetworkImage:
                              StringConstants.defaultNetworkImage),
                      SizedBox(
                        width: 5.px,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? '',
                              style: MyTextStyle.titleStyle20gr,
                            ),
                            SizedBox(
                              height: 5.px,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 20.px,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5.px,
                                ),
                                Expanded(
                                  child: Text(
                                    item.location ?? '',
                                    style: MyTextStyle.titleStyle12b,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.px,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      size: 20.px,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 5.px,
                                    ),
                                    Text(
                                      'Time: 9:30am',
                                      style: MyTextStyle.titleStyle10b,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      size: 20.px,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 5.px,
                                    ),
                                    Text(
                                      'Date: ${item.bookingDate}',
                                      style: MyTextStyle.titleStyle10b,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.px,
                            ),
                            Row(
                              children: [
                                CommonWidgets.appIcons(
                                    assetName: IconConstants.icSend,
                                    height: 20.px,
                                    width: 20.px),
                                SizedBox(
                                  width: 5.px,
                                ),
                                Expanded(
                                  child: Text(
                                    'Distance to request in  ${item.distance} miles ',
                                    style: MyTextStyle.titleStyle12b,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.px,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.px,
                  ),
                  if (item.upDown ?? false)
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CommonWidgets.commonElevatedButton(
                              onPressed: () {},
                              child: Text(
                                StringConstants.decline,
                                style: MyTextStyle.titleStyle16bw,
                              ),
                              buttonColor: Colors.redAccent,
                              buttonMargin: EdgeInsets.symmetric(
                                  horizontal: 5.px, vertical: 10.px)),
                        ),
                        Expanded(
                          flex: 1,
                          child: CommonWidgets.commonElevatedButton(
                              onPressed: () {},
                              child: Text(
                                StringConstants.accept,
                                style: MyTextStyle.titleStyle16bw,
                              ),
                              buttonMargin: EdgeInsets.symmetric(
                                  horizontal: 5.px, vertical: 10.px)),
                        ),
                      ],
                    ),
                  GestureDetector(
                    onTap: () {
                      controller.changeUpDown(index);
                    },
                    child: CommonWidgets.appIcons(
                        assetName: item.upDown ?? false
                            ? IconConstants.icArrowUp
                            : IconConstants.icArrowDown,
                        height: 25.px,
                        width: 25.px),
                  ),
                  SizedBox(
                    height: 10.px,
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget showCancelServices() {
    return ListView.builder(
        itemCount: controller.rejectBooking.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          BookingRequestData item = controller.rejectBooking[index];
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.px)),
            elevation: 2.px,
            color: primary3Color,
            margin: EdgeInsets.all(5.px),
            child: Container(
              padding: EdgeInsets.all(10.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CommonWidgets.imageView(
                          image:
                              item.image ?? StringConstants.defaultNetworkImage,
                          width: 100.px,
                          height: 100.px,
                          borderRadius: 10.px,
                          defaultNetworkImage:
                              StringConstants.defaultNetworkImage),
                      SizedBox(
                        width: 5.px,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? '',
                              style: MyTextStyle.titleStyle20gr,
                            ),
                            SizedBox(
                              height: 5.px,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 20.px,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5.px,
                                ),
                                Expanded(
                                  child: Text(
                                    item.location ?? '',
                                    style: MyTextStyle.titleStyle12b,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.px,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      size: 20.px,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 5.px,
                                    ),
                                    Text(
                                      'Time: 9:30am',
                                      style: MyTextStyle.titleStyle10b,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      size: 20.px,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 5.px,
                                    ),
                                    Text(
                                      'Date: ${item.bookingDate}',
                                      style: MyTextStyle.titleStyle10b,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.px,
                            ),
                            Row(
                              children: [
                                CommonWidgets.appIcons(
                                    assetName: IconConstants.icSend,
                                    height: 20.px,
                                    width: 20.px),
                                SizedBox(
                                  width: 5.px,
                                ),
                                Expanded(
                                  child: Text(
                                    'Distance to request in  ${item.distance} miles ',
                                    style: MyTextStyle.titleStyle12b,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.px,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.px,
                  ),
                  if (item.upDown ?? false)
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CommonWidgets.commonElevatedButton(
                              onPressed: () {},
                              child: Text(
                                StringConstants.decline,
                                style: MyTextStyle.titleStyle16bw,
                              ),
                              buttonColor: Colors.redAccent,
                              buttonMargin: EdgeInsets.symmetric(
                                  horizontal: 5.px, vertical: 10.px)),
                        ),
                        Expanded(
                          flex: 1,
                          child: CommonWidgets.commonElevatedButton(
                              onPressed: () {},
                              child: Text(
                                StringConstants.accept,
                                style: MyTextStyle.titleStyle16bw,
                              ),
                              buttonMargin: EdgeInsets.symmetric(
                                  horizontal: 5.px, vertical: 10.px)),
                        ),
                      ],
                    ),
                  GestureDetector(
                    onTap: () {
                      controller.changeUpDown(index);
                    },
                    child: CommonWidgets.appIcons(
                        assetName: item.upDown ?? false
                            ? IconConstants.icArrowUp
                            : IconConstants.icArrowDown,
                        height: 25.px,
                        width: 25.px),
                  ),
                  SizedBox(
                    height: 10.px,
                  )
                ],
              ),
            ),
          );
        });
  }
}
