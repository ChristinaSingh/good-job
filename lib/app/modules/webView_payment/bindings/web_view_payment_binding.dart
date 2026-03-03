import 'package:get/get.dart';

import '../controllers/web_view_payment_controller.dart';

class WebViewPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebViewPaymentController>(
      () => WebViewPaymentController(),
    );
  }
}
