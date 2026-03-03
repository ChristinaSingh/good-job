import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/routes/app_pages.dart';

import '../../../../common/local_data.dart';

class HomeController extends GetxController {
  final cardIndex = 0.obs;
  List<Map<String, String>> bannerData = [
    {
      'image': 'assets/images/img_home_banner.png',
      'title': 'Destroy all',
      'description': 'Your uninvited guests at Home'
    },
    {
      'image': 'assets/images/img_home_banner.png',
      'title': 'Destroy all',
      'description': 'Your uninvited guests at Home'
    },
    {
      'image': 'assets/images/img_home_banner.png',
      'title': 'Destroy all',
      'description': 'Your uninvited guests at Home'
    },
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void clickOnNotification() {
    Get.toNamed(Routes.NOTIFICATION);
  }

  void clickOnServiceItem(Map<String, String> item) {
    Map<String, String> data = {
      ApiKeyConstants.title: item['service_name'] ?? '',
      ApiKeyConstants.serviceId: item['ser_id'] ?? '',
    };

    print("category id is ${item['ser_id']}");
    Get.toNamed(Routes.SEARVICE_FORM, parameters: data);
  }
}
