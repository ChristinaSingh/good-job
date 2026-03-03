import 'dart:async';

import 'package:get/get.dart';
import 'package:good_job/app/modules/nav_bar/controllers/nav_bar_controller.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:good_job/common/common_widgets.dart';

class WaitingRequestController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 3));
    // CommonWidgets.showMyToastMessage('Booking confirmed ...');
    selectedIndex.value = 1;
    Get.offAllNamed(Routes.NAV_BAR);
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
}
