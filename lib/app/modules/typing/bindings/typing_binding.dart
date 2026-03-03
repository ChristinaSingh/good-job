import 'package:get/get.dart';

import '../controllers/typing_controller.dart';

class TypingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TypingController>(
      () => TypingController(),
    );
  }
}
