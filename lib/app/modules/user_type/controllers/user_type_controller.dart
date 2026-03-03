import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/routes/app_pages.dart';

class UserTypeController extends GetxController {
  //TODO: Implement UserTypeController

  final count = 0.obs;
  final tabIndex = 0.obs;
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

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  clickOnNextButton() {
    Map<String, String> data = {
      ApiKeyConstants.type: tabIndex.value == 0 ? 'USER' : 'PROVIDER'
    };
    Get.toNamed(Routes.LOGIN, parameters: data);
  }
}
