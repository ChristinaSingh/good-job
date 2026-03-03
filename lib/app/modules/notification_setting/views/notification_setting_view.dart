import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/text_styles.dart';
import '../controllers/notification_setting_controller.dart';

class NotificationSettingView extends GetView<NotificationSettingController> {
  const NotificationSettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonWidgets.appBar(title: StringConstants.notifications),
        body: Obx(() {
          controller.count.value;
          return Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(10.px),
                  itemCount: controller.notificationList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(left: 5.px, right: 5.px),
                      title: Text(
                        controller.notificationList[index]['title'],
                        style: MyTextStyle.titleStyle16bb,
                      ),
                      trailing: CupertinoSwitch(
                        value: controller.notificationList[index][
                            'status'], // Boolean value indicating the current state of the switch
                        onChanged: (bool value) {
                          controller.changeSelectIndex(value, index);
                        },
                        activeColor: Colors.black87,
                      ),
                    );
                  }),
              const Spacer(),
              CommonWidgets.commonElevatedButton(
                  onPressed: () {
                    if (controller.userDetails?.userData?.type == "USER") {
                      controller.callingNotificationApi();
                    } else {
                      controller.callingNotificationProvider();
                    }
                  },
                  child: Text(
                    StringConstants.save,
                    style: MyTextStyle.titleStyle18bw,
                  ),
                  showLoading: controller.inAsyncCall.value,
                  buttonMargin: EdgeInsets.all(10.px))
            ],
          );
        }));
  }
}
