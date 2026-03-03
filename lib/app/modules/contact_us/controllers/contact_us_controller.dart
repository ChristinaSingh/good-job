import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_contact_info_model.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_simple_model.dart';

class ContactUsController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final isName = false.obs;
  final isEmail = false.obs;
  final isMessage = false.obs;
  final isLoading = false.obs;

  FocusNode focusName = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusMessage = FocusNode();

  void startListener() {
    focusName.addListener(onFocusChange);
    focusEmail.addListener(onFocusChange);
    focusMessage.addListener(onFocusChange);
  }

  void onFocusChange() {
    isName.value = focusName.hasFocus;
    isEmail.value = focusEmail.hasFocus;
    isMessage.value = focusMessage.hasFocus;
  }

  ContactInfoResult? contactInfoResult;
  final count = 0.obs;
  final inAsyncCall = true.obs;
  Map<String, String?> parameter = Get.parameters;
  @override
  void onInit() {
    super.onInit();
    startListener();
    callingContactInfoApi();
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

  Future<void> callingContactInfoApi() async {
    ContactInfoModel? contactInfoModel = await ApiMethods.getContactInfoApi();
    if (contactInfoModel != null &&
        contactInfoModel.status == '1' &&
        contactInfoModel.result != null) {
      contactInfoResult = contactInfoModel.result;
    } else {
      CommonWidgets.showMyToastMessage(contactInfoModel?.message ?? '');
    }
    inAsyncCall.value = false;
  }

  void submitMessageButton() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: parameter[ApiKeyConstants.userId] ?? '',
        ApiKeyConstants.message: messageController.text,
        ApiKeyConstants.name: nameController.text,
        ApiKeyConstants.email: emailController.text,
      };
      isLoading.value = true;
      SimpleModel? simpleModel =
          await ApiMethods.contactUsSubmissionApi(bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != '0') {
        messageController.text = '';
        nameController.text = '';
        emailController.text = '';
        CommonWidgets.showMyToastMessage(simpleModel.message ?? '');
      } else {
        CommonWidgets.showMyToastMessage(simpleModel!.message!);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
  }
}
