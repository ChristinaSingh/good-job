import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/colors.dart';
import '../../../../common/common_pickImage.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/image_pick_and_crop.dart';
import '../../../../common/text_styles.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/constants/string_constants.dart';
import '../../../routes/app_pages.dart';

class ProviderDocumerntController extends GetxController {
  List<File?> imageList = [null, null];
  Map<String, String?> parameters = Get.parameters;
  final count = 0.obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
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
      color: primaryColor,
    );
    increment();
  }

  Future<void> pickGallery(int index) async {
    Get.back();
    imageList[index] = await ImagePickerAndCropper.pickImage(
        context: Get.context!,
        wantCropper: true,
        color: primaryColor,
        pickImageFromGallery: true);
    increment();
  }

  Future<void> clickOnSubmitButton() async {
    List<File> fileList = [];
    imageList.forEach((element) {
      if (element != null) {
        fileList.add(element);
      }
    });
    if (fileList.isNotEmpty) {
      try {
        Map<String, dynamic> postAddParameters = {
          ApiKeyConstants.userId: parameters[ApiKeyConstants.userId] ?? '',
        };
        isLoading.value = true;
        print("addEventBodyParams:-$postAddParameters");
        UserModel? userModel = await ApiMethods.updateProviderDocumentApi(
            bodyParams: postAddParameters, imageList: fileList);
        print("response:-${userModel!.message.toString()}");
        if (userModel != null &&
            userModel.status != '0' &&
            userModel.userData != null) {
          isLoading.value = false;
          CommonWidgets.showMyToastMessage(
              'Create profile successfully completed ...');
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString(ApiKeyConstants.userId, userModel.userData!.id ?? '');
          sp.setString(ApiKeyConstants.type, userModel.userData!.type ?? '');
          sp.setString(ApiKeyConstants.email, userModel.userData!.email ?? '');
          Get.offAllNamed(Routes.SPLASH);
        } else {
          CommonWidgets.showMyToastMessage(userModel.message ?? '');
        }
      } catch (e) {
        print("Error:-${e.toString()}");
      }
      isLoading.value = false;
    } else {
      CommonWidgets.showMyToastMessage(
          'Please upload at least one certificate ...');
    }
  }
}
