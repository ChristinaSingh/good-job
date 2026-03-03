import 'package:get/get.dart';
import 'package:good_job/app/modules/booking/controllers/booking_controller.dart';
import 'package:good_job/app/modules/chat/controllers/chat_controller.dart';
import 'package:good_job/app/modules/home/controllers/home_controller.dart';
import 'package:good_job/app/modules/map/controllers/map_controller.dart';
import 'package:good_job/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/nav_bar_controller.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavBarController>(
      () => NavBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<BookingController>(
      () => BookingController(),
    );
    Get.lazyPut<MapController>(
      () => MapController(),
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
