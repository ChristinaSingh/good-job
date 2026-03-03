import 'package:get/get.dart';

import '../controllers/searvice_form_controller.dart';

class SearviceFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearviceFormController>(
      () => SearviceFormController(),
    );
  }
}
