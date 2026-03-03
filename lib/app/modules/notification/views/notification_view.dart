import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_notification.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary3Color,
        appBar: CommonWidgets.appBar(
          showColorBackButton: false,
          title: StringConstants.notifications,
        ),
        body: Obx(() {
          controller.count.value;
          return Column(
            children: [
              Expanded(child: showNotificationList()),
              if (!controller.showProgressBar.value &&
                  controller.notificationList.isEmpty)
                CommonWidgets.dataNotFound()
            ],
          );
        }));
  }

  /// Show notifications...
  Widget showNotificationList() {
    return Obx(() => controller.showProgressBar.value
        ? const Center(
            child: CircularProgressIndicator(
            color: primaryColor,
          ))
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: controller.notificationList.length,
            itemBuilder: (context, int index) {
              NotificationData item = controller.notificationList[index];
              return GestureDetector(
                onTap: () {
                  //  controller.openEventDetail(index);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: primary3Color,
                      borderRadius: BorderRadius.all(Radius.circular(12.px)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 0)),
                      ]),
                  margin: EdgeInsets.only(
                      left: 10.px, right: 10.px, top: 5.px, bottom: 5.px),
                  padding: EdgeInsets.all(10.px),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title ?? '',
                            style: MyTextStyle.titleStyle16bb,
                          ),
                          Text(
                            item.createdAt.toString().substring(0, 10) ?? '',
                            style: MyTextStyle.titleStyle12b,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.px,
                      ),
                      Text(
                        item.body ?? '',
                        style: MyTextStyle.titleStyle14b,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              );
            },
          ));
  }
}
