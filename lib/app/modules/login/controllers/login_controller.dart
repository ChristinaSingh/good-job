import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/common/common_widgets.dart';

import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/set_otp_model.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  final countryDailCode = '+91'.obs;
  Map<String, String?> parameters = Get.parameters;
  final count = 0.obs;
  final showLoading = false.obs;
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

  clickOnCountryCode({required CountryCode value}) {
    countryDailCode.value = value.dialCode.toString();
  }

  void clickOnLoginButton() async {
    if (phoneController.text.trim().isNotEmpty) {
      try {
        showLoading.value = true;
        Map<String, String> bodyParams = {
          ApiKeyConstants.mobile: phoneController.text,
          ApiKeyConstants.countryCode: countryDailCode.value.toString(),
          ApiKeyConstants.type: parameters[ApiKeyConstants.type] ?? 'USER'
        };
        SendOtpModel? sendOtpModel =
            await ApiMethods.sendOtpForLogin(bodyParams: bodyParams);
        if (sendOtpModel != null && sendOtpModel.status != '0') {
          showLoading.value = false;
          Map<String, String> data = {
            ApiKeyConstants.mobile: phoneController.text.toString(),
            ApiKeyConstants.countryCode: countryDailCode.value.toString(),
            ApiKeyConstants.type: parameters[ApiKeyConstants.type] ?? 'USER'
          };
          Get.toNamed(Routes.OTP_VERIFICATION, parameters: data);
        } else {
          CommonWidgets.snackBarView(title: sendOtpModel!.message!);
        }
      } catch (e) {
        showLoading.value = false;
        CommonWidgets.snackBarView(title: 'Some things wrong...');
      }
      showLoading.value = false;
    } else {
      CommonWidgets.snackBarView(title: 'Enter phone number....');
    }
  }
}
