import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common/colors.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/icons_constant.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/provider_edit_profile_controller.dart';

class ProviderEditProfileView extends GetView<ProviderEditProfileController> {
  const ProviderEditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBar(title: StringConstants.profile),
      body: Obx(() {
        controller.count.value; // To trigger rebuilds for image changes
        return CommonWidgets.customProgressBar(
          inAsyncCall: controller.inAsyncCall.value,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 5.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== PROFILE IMAGE =====
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(2.px),
                      decoration: CommonWidgets.kGradientBoxDecoration(
                        showGradientBorder: true,
                        borderRadius: 66.px,
                      ),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Obx(() => ClipRRect(
                                borderRadius: BorderRadius.circular(65.px),
                                child: controller.selectImage.value != null
                                    ? Image.file(
                                        controller.selectImage.value!,
                                        height: 130.px,
                                        width: 130.px,
                                        fit: BoxFit.fill,
                                      )
                                    : CommonWidgets.imageView(
                                        image: controller.profileImage.value,
                                        height: 130.px,
                                        width: 130.px,
                                        fit: BoxFit.fill,
                                        borderRadius: 65.px,
                                        defaultNetworkImage:
                                            StringConstants.defaultNetworkImage,
                                      ),
                              )),
                          GestureDetector(
                            onTap: () {
                              controller.showAlertDialog(-1);
                            },
                            child: CommonWidgets.appIcons(
                              assetName: IconConstants.icCamera,
                              height: 35.px,
                              width: 35.px,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.px),

                  // ===== FULL NAME =====
                  Text(StringConstants.fullName,
                      style: MyTextStyle.titleStyle14bb),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusFullName,
                    hintText: StringConstants.fullName,
                    controller: controller.fullNameController,
                    isCard: controller.isFullName.value,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb,
                  ),
                  SizedBox(height: 10.px),

                  // ===== PHONE =====
                  Text(StringConstants.phoneNumber,
                      style: MyTextStyle.titleStyle14bb),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusPhone,
                    hintText: StringConstants.phoneNumber,
                    controller: controller.phoneController,
                    isCard: controller.isPhone.value,
                    hintStyle: MyTextStyle.titleStyle14b,
                    keyboardType: TextInputType.phone,
                    style: MyTextStyle.titleStyle14bb,
                    readOnly: true,
                  ),
                  SizedBox(height: 10.px),

                  // ===== EMAIL =====
                  Text(StringConstants.email,
                      style: MyTextStyle.titleStyle14bb),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusEmail,
                    hintText: StringConstants.email,
                    controller: controller.emailController,
                    isCard: controller.isEmail.value,
                    keyboardType: TextInputType.emailAddress,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb,
                  ),
                  SizedBox(height: 10.px),

                  // ===== JOB ROLE =====
                  Text(StringConstants.jobRole,
                      style: MyTextStyle.titleStyle14bb),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusJobRole,
                    hintText: StringConstants.jobRole,
                    controller: controller.jobRoleController,
                    isCard: controller.isJobRole.value,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb,
                    readOnly: true,
                    suffixIcon: Icon(Icons.keyboard_arrow_down,
                        size: 20.px, color: Colors.black54),
                    onTap: controller.selectJobsRoles,
                  ),
                  SizedBox(height: 10.px),

                  // ===== SPECIAL QUALIFICATION =====
                  Text(StringConstants.specialQualification,
                      style: MyTextStyle.titleStyle14bb),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusQualification,
                    hintText: StringConstants.specialQualification,
                    controller: controller.specialQualificationController,
                    isCard: controller.isQualification.value,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb,
                  ),
                  SizedBox(height: 10.px),

                  // ===== LOCATION =====
                  Text(StringConstants.location,
                      style: MyTextStyle.titleStyle14bb),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusLocation,
                    hintText: StringConstants.location,
                    controller: controller.locationController,
                    isCard: controller.isLocation.value,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb,
                    readOnly: true,
                    onTap: controller.clickOnAllLocationsTextField,
                  ),
                  SizedBox(height: 10.px),

                  // ===== DESCRIPTION =====
                  Text(StringConstants.description,
                      style: MyTextStyle.titleStyle14bb),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    focusNode: controller.focusDescription,
                    hintText: StringConstants.description,
                    controller: controller.descriptionController,
                    isCard: controller.isDescription.value,
                    hintStyle: MyTextStyle.titleStyle14b,
                    style: MyTextStyle.titleStyle14bb,
                    maxLines: 6,
                  ),
                  SizedBox(height: 15.px),

                  // ===== PROFESSIONAL CERTIFICATE =====
                  Text('Professional Certificates',
                      style: MyTextStyle.titleStyle20bb),
                  SizedBox(height: 5.px),
                  // GestureDetector(
                  //   onTap: () {
                  //     controller.showAlertDialog(0, docType: 'certificate');
                  //   },
                  //   child: DottedBorder(
                  //     color: primaryColor,
                  //     dashPattern: const [4, 2],
                  //     strokeWidth: 2.px,
                  //     borderType: BorderType.RRect,
                  //     radius: Radius.circular(14.px),
                  //     child: Obx(() {
                  //       final file =
                  //           controller.selectedProfessionalCertificate.value;
                  //       final url =
                  //           controller.professionalCertificateImageUrl.value;
                  //       return Container(
                  //         height: 200.px,
                  //         width: double.infinity,
                  //         alignment: Alignment.center,
                  //         padding: EdgeInsets.symmetric(horizontal: 10.px),
                  //         child: file != null
                  //             ? ClipRRect(
                  //                 borderRadius: BorderRadius.circular(10.px),
                  //                 child: Image.file(file, fit: BoxFit.cover),
                  //               )
                  //             : (url.isNotEmpty
                  //                 ? Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.center,
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: [
                  //                       const Text("No Certificate Uploaded Yet"),
                  //                       SizedBox(
                  //                         height: 10.px,
                  //                       ),
                  //                       Container(
                  //                         height: 40.px,
                  //                         width: 40.px,
                  //                         padding: EdgeInsets.all(8.px),
                  //                         margin: EdgeInsets.all(10.px),
                  //                         decoration: BoxDecoration(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(20.px),
                  //                             color: primaryColor),
                  //                         child: CommonWidgets.appIcons(
                  //                             assetName: IconConstants.icAdd,
                  //                             color: primary3Color,
                  //                             height: 25.px,
                  //                             width: 25.px),
                  //                       ),
                  //                     ],
                  //                   )
                  //                 : Center(
                  //                     child: Text(
                  //                       'Upload Professional Certificate',
                  //                       style: MyTextStyle.titleStyle14b,
                  //                     ),
                  //                   )),
                  //       );
                  //     }),
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: () {
                      controller.showAlertDialog(0, docType: 'certificate');
                    },
                    child: DottedBorder(
                      color: primaryColor,
                      dashPattern: const [4, 2],
                      strokeWidth: 2.px,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(14.px),
                      child: Obx(() {
                        final file =
                            controller.selectedProfessionalCertificate.value;
                        final url =
                            controller.professionalCertificateImageUrl.value;
                        return Container(
                          height: 200.px,
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.px),
                          child: file != null || url.isNotEmpty
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10.px),
                                      child: file != null
                                          ? Image.file(file,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity)
                                          : Image.network(
                                              url,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                              loadingBuilder:
                                                  (context, child, progress) {
                                                if (progress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: progress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? progress
                                                                .cumulativeBytesLoaded /
                                                            progress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                    child: Text(
                                                        'Failed to load certificate',
                                                        style: MyTextStyle
                                                            .titleStyle14b));
                                              },
                                            ),
                                    ),
                                    Positioned(
                                      top: 8.px,
                                      right: 8.px,
                                      child: Container(
                                        padding: EdgeInsets.all(6.px),
                                        decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius:
                                              BorderRadius.circular(20.px),
                                        ),
                                        child: Icon(Icons.edit,
                                            color: Colors.white, size: 20.px),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("No Certificate Uploaded Yet"),
                                    SizedBox(height: 10.px),
                                    Container(
                                      height: 40.px,
                                      width: 40.px,
                                      padding: EdgeInsets.all(8.px),
                                      margin: EdgeInsets.all(10.px),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.px),
                                        color: primaryColor,
                                      ),
                                      child: CommonWidgets.appIcons(
                                        assetName: IconConstants.icAdd,
                                        color: primary3Color,
                                        height: 25.px,
                                        width: 25.px,
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 15.px),

                  // ===== ID / DRIVING LICENSE =====
                  Text('Your ID / Driving License',
                      style: MyTextStyle.titleStyle20bb),
                  SizedBox(height: 5.px),
                  // GestureDetector(
                  //   onTap: () {
                  //     controller.showAlertDialog(0, docType: 'id_license');
                  //   },
                  //   child: DottedBorder(
                  //     color: primaryColor,
                  //     dashPattern: const [4, 2],
                  //     strokeWidth: 2.px,
                  //     borderType: BorderType.RRect,
                  //     radius: Radius.circular(14.px),
                  //     child: Obx(() {
                  //       final file = controller.selectedIDLicense.value;
                  //       final url = controller.idLicenseImageUrl.value;
                  //       return Container(
                  //         height: 200.px,
                  //         width: double.infinity,
                  //         alignment: Alignment.center,
                  //         padding: EdgeInsets.symmetric(horizontal: 10.px),
                  //         child: file != null
                  //             ? ClipRRect(
                  //                 borderRadius: BorderRadius.circular(10.px),
                  //                 child: Image.file(file, fit: BoxFit.cover),
                  //               )
                  //             : (url.isNotEmpty
                  //                 ? Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.center,
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: [
                  //                       Text(
                  //                           "No ID / Driving License Uploaded Yet"),
                  //                       SizedBox(
                  //                         height: 10.px,
                  //                       ),
                  //                       Container(
                  //                         height: 40.px,
                  //                         width: 40.px,
                  //                         padding: EdgeInsets.all(8.px),
                  //                         margin: EdgeInsets.all(10.px),
                  //                         decoration: BoxDecoration(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(20.px),
                  //                             color: primaryColor),
                  //                         child: CommonWidgets.appIcons(
                  //                             assetName: IconConstants.icAdd,
                  //                             color: primary3Color,
                  //                             height: 25.px,
                  //                             width: 25.px),
                  //                       ),
                  //                     ],
                  //                   )
                  //                 : Center(
                  //                     child: Text(
                  //                       'Upload Your ID / Driving License',
                  //                       style: MyTextStyle.titleStyle14b,
                  //                     ),
                  //                   )),
                  //       );
                  //     }),
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: () {
                      controller.showAlertDialog(0, docType: 'id_license');
                    },
                    child: DottedBorder(
                      color: primaryColor,
                      dashPattern: const [4, 2],
                      strokeWidth: 2.px,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(14.px),
                      child: Obx(() {
                        final file = controller.selectedIDLicense.value;
                        final url = controller.idLicenseImageUrl.value;
                        return Container(
                          height: 200.px,
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.px),
                          child: file != null || url.isNotEmpty
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10.px),
                                      child: file != null
                                          ? Image.file(
                                              file,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            )
                                          : Image.network(
                                              url,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                              loadingBuilder:
                                                  (context, child, progress) {
                                                if (progress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: progress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? progress
                                                                .cumulativeBytesLoaded /
                                                            progress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                    child: Text(
                                                  'Failed to load ID/License',
                                                  style:
                                                      MyTextStyle.titleStyle14b,
                                                ));
                                              },
                                            ),
                                    ),
                                    Positioned(
                                      top: 8.px,
                                      right: 8.px,
                                      child: Container(
                                        padding: EdgeInsets.all(6.px),
                                        decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius:
                                              BorderRadius.circular(20.px),
                                        ),
                                        child: Icon(Icons.edit,
                                            color: Colors.white, size: 20.px),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                        "No ID / Driving License Uploaded Yet"),
                                    SizedBox(height: 10.px),
                                    Container(
                                      height: 40.px,
                                      width: 40.px,
                                      padding: EdgeInsets.all(8.px),
                                      margin: EdgeInsets.all(10.px),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.px),
                                        color: primaryColor,
                                      ),
                                      child: CommonWidgets.appIcons(
                                        assetName: IconConstants.icAdd,
                                        color: primary3Color,
                                        height: 25.px,
                                        width: 25.px,
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 20.px),

                  // ===== GALLERY IMAGES =====
                  Text(StringConstants.photo,
                      style: MyTextStyle.titleStyle20bb,
                      textAlign: TextAlign.center),
                  SizedBox(height: 5.px),
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
                        onTap: () => controller.showAlertDialog(index),
                        child: DottedBorder(
                          color: primaryColor,
                          dashPattern: const [4, 2],
                          strokeWidth: 2.px,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(14.px),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // 🔹 First priority: Local image selected by user
                              if (controller.imageList[index] != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.px),
                                  child: Image.file(
                                    controller.imageList[index]!,
                                    height: 75.px,
                                    width: 75.px,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              // 🔹 Second priority: Already existing gallery image from API (if available)
                              else if ((controller.userDetails.userData
                                              ?.galleryImages?.length ??
                                          0) >
                                      index &&
                                  (controller
                                          .userDetails
                                          .userData!
                                          .galleryImages![index]
                                          .gallery
                                          ?.isNotEmpty ??
                                      false))
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.px),
                                  child: CommonWidgets.imageView(
                                    image: controller.userDetails.userData!
                                        .galleryImages![index].gallery!,
                                    height: 75.px,
                                    width: 75.px,
                                    fit: BoxFit.fill,
                                    borderRadius: 15.px,
                                    defaultNetworkImage:
                                        StringConstants.defaultNetworkImage,
                                  ),
                                )
                              // 🔹 Default state: Show Add (+) icon for empty slots
                              else
                                Center(
                                  child: CommonWidgets.appIcons(
                                    assetName: IconConstants.icAdd,
                                    height: 25.px,
                                    width: 25.px,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20.px),

                  // ===== SAVE BUTTON =====
                  CommonWidgets.commonElevatedButton(
                    onPressed: controller.clickOnSubmitButton,
                    child: Text(StringConstants.save,
                        style: MyTextStyle.titleStyle18bw),
                  ),
                  SizedBox(height: 20.px),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
