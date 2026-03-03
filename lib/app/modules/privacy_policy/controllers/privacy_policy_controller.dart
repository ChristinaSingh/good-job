import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_privacy_policy.dart';

class PrivacyPolicyController extends GetxController {
  List<PrivacyPolicyResult>? privacyPolicyResult;

  final count = 0.obs;
  final inAsyncCall = true.obs;
  @override
  void onInit() {
    super.onInit();
    getPrivacyPolicy();
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

  Future<void> getPrivacyPolicy() async {
    PrivacyPolicyModel? privacyPolicyModel =
        await ApiMethods.privacyPolicyApi();
    if (privacyPolicyModel != null &&
        privacyPolicyModel.status == '1' &&
        privacyPolicyModel.result != null) {
      privacyPolicyResult = privacyPolicyModel.result;
    } else {
      CommonWidgets.showMyToastMessage(privacyPolicyModel?.message ?? '');
    }
    inAsyncCall.value = false;
  }
}
