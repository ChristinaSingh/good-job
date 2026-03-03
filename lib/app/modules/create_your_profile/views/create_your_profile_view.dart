import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../../../data/constants/icons_constant.dart';
import '../controllers/create_your_profile_controller.dart';

class CreateYourProfileView extends GetView<CreateYourProfileController> {
  const CreateYourProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonWidgets.appBar(title: ''),
        body: Obx(() {
          controller.count.value;
          return CommonWidgets.customProgressBar(
            inAsyncCall: controller.inAsyncCall.value,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.px, vertical: 5.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringConstants.completeYourProfile,
                      style: MyTextStyle.titleStyle24bb,
                    ),
                    Text(
                      StringConstants.weWillSendYouAnEmailToVerifyYourEmail,
                      style: MyTextStyle.titleStyle16b,
                    ),
                    SizedBox(height: 10.px),
                    CommonWidgets.commonTextFieldForLoginSignUP(
                        focusNode: controller.focusFullName,
                        hintText: StringConstants.fullName,
                        controller: controller.fullNameController,
                        isCard: controller.isFullName.value,
                        hintStyle: MyTextStyle.titleStyle14b,
                        style: MyTextStyle.titleStyle14bb),
                    SizedBox(height: 10.px),
                    CommonWidgets.commonTextFieldForLoginSignUP(
                        focusNode: controller.focusPhone,
                        hintText: StringConstants.phoneNumber,
                        controller: controller.phoneController,
                        isCard: controller.isPhone.value,
                        hintStyle: MyTextStyle.titleStyle14b,
                        keyboardType: TextInputType.phone,
                        style: MyTextStyle.titleStyle14bb,
                        readOnly: true),
                    SizedBox(height: 10.px),
                    CommonWidgets.commonTextFieldForLoginSignUP(
                        focusNode: controller.focusEmail,
                        hintText: StringConstants.email,
                        controller: controller.emailController,
                        isCard: controller.isEmail.value,
                        keyboardType: TextInputType.emailAddress,
                        hintStyle: MyTextStyle.titleStyle14b,
                        style: MyTextStyle.titleStyle14bb),
                    SizedBox(height: 10.px),
                    CommonWidgets.commonTextFieldForLoginSignUP(
                        focusNode: controller.focusJobRole,
                        hintText: StringConstants.jobRole,
                        controller: controller.jobRoleController,
                        isCard: controller.isJobRole.value,
                        hintStyle: MyTextStyle.titleStyle14b,
                        style: MyTextStyle.titleStyle14bb,
                        readOnly: true,
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20.px,
                          color: Colors.black54,
                        ),
                        onTap: () {
                          controller.selectJobsRoles();
                        }),
                    SizedBox(height: 10.px),
                    CommonWidgets.commonTextFieldForLoginSignUP(
                        focusNode: controller.focusCharge,
                        hintText: StringConstants.chargePerHour,
                        controller: controller.chargeController,
                        isCard: controller.isCharge.value,
                        hintStyle: MyTextStyle.titleStyle14b,
                        keyboardType: TextInputType.number,
                        style: MyTextStyle.titleStyle14bb),
                    SizedBox(height: 10.px),
                    CommonWidgets.commonTextFieldForLoginSignUP(
                        focusNode: controller.focusQualification,
                        hintText: StringConstants.specialQualification,
                        controller: controller.specialQualificationController,
                        isCard: controller.isQualification.value,
                        hintStyle: MyTextStyle.titleStyle14b,
                        style: MyTextStyle.titleStyle14bb),
                    SizedBox(height: 10.px),
                    CommonWidgets.commonTextFieldForLoginSignUP(
                        focusNode: controller.focusLocation,
                        hintText: StringConstants.location,
                        controller: controller.locationController,
                        isCard: controller.isLocation.value,
                        hintStyle: MyTextStyle.titleStyle14b,
                        style: MyTextStyle.titleStyle14bb,
                        readOnly: true,
                        onTap: () {
                          controller.clickOnAllLocationsTextField();
                        }),
                    SizedBox(height: 10.px),
                    CommonWidgets.commonTextFieldForLoginSignUP(
                        focusNode: controller.focusDescription,
                        hintText: StringConstants.description,
                        controller: controller.descriptionController,
                        isCard: controller.isDescription.value,
                        hintStyle: MyTextStyle.titleStyle14b,
                        style: MyTextStyle.titleStyle14bb,
                        maxLines: 6),
                    SizedBox(height: 10.px),
                    Text(
                      StringConstants.goodJobHighlyExpectedExpectedThe,
                      style: MyTextStyle.titleStyle18bb,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.attributesList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              controller.attributesList[index],
                              style: MyTextStyle.titleStyle16b,
                            ),
                            trailing: Checkbox(
                                value: controller.checkValue.value == index,
                                onChanged: (value) {
                                  if (value ?? false) {
                                    controller.checkValue.value = index;
                                  } else {
                                    controller.checkValue.value = 0;
                                  }
                                  controller.increment();
                                }),
                          );
                        }),
                    Text(
                      StringConstants.photo,
                      style: MyTextStyle.titleStyle20bb,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5.px,
                    ),
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10.px,
                          crossAxisSpacing: 10.px,
                          childAspectRatio: 1.0,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
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
                                              height: 75.px,
                                              width: 75.px,
                                              fit: BoxFit.fill),
                                        )
                                      : const SizedBox(),
                                  Center(
                                    child: CommonWidgets.appIcons(
                                        assetName: IconConstants.icAdd,
                                        height: 25.px,
                                        width: 25.px),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20.px,
                    ),
                    CommonWidgets.commonElevatedButton(
                        onPressed: () {
                          controller.clickOnSubmitButton();
                        },
                        child: Text(
                          StringConstants.save,
                          style: MyTextStyle.titleStyle18bw,
                        )),
                    SizedBox(
                      height: 20.px,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
