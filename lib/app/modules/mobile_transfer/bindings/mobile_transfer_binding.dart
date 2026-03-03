import 'package:get/get.dart';

import '../controllers/mobile_transfer_controller.dart';

class MobileTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobileTransferController>(
      () => MobileTransferController(),
    );
  }
}
