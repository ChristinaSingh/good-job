import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_methods/api_methods.dart';
import 'package:good_job/app/data/apis/api_models/get_simple_model.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';

class AddReviewController extends GetxController {
  TextEditingController messageController = TextEditingController();
  Map<String, String?> parameter = Get.parameters;
  final count = 0.obs;
  final ratingValue = 3.0.obs;
  final inAsyncCall = false.obs;
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

  void callingAddReview() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: parameter[ApiKeyConstants.userId] ?? '',
        ApiKeyConstants.providerId: parameter[ApiKeyConstants.providerId] ?? '',
        ApiKeyConstants.message: messageController.text,
        ApiKeyConstants.rating: ratingValue.value.toString(),
      };
      inAsyncCall.value = true;
      SimpleModel? simpleModel =
          await ApiMethods.addReviewApi(bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != '0') {
        CommonWidgets.showMyToastMessage(simpleModel!.message!);
        Get.back();
      } else {
        print('Processing List not present..............');
        CommonWidgets.showMyToastMessage(simpleModel!.message!);
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
    increment();
  }
}
