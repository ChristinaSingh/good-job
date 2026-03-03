import 'package:get/get.dart';

import '../controllers/create_your_profile_controller.dart';

class CreateYourProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateYourProfileController>(
      () => CreateYourProfileController(),
    );
  }
}
