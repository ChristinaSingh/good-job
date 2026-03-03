import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_conversation_model.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/constants/icons_constant.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      controller.count.value;
      return SafeArea(
        child: CommonWidgets.customProgressBar(
          inAsyncCall: controller.isAsyncCall.value,
          child: Column(
            children: [
              SizedBox(
                height: 10.px,
              ),
              Text(
                StringConstants.message,
                style: MyTextStyle.titleStyle20bb,
              ),
              SizedBox(
                height: 10.px,
              ),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.px),
                  ),
                  margin: EdgeInsets.only(left: 10.px, right: 10.px),
                  child: CommonWidgets.commonTextFieldForLoginSignUP(
                    controller: controller.searchController,
                    hintText: StringConstants.search.tr,
                    borderRadius: 10.px,
                    onChanged: (value) {
                      controller.changeFilterUsersList(value);
                    },
                    prefixIcon: CommonWidgets.appIcons(
                        assetName: IconConstants.icSearch,
                        height: 25.px,
                        width: 25.px),
                  )),
            SizedBox(height: 20.px,),
            Expanded(child: showUsersView()),
              if (!controller.isLoading.value &&
                  controller.filterUserList.isEmpty)
                CommonWidgets.dataNotFound()
            ],
          ),
        ),
      );
    }));
  }

  Widget showUsersView() {
    return GetBuilder<ChatController>(builder: (controller) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 5.px),
        itemCount: controller.filterUserList.length,
        itemBuilder: (context, index) {
          ConversationResult item = controller.filterUserList[index];

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.px),
            child: InkWell(
              onTap: () => controller.clickOnUser(index),
              borderRadius: BorderRadius.circular(10.px),
              child: Card(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.px),
                ),
                margin: EdgeInsets.zero,
                child: Container(
                  color: Color(0xffF9FBFF),
                  padding: EdgeInsets.all(8.px),
                  child: Row(
                    children: [
                      CommonWidgets.imageView(
                        image: item.image ?? StringConstants.defaultNetworkImage,
                        height: 55.px,
                        width: 55.px,
                        defaultNetworkImage: StringConstants.defaultNetworkImage,
                        borderRadius: 28.px,
                      ),
                      SizedBox(width: 10.px),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.userName ?? '',
                              style: MyTextStyle.titleStyle16bb,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3.px),
                            Text(
                              item.lastMessage ?? '',
                              style: MyTextStyle.titleStyle14b,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item.createdAt.toString().substring(0, 10),
                            style: MyTextStyle.titleStyle10b,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5.px),
                          if (item.unseenCount != '0')
                            Container(
                              height: 20.px,
                              width: 20.px,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor,
                              ),
                              child: Text(
                                item.unseenCount ?? '',
                                style: MyTextStyle.titleStyle12w,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

}
