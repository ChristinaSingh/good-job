import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/data/apis/api_models/get_simple_model.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/local_data.dart';
import 'package:google_places_flutter_api/google_places_flutter_api.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../../../../common/common_pickImage.dart';
import '../../../../common/image_pick_and_crop.dart';
import '../../../../common/text_styles.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/constants/string_constants.dart';

class CreateYourProfileController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobRoleController = TextEditingController();
  TextEditingController chargeController = TextEditingController();
  TextEditingController specialQualificationController =
      TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final isFullName = false.obs;
  final isEmail = false.obs;
  final isJobRole = false.obs;
  final isCharge = false.obs;
  final isPhone = false.obs;
  final isQualification = false.obs;
  final isLocation = false.obs;
  final isDescription = false.obs;
  final inAsyncCall = false.obs;

  FocusNode focusFullName = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusPhone = FocusNode();
  FocusNode focusJobRole = FocusNode();
  FocusNode focusCharge = FocusNode();
  FocusNode focusQualification = FocusNode();
  FocusNode focusLocation = FocusNode();
  FocusNode focusDescription = FocusNode();

  void startListener() {
    focusFullName.addListener(onFocusChange);
    focusEmail.addListener(onFocusChange);
    focusPhone.addListener(onFocusChange);
    focusJobRole.addListener(onFocusChange);
    focusCharge.addListener(onFocusChange);
    focusQualification.addListener(onFocusChange);
    focusLocation.addListener(onFocusChange);
    focusDescription.addListener(onFocusChange);
  }

  void onFocusChange() {
    isFullName.value = focusFullName.hasFocus;
    isEmail.value = focusEmail.hasFocus;
    isPhone.value = focusPhone.hasFocus;
    isJobRole.value = focusJobRole.hasFocus;
    isCharge.value = focusCharge.hasFocus;
    isQualification.value = focusQualification.hasFocus;
    isLocation.value = focusLocation.hasFocus;
    isDescription.value = focusDescription.hasFocus;
  }

  List<File?> imageList = [null, null, null, null, null, null, null, null];
  final count = 0.obs;
  final jobRoleIndex = 0.obs;
  final checkValue = 0.obs;
  String lat = '';
  String lon = '';
  Map<String, String?> parameters = Get.parameters;
  List<String> attributesList = [
    StringConstants.trust,
    StringConstants.integrity,
    StringConstants.loyalty,
    StringConstants.qualityOfYourWork,
  ];
  @override
  void onInit() {
    super.onInit();
    startListener();
    phoneController.text = parameters[ApiKeyConstants.mobile] ?? '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void showAlertDialog(int index) {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                StringConstants.camera,
                style: MyTextStyle.titleStyle12bb,
              ),
              onPressed: () => pickCamera(index),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                StringConstants.gallery,
                style: MyTextStyle.titleStyle12bb,
              ),
              onPressed: () => pickGallery(index),
            ),
          ],
          title: Text(
            StringConstants.selectImage,
            style: MyTextStyle.titleStyle18bb,
          ),
          content: Text(
            StringConstants.chooseImageFromTheOptionsBelow,
            style: MyTextStyle.titleStyle14bb,
          ),
        );
      },
    );
  }

  Future<void> pickCamera(int index) async {
    Get.back();
    imageList[index] = await ImagePickerAndCropper.pickImage(
      context: Get.context!,
      wantCropper: true,
      color: Theme.of(Get.context!).primaryColor,
    );
    increment();
  }

  Future<void> pickGallery(int index) async {
    Get.back();
    imageList[index] = await ImagePickerAndCropper.pickImage(
        context: Get.context!,
        wantCropper: true,
        color: Theme.of(Get.context!).primaryColor,
        pickImageFromGallery: true);
    increment();
  }

  clickOnAllLocationsTextField() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: Get.context!,
      apiKey: "AIzaSyDT62NXFvZu9qKdh96SkstdkV43cXadFyc",
      mode: Mode.overlay,
    );
    if (p != null) {
      locationController.text = p.description ?? '';
      final locations = await locationFromAddress(p.description ?? '');
      lat = locations.first.latitude.toString();
      lon = locations.first.longitude.toString();
      print('Lat_Long :-$lat,$lon');
    }
  }

  void selectJobsRoles() {
    showModalBottomSheet(
      context: Get.context!,
      constraints: BoxConstraints(maxHeight: 500.px, minHeight: 300.px),
      isScrollControlled: false,
      backgroundColor: primary3Color,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.px,
              ),
              Center(
                child: Text(
                  StringConstants.selectJobRole.tr,
                  style: MyTextStyle.titleStyle16gr,
                ),
              ),
              SizedBox(
                height: 20.px,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: LocalData.categoryList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        jobRoleIndex.value = index;
                        jobRoleController.text =
                            LocalData.categoryList[index]['service_name'] ?? '';
                      },
                      child: Container(
                        height: 40.px,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.px, vertical: 5.px),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.px,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.px),
                            border: Border.all(
                                color: jobRoleIndex.value == index
                                    ? primaryColor
                                    : primary3Color)),
                        child: Text(
                          '${LocalData.categoryList[index]['service_name']}',
                          style: MyTextStyle.titleStyle14bb,
                        ),
                      ),
                    );
                  })
            ],
          );
        });
      },
    );
  }

  Future<void> clickOnSubmitButton() async {
    List<File> fileList = [];
    imageList.forEach((element) {
      if (element != null) {
        fileList.add(element);
      }
    });
    if (fileList.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        jobRoleController.text.isNotEmpty &&
        chargeController.text.isNotEmpty &&
        specialQualificationController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        locationController.text.isNotEmpty) {
      try {
        Map<String, dynamic> postAddParameters = {
          ApiKeyConstants.userId: parameters[ApiKeyConstants.userId] ?? '',
          ApiKeyConstants.userName: fullNameController.text,
          ApiKeyConstants.email: emailController.text,
          ApiKeyConstants.jobRoleService:
              LocalData.categoryList[jobRoleIndex.value]['ser_id'],
          ApiKeyConstants.perHourCharge: chargeController.text,
          ApiKeyConstants.specialQualification:
              specialQualificationController.text,
          ApiKeyConstants.description: descriptionController.text,
          ApiKeyConstants.attribute: attributesList[checkValue.value],
          ApiKeyConstants.location: locationController.text,
          ApiKeyConstants.lat: lat,
          ApiKeyConstants.lon: lon,
        };
        inAsyncCall.value = true;
        print("addEventBodyParams:-$postAddParameters");
        SimpleModel? response = await ApiMethods.providerCreateProfileApi(
            bodyParams: postAddParameters, imageList: fileList);
        print("response:-${response!.message.toString()}");
        if (response != null && response.status != '0') {
          inAsyncCall.value = false;
          CommonWidgets.showMyToastMessage(
              'Create profile successfully completed ...');
          Map<String, String> data = {
            ApiKeyConstants.userId: parameters[ApiKeyConstants.userId] ?? ''
          };
          Get.toNamed(Routes.PROVIDER_DOCUMERNT, parameters: data);
        } else {
          CommonWidgets.showMyToastMessage(response.message ?? '');
        }
      } catch (e) {
        print("Error:-${e.toString()}");
      }
      inAsyncCall.value = false;
    } else {
      CommonWidgets.showMyToastMessage(
          'Please fill all field and select at least one image to upload ...');
    }
  }
}
