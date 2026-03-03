import 'package:get/get.dart';

import '../controllers/provider_wallet_controller.dart';

class ProviderWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderWalletController>(
      () => ProviderWalletController(),
    );
  }
}
