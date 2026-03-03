import 'package:get/get.dart';
import 'package:good_job/app/modules/booking/views/booking_view.dart';
import 'package:good_job/app/modules/chat/views/chat_view.dart';
import 'package:good_job/app/modules/map/views/map_view.dart';
import 'package:good_job/app/modules/profile/views/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/views/home_view.dart';

final selectedIndex = 0.obs;

class NavBarController extends GetxController {
  final count = 0.obs;
  SharedPreferences? prefs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  void increment() => count.value++;

  body() {
    switch (selectedIndex.value) {
      case 0:
        return const HomeView();
      case 1:
        return const BookingView();
      case 2:
        return const MapView();
      case 3:
        return const ChatView();
      case 4:
        return const ProfileView();
    }
  }
}
