import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/data/apis/api_models/get_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_methods/api_methods.dart';

class NotificationController extends GetxController {
  List<NotificationData> notificationList = [];
  final count = 0.obs;
  final showProgressBar = true.obs;
  String userId = '';
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';
    super.onInit();
    callingBookingRequestList();
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

  void callingBookingRequestList() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: userId,
      };
      NotificationModel? notificationModel =
          await ApiMethods.getNotificationApi(bodyParams: bodyParams);
      if (notificationModel != null &&
          notificationModel.status != '0' &&
          notificationModel.data != null &&
          notificationModel.data!.isNotEmpty) {
        notificationList = notificationModel.data!;
        increment();
      } else {
        print('Processing List not present..............');
        // CommonWidgets.showMyToastMessage(getProviderBookingRequest!.message!);
      }
      showProgressBar.value = false;
    } catch (e) {
      showProgressBar.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
    increment();
  }
}
