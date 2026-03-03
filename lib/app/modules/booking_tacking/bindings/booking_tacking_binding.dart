import 'package:get/get.dart';

import '../controllers/booking_tacking_controller.dart';

class BookingTackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingTackingController>(
      () => BookingTackingController(),
    );
  }
}
