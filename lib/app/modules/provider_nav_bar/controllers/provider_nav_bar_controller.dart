import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../chat/views/chat_view.dart';
import '../../provider_booking/views/provider_booking_view.dart';
import '../../provider_home/views/provider_home_view.dart';
import '../../provider_profile/views/provider_profile_view.dart';

class ProviderNavBarController extends GetxController {
  var providerSelectedIndex = 0.obs; // Move it inside the controller

  body() {
    switch (providerSelectedIndex.value) {
      case 0:
        return ProviderHomeView(); // No `const` to reload widget
      case 1:
        return ProviderBookingView();
      case 2:
        return ChatView();
      case 3:
        return ProviderProfileView();
      default:
        return ProviderHomeView();
    }
  }
}