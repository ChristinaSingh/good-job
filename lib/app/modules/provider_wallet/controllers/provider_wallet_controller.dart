import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/data/apis/api_models/get_payment_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_methods/api_methods.dart';

class ProviderWalletController extends GetxController {
  List<PaymentHistoryData> historyList = [];
  final inAsyncCall = true.obs;
  final count = 0.obs;
  String userId = '';
  String totalAmount = '0';
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';
    super.onInit();
    callingWalletHistoryApi();
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

  void callingWalletHistoryApi() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.providerId: userId,
      };

      PaymentHistoryModel? paymentHistoryModel =
          await ApiMethods.getWalletHistoryApi(bodyParams: bodyParams);
      if (paymentHistoryModel != null && paymentHistoryModel.status != '0') {
        historyList = paymentHistoryModel.data!;
        totalAmount = paymentHistoryModel.totalAmount.toString() ?? '0';
        // CommonWidgets.showMyToastMessage(paymentHistoryModel.message ?? '');
      } else {
        // CommonWidgets.showMyToastMessage(
        //     paymentHistoryModel!.message ?? 'Data not found...');
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
    increment();
  }
}
