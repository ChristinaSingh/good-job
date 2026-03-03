import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/icons_constant.dart';
import '../controllers/provider_documernt_controller.dart';

class ProviderDocumerntView extends GetView<ProviderDocumerntController> {
  const ProviderDocumerntView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonWidgets.appBar(title: StringConstants.uploadCertificate),
        body: Obx(() {
          controller.count.value;
          return Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.imageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.px, vertical: 5.px),
                      child: GestureDetector(
                        onTap: () {
                          controller.showAlertDialog(index);
                        },
                        child: DottedBorder(
                          color: primaryColor,
                          dashPattern: const [4, 2],
                          strokeWidth: 2.px,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(14.px),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              controller.imageList[index] != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(15.px),
                                      child: Image.file(
                                          controller.imageList[index]!,
                                          height: 220.px,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.fill),
                                    )
                                  : SizedBox(
                                      height: 220.px,
                                      width: MediaQuery.of(context).size.width),
                              Center(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40.px,
                                      width: 40.px,
                                      padding: EdgeInsets.all(8.px),
                                      margin: EdgeInsets.all(10.px),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.px),
                                          color: primaryColor),
                                      child: CommonWidgets.appIcons(
                                          assetName: IconConstants.icAdd,
                                          color: primary3Color,
                                          height: 25.px,
                                          width: 25.px),
                                    ),
                                    Text(
                                      StringConstants.uploadCertificate,
                                      style: MyTextStyle.titleStyle14b,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 20.px,
              ),
              const Spacer(),
              CommonWidgets.commonElevatedButton(
                  onPressed: () {
                    controller.clickOnSubmitButton();
                  },
                  child: Text(
                    StringConstants.save,
                    style: MyTextStyle.titleStyle18bw,
                  ),
                  showLoading: controller.isLoading.value,
                  buttonMargin: EdgeInsets.all(10.px)),
            ],
          );
        }));
  }
}
