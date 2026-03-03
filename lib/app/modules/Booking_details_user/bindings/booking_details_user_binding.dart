import 'package:get/get.dart';

import '../controllers/booking_details_user_controller.dart';

class BookingDetailsUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailsUserController>(
      () => BookingDetailsUserController(),
    );
  }
}
