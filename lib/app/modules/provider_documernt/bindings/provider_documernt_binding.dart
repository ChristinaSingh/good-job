import 'package:get/get.dart';

import '../controllers/provider_documernt_controller.dart';

class ProviderDocumerntBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderDocumerntController>(
      () => ProviderDocumerntController(),
    );
  }
}
