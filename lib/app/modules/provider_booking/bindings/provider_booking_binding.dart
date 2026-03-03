import 'package:get/get.dart';

import '../controllers/provider_booking_controller.dart';

class ProviderBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderBookingController>(
      () => ProviderBookingController(),
    );
  }
}
