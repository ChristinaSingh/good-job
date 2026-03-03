import 'package:get/get.dart';

import '../controllers/provider_working_process_controller.dart';

class ProviderWorkingProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderWorkingProcessController>(
      () => ProviderWorkingProcessController(),
    );
  }
}
