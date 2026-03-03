import 'package:get/get.dart';

import '../controllers/provider_project_detail_controller.dart';

class ProviderProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderProjectDetailController>(
      () => ProviderProjectDetailController(),
    );
  }
}
