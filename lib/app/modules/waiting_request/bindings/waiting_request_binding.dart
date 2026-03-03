import 'package:get/get.dart';

import '../controllers/waiting_request_controller.dart';

class WaitingRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitingRequestController>(
      () => WaitingRequestController(),
    );
  }
}
