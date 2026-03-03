import 'package:get/get.dart';
import 'package:good_job/app/routes/app_pages.dart'; // Ensure this path is correct

class BookingSucessPopUpController extends GetxController {

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

  // Method to handle navigation when the user presses the dashboard button
  void navigateToHome() {
    Get.offAllNamed(Routes.NAV_BAR);
  }
}
