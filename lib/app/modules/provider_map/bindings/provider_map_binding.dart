import 'package:get/get.dart';

import '../controllers/provider_map_controller.dart';

class ProviderMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderMapController>(
      () => ProviderMapController(),
    );
  }
}
