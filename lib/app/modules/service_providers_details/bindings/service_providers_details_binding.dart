import 'package:get/get.dart';

import '../controllers/service_providers_details_controller.dart';

class ServiceProvidersDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceProvidersDetailsController>(
      () => ServiceProvidersDetailsController(),
    );
  }
}
