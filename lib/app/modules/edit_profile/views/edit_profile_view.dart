import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  // Custom widget for the Gender Dropdown, styled to perfectly match other fields
  Widget genderDropdown() {
    return Obx(
          () => Container(
        // This Box Decoration replicates the background, rounded corners, and crucial border/shadow.
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.px),
          border: Border.all(
            color: Colors.grey,
            width: 1.px,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          // Inner horizontal padding to align the text with the other text fields
          padding: EdgeInsets.symmetric(horizontal: 10.px),
          child: DropdownButtonFormField<String>(

            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 14.px),
              hintText: StringConstants.gender,
              hintStyle: MyTextStyle.titleStyle14b,
            ),
            isExpanded: true,
            value: controller.selectedGender.value,
            style: MyTextStyle.titleStyle14bb,

            items: controller.genderOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),

            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.selectedGender.value = newValue;
              }
            },

            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade600,
              size: 24.px,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The rest of the build method remains the same, using the new genderDropdown()
    return Obx(() {
      controller.count.value;
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CommonWidgets.appBar(title: StringConstants.profile),
          bottomNavigationBar: CommonWidgets.commonElevatedButton(
              onPressed: () {
                controller.callingUpdateProfile();
              },
              child: Text(
                StringConstants.update,
                style: MyTextStyle.titleStyle16bw,
              ),
              showLoading: controller.isLoading.value,
              buttonMargin:
              EdgeInsets.only(left: 20.px, right: 20.px, bottom: 10.px)),
          body: Padding(
            padding: EdgeInsets.all(10.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- Profile Image ---
                Container(
                  padding: EdgeInsets.all(2.px),
                  decoration: CommonWidgets.kGradientBoxDecoration(
                      showGradientBorder: true, borderRadius: 66.px),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Obx(
                            () => controller.selectImage.value != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(65.px),
                          child: Image.file(
                            height: 130.px,
                            width: 130.px,
                            fit: BoxFit.fill,
                            File(
                              controller.selectImage.value!.path
                                  .toString(),
                            ),
                          ),
                        )
                            : CommonWidgets.imageView(
                            image: controller.profileImage.value,
                            height: 130.px,
                            width: 130.px,
                            fit: BoxFit.fill,
                            borderRadius: 65.px,
                            defaultNetworkImage:
                            StringConstants.defaultNetworkImage),
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.showAlertDialog();
                          },
                          child: CommonWidgets.appIcons(
                              assetName: IconConstants.icCamera,
                              height: 35.px,
                              width: 35.px))
                    ],
                  ),
                ),
                SizedBox(height: 10.px),
                // --- Full Name Text Field ---
                CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusFullName,
                    hintText: StringConstants.fullName,
                    controller: controller.fullNameController,
                    isCard: controller.isFullName.value,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb),
                SizedBox(height: 10.px),
                // --- Email Text Field ---
                CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusEmail,
                    hintText: StringConstants.email,
                    controller: controller.emailController,
                    isCard: controller.isEmail.value,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb),
                SizedBox(height: 10.px),
                // --- Phone Number Text Field ---
                CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusPhone,
                    hintText: StringConstants.phoneNumber,
                    controller: controller.phoneController,
                    isCard: controller.isPhone.value,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb,
                    readOnly: true),
                SizedBox(height: 10.px),
                // --- GENDER DROPDOWN (UI MATCHED) ---
                genderDropdown(),
              ],
            ),
          ));
    });
  }
}