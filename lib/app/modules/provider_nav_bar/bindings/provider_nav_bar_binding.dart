import 'package:get/get.dart';
import 'package:good_job/app/modules/chat/controllers/chat_controller.dart';
import 'package:good_job/app/modules/provider_booking/controllers/provider_booking_controller.dart';
import 'package:good_job/app/modules/provider_home/controllers/provider_home_controller.dart';
import 'package:good_job/app/modules/provider_profile/controllers/provider_profile_controller.dart';

import '../controllers/provider_nav_bar_controller.dart';

class ProviderNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderNavBarController>(
      () => ProviderNavBarController(),
    );
    Get.lazyPut<ProviderHomeController>(
      () => ProviderHomeController(),
    );
    Get.lazyPut<ProviderBookingController>(
      () => ProviderBookingController(),
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
    Get.lazyPut<ProviderProfileController>(
      () => ProviderProfileController(),
    );
  }
}
