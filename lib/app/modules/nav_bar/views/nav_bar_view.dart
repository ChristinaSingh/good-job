import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/icons_constant.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/nav_bar_controller.dart';

class NavBarView extends GetView<NavBarController> {
  const NavBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: controller.body(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 8.px),
              child: GNav(
                padding: EdgeInsets.symmetric(horizontal: 2.px, vertical: 4.px),
                tabs: [
                  button(
                      selectImage: IconConstants.icHomeFill,
                      image: IconConstants.icHome,
                      text: StringConstants.home,
                      index: 0),
                  button(
                      selectImage: IconConstants.icBookingFill,
                      image: IconConstants.icBooking,
                      text: StringConstants.booking,
                      index: 1),
                  button(
                      selectImage: IconConstants.icCircleLocation,
                      image: IconConstants.icCircleLocation,
                      text: "",
                      index: 2),
                  button(
                      selectImage: IconConstants.icChatFill,
                      image: IconConstants.icChat,
                      text: StringConstants.chat,
                      index: 3),
                  button(
                      selectImage: IconConstants.icProfileFill,
                      image: IconConstants.icProfile,
                      text: StringConstants.profile,
                      index: 4),
                ],
                selectedIndex: selectedIndex.value,
                onTabChange: (index) {
                  selectedIndex.value = index;
                  controller.increment();
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  button({
    required String selectImage,
    required String image,
    required String text,
    required int index,
  }) {
    return GButton(
      icon: Icons.add,
      leading: Column(
        children: [
          CommonWidgets.appIcons(
              assetName: selectedIndex.value == index ? selectImage : image,
              width: index == 2 ? 50.px : 24.px,
              height: index == 2 ? 50.px : 24.px,
              fit: BoxFit.fill),
          if (index != 2)
            Text(
              text,
              style: selectedIndex.value == index
                  ? MyTextStyle.titleStyle12gr
                  : MyTextStyle.titleStyle12b,
            )
        ],
      ),
    );
  }
}
