// import 'package:get/get.dart';
// import 'package:good_job/app/data/constants/string_constants.dart';
//
// import '../../../../common/common_widgets.dart';
// import '../../../data/apis/api_constants/api_key_constants.dart';
// import '../../../data/apis/api_methods/api_methods.dart';
// import '../../../data/apis/api_models/get_simple_model.dart';
// import '../../../data/apis/api_models/get_user_model.dart';
//
// class NotificationSettingController extends GetxController {
//   List<Map<String, dynamic>> notificationList = [
//     {'title': StringConstants.generalNotification, 'status': false},
//     {'title': StringConstants.sound, 'status': false},
//     {'title': StringConstants.vibrate, 'status': false},
//     {'title': StringConstants.appUpdates, 'status': false},
//     {'title': StringConstants.newTipsAvailable, 'status': false},
//   ];
//
//   final count = 0.obs;
//   final inAsyncCall = false.obs;
//   UserModel userDetails = Get.arguments;
//   @override
//   void onInit() {
//     super.onInit();
//     setInitialValue();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   void increment() => count.value++;
//   void setInitialValue() {
//     notificationList[0]['status'] =
//         userDetails.userData?.generalNotification == 'ON' ? true : false;
//     notificationList[1]['status'] =
//         userDetails.userData?.sound == 'ON' ? true : false;
//     notificationList[2]['status'] =
//         userDetails.userData?.vibrate == 'ON' ? true : false;
//     notificationList[3]['status'] =
//         userDetails.userData?.appUpdate == 'ON' ? true : false;
//     notificationList[4]['status'] =
//         userDetails.userData?.newTipsAvailable == 'ON' ? true : false;
//     increment();
//   }
//
//   changeSelectIndex(bool value, int index) {
//     notificationList[index]['status'] = value;
//     increment();
//   }
//
//   void callingNotificationApi() async {
//     try {
//       Map<String, String> bodyParams = {
//         ApiKeyConstants.userId: userDetails.userData?.id ?? '',
//         ApiKeyConstants.generalNotification:
//             notificationList[0]['status'] ? 'ON' : 'OFF',
//         ApiKeyConstants.sound: notificationList[1]['status'] ? 'ON' : 'OFF',
//         ApiKeyConstants.vibrate: notificationList[2]['status'] ? 'ON' : 'OFF',
//         ApiKeyConstants.appUpdate: notificationList[3]['status'] ? 'ON' : 'OFF',
//         ApiKeyConstants.newTipsAvailable:
//             notificationList[4]['status'] ? 'ON' : 'OFF',
//       };
//       inAsyncCall.value = true;
//       SimpleModel? simpleModel =
//           await ApiMethods.setNotificationApi(bodyParams: bodyParams);
//       if (simpleModel != null && simpleModel.status != '0') {
//         CommonWidgets.showMyToastMessage(simpleModel.message ?? '');
//         Get.back(result: true);
//       } else {
//         CommonWidgets.showMyToastMessage(simpleModel!.message!);
//       }
//       inAsyncCall.value = false;
//     } catch (e) {
//       inAsyncCall.value = false;
//       CommonWidgets.showMyToastMessage('Some thing is wrong ...');
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/app/modules/provider_profile/controllers/provider_profile_controller.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_simple_model.dart';
import '../../../data/apis/api_models/get_user_model.dart';

class NotificationSettingController extends GetxController {
  List<Map<String, dynamic>> notificationList = [
    {'title': StringConstants.generalNotification, 'status': false},
    {'title': StringConstants.sound, 'status': false},
    {'title': StringConstants.vibrate, 'status': false},
    {'title': StringConstants.appUpdates, 'status': false},
    {'title': StringConstants.newTipsAvailable, 'status': false},
  ];

  final count = 0.obs;
  final inAsyncCall = false.obs;

  UserModel? userDetails;

  @override
  @override
  void onInit() {
    print("🔔 NotificationSettingController initialized");
    super.onInit();
    userDetails = Get.arguments;

    // Debug print
    if (userDetails == null) {
      print("🚨 userDetails is NULL");
    } else {
      print("✅ userDetails received:");
      print("ID: ${userDetails!.userData?.id}");
      print(
          "General Notification: ${userDetails!.userData?.generalNotification}");
      print("Sound: ${userDetails!.userData?.sound}");
      print("Vibrate: ${userDetails!.userData?.vibrate}");
      print("App Update: ${userDetails!.userData?.appUpdate}");
      print("New Tips Available: ${userDetails!.userData?.newTipsAvailable}");
    }

    if (userDetails != null) {
      setInitialValue();
    }
  }

  void increment() => count.value++;

  void setInitialValue() {
    notificationList[0]['status'] =
        userDetails?.userData?.generalNotification == 'ON';
    notificationList[1]['status'] = userDetails?.userData?.sound == 'ON';
    notificationList[2]['status'] = userDetails?.userData?.vibrate == 'ON';
    notificationList[3]['status'] = userDetails?.userData?.appUpdate == 'ON';
    notificationList[4]['status'] =
        userDetails?.userData?.newTipsAvailable == 'ON';
    increment();
  }

  void changeSelectIndex(bool value, int index) {
    notificationList[index]['status'] = value;
    increment();
  }

  void callingNotificationApi() async {
    try {
      inAsyncCall.value = true;

      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: userDetails?.userData?.id ?? '',
        ApiKeyConstants.generalNotification:
            notificationList[0]['status'] ? 'ON' : 'OFF',
        ApiKeyConstants.sound: notificationList[1]['status'] ? 'ON' : 'OFF',
        ApiKeyConstants.vibrate: notificationList[2]['status'] ? 'ON' : 'OFF',
        ApiKeyConstants.appUpdate: notificationList[3]['status'] ? 'ON' : 'OFF',
        ApiKeyConstants.newTipsAvailable:
            notificationList[4]['status'] ? 'ON' : 'OFF',
      };

      SimpleModel? simpleModel =
          await ApiMethods.setNotificationApi(bodyParams: bodyParams);

      if (simpleModel != null && simpleModel.status != '0') {
        CommonWidgets.showMyToastMessage(simpleModel.message ?? '');
        print("type is -----------------? ${userDetails?.userData?.type}");
        //
        // ProviderProfileController profileController =
        //     Get.find<ProviderProfileController>();
        // profileController.callingGetProfile();
        Get.back();
      } else {
        CommonWidgets.showMyToastMessage(simpleModel?.message ?? '');
      }

      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Something went wrong...');
    }
  }

  void callingNotificationProvider() async {
    try {
      inAsyncCall.value = true;

      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: userDetails?.userData?.id ?? '',
        ApiKeyConstants.generalNotification:
            notificationList[0]['status'] ? 'ON' : 'OFF',
        ApiKeyConstants.sound: notificationList[1]['status'] ? 'ON' : 'OFF',
        ApiKeyConstants.vibrate: notificationList[2]['status'] ? 'ON' : 'OFF',
        ApiKeyConstants.appUpdate: notificationList[3]['status'] ? 'ON' : 'OFF',
        ApiKeyConstants.newTipsAvailable:
            notificationList[4]['status'] ? 'ON' : 'OFF',
      };

      SimpleModel? simpleModel =
          await ApiMethods.setNotificationApi(bodyParams: bodyParams);

      if (simpleModel != null && simpleModel.status != '0') {
        CommonWidgets.showMyToastMessage(simpleModel.message ?? '');
        print("type is -----------------? ${userDetails?.userData?.type}");
        //
        // ProviderProfileController providerProfileController =
        //     Get.find<ProviderProfileController>();
        // providerProfileController.callingGetProfile();

        Get.back();
      } else {
        CommonWidgets.showMyToastMessage(simpleModel?.message ?? '');
      }

      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      // CommonWidgets.showMyToastMessage('Something went wrong...');
    }
  }
}
