import 'package:get/get.dart';
import 'package:good_job/app/routes/app_pages.dart';

class PaymentController extends GetxController {
  List<String> paymentType = ['Mobile Transfer', 'Visa/Master/AMEX'];

  final count = 0.obs;
  final paymentTypeIndex = 0.obs;
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

  changeSelectIndex(int index) {
    paymentTypeIndex.value = index;
    increment();
  }

  void clickOnSubmitButton() {
    Get.offAllNamed(Routes.NAV_BAR);
  }
}
