import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_simple_model.dart';

class SupportController extends GetxController {
  TextEditingController messageController = TextEditingController();
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

  void submitMessageButton() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: parameters[ApiKeyConstants.userId] ?? '',
        ApiKeyConstants.message: messageController.text
      };
      isLoading.value = true;
      SimpleModel? simpleModel =
          await ApiMethods.supportInquiriesApi(bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != '0') {
        CommonWidgets.showMyToastMessage(simpleModel.message ?? '');
        messageController.text = '';
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
