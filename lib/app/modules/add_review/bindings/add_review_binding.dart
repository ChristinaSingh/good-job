import 'package:get/get.dart';

import '../controllers/add_review_controller.dart';

class AddReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddReviewController>(
      () => AddReviewController(),
    );
  }
}
