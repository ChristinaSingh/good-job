import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_booking_request_model.dart';
import '../../../data/apis/api_models/get_simple_model.dart';

class ProviderWorkingProcessController extends GetxController {
  BookingRequestData bookingData = Get.arguments;
  final count = 0.obs;
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

  void clickOnCollectAmountButton() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.bookingId: bookingData.bookingRequestId ?? '',
        ApiKeyConstants.providerId: bookingData.providerId ?? '',
        ApiKeyConstants.amount: bookingData.amount ?? ''
      };
      inAsyncCall.value = true;
      SimpleModel? simpleModel =
          await ApiMethods.collectBookingAmountApi(bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != '0') {
        // CommonWidgets.showMyToastMessage(simpleModel.message ?? '');
        Future.delayed(const Duration(seconds: 3), () {
          Get.back();
          Get.back();
          Get.back();
        });
      } else {
        CommonWidgets.showMyToastMessage(simpleModel!.message!);
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
  }
}
