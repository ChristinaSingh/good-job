import 'package:get/get.dart';

import '../controllers/booking_sucess_pop_up_controller.dart';

class BookingSucessPopUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingSucessPopUpController>(
      () => BookingSucessPopUpController(),
    );
  }
}
