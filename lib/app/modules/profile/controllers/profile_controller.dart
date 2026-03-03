// import 'package:get/get.dart';
// import 'package:good_job/app/data/constants/icons_constant.dart';
// import 'package:good_job/app/data/constants/string_constants.dart';
// import 'package:good_job/app/routes/app_pages.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../common/common_widgets.dart';
// import '../../../data/apis/api_constants/api_key_constants.dart';
// import '../../../data/apis/api_methods/api_methods.dart';
// import '../../../data/apis/api_models/get_user_model.dart';
//
// class ProfileController extends GetxController {
//   List<Map<String, String>> itemList = [
//     {'image': IconConstants.icProfileCircle, 'title': StringConstants.profile},
//     // {'image': IconConstants.icPayment, 'title': StringConstants.payment},
//     {
//       'image': IconConstants.icNotificationCircle,
//       'title': StringConstants.notifications
//     },
//     {'image': IconConstants.icSupport, 'title': StringConstants.support},
//     {'image': IconConstants.icSupport, 'title': StringConstants.contactUs},
//     {'image': IconConstants.icAboutUs, 'title': StringConstants.aboutUs},
//     {
//       'image': IconConstants.icPrivacyPolicy,
//       'title': StringConstants.privacyPolicy
//     },
//     {'image': IconConstants.icLogout, 'title': StringConstants.logout}
//   ];
//
//   final count = 0.obs;
//   final inAsyncCall = true.obs;
//   String userId = '';
//   var userDetails = Rx<UserModel?>(null);
//
//   @override
//   void onInit() async {
//     super.onInit();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userId = prefs.getString(ApiKeyConstants.userId) ?? '';
//     callingGetProfile();
//   }
//
//   void increment() => count.value++;
//
//   void clickOnItem(int index) async {
//     if (userDetails.value?.userData == null) return;
//
//     Map<String, String> data = {
//       ApiKeyConstants.userId: userDetails.value!.userData!.id ?? ''
//     };
//
//     switch (index) {
//       case 0:
//         Get.toNamed(Routes.EDIT_PROFILE,
//             arguments: userDetails.value!.userData);
//         break;
//         // case 1:
//         //   Get.toNamed(Routes.PAYMENT, parameters: data);
//         break;
//       case 2:
//         bool? result = await Get.toNamed(
//           Routes.NOTIFICATION_SETTING,
//           parameters: data,
//           arguments: userDetails.value,
//         );
//         if (result == true) {
//           callingGetProfile();
//         }
//         break;
//       case 3:
//         Get.toNamed(Routes.SUPPORT, parameters: data);
//         break;
//       case 4:
//         Get.toNamed(Routes.CONTACT_US, parameters: data);
//         break;
//       case 5:
//         Get.toNamed(Routes.ABOUT_US, parameters: data);
//         break;
//       case 6:
//         Get.toNamed(Routes.PRIVACY_POLICY, parameters: data);
//         break;
//       case 7:
//         CommonWidgets.showAlertDialog(onPressedYes: clickOnYes);
//         break;
//     }
//   }
//
//   void clickOnYes() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     await sharedPreferences.setString(ApiKeyConstants.token, '');
//     await sharedPreferences.clear();
//     Get.offAllNamed(Routes.SPLASH);
//   }
//
//   void callingGetProfile() async {
//     try {
//       Map<String, String> bodyParams = {
//         ApiKeyConstants.userId: userId,
//       };
//       UserModel? userModel =
//           await ApiMethods.getProfileApi(bodyParams: bodyParams);
//
//       if (userModel != null &&
//           userModel.status != '0' &&
//           userModel.userData != null) {
//         userDetails.value = userModel;
//         inAsyncCall.value = false;
//       } else {
//         CommonWidgets.snackBarView(
//             title: userModel?.message ?? 'Something went wrong');
//       }
//     } catch (e) {
//       CommonWidgets.snackBarView(title: 'Something went wrong...');
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_user_model.dart';

class ProfileController extends GetxController {
  // Menu item list (0–6 only)
  final count = 0.obs;
  List<Map<String, String>> itemList = [
    {
      'image': IconConstants.icProfileCircle,
      'title': StringConstants.profile
    }, // 0

    {
      'image': IconConstants.icNotificationCircle,
      'title': StringConstants.notifications
    }, // 1

    {'image': IconConstants.icSupport, 'title': StringConstants.support}, // 2

    {'image': IconConstants.icSupport, 'title': StringConstants.contactUs}, // 3

    {'image': IconConstants.icAboutUs, 'title': StringConstants.aboutUs}, // 4

    {
      'image': IconConstants.icPrivacyPolicy,
      'title': StringConstants.privacyPolicy
    }, // 5

    {'image': IconConstants.icLogout, 'title': StringConstants.logout}, // 6
  ];

  final inAsyncCall = true.obs;
  String userId = '';
  var userDetails = Rx<UserModel?>(null);

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';
    callingGetProfile();
  }

  // --------------------------------------------
  // ON MENU ITEM CLICK
  // --------------------------------------------
  // void clickOnItem(int index) async {
  //   if (userDetails.value?.userData == null) return;
  //
  //   Map<String, String> data = {
  //     ApiKeyConstants.userId: userDetails.value!.userData!.id ?? ''
  //   };
  //
  //   switch (index) {
  //     case 0:
  //       Get.toNamed(
  //         Routes.EDIT_PROFILE,
  //         arguments: userDetails.value!.userData,
  //       );
  //       break;
  //
  //     case 1:
  //       bool? result = await Get.toNamed(
  //         Routes.NOTIFICATION_SETTING,
  //         parameters: data,
  //         arguments: userDetails.value,
  //       );
  //       if (result == true) {
  //         callingGetProfile();
  //       }
  //       break;
  //
  //     case 2:
  //       Get.toNamed(Routes.SUPPORT, parameters: data);
  //       break;
  //
  //     case 3:
  //       Get.toNamed(Routes.CONTACT_US, parameters: data);
  //       break;
  //
  //     case 4:
  //       Get.toNamed(Routes.ABOUT_US, parameters: data);
  //       break;
  //
  //     case 5:
  //       Get.toNamed(Routes.PRIVACY_POLICY, parameters: data);
  //       break;
  //
  //     case 6:
  //       CommonWidgets.showAlertDialog(onPressedYes: clickOnYes);
  //       break;
  //   }
  // }

  void clickOnItem(int index) async {
    if (userDetails.value?.userData == null) return;

    Map<String, String> data = {
      ApiKeyConstants.userId: userDetails.value!.userData!.id ?? ''
    };

    switch (index) {
      case 0:
        Get.toNamed(Routes.EDIT_PROFILE,
            arguments: userDetails.value!.userData);
        break;
      case 1:
        Get.toNamed(
          Routes.NOTIFICATION_SETTING,
          parameters: data,
          arguments: userDetails.value,
        )?.then((_) {
          callingGetProfile();
        });

        break;
      case 2:
        Get.toNamed(Routes.SUPPORT, parameters: data);
        break;
      case 3:
        Get.toNamed(Routes.CONTACT_US, parameters: data);
        break;
      case 4:
        Get.toNamed(Routes.ABOUT_US, parameters: data);
        break;
      case 5:
        Get.toNamed(Routes.PRIVACY_POLICY, parameters: data);
        break;
      case 6:
        CommonWidgets.showAlertDialog(onPressedYes: clickOnYes);
        break;
    }
  }

  // --------------------------------------------
  // LOGOUT
  // --------------------------------------------
  void clickOnYes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.clear();

    Get.offAllNamed(Routes.SPLASH);
  }

  // --------------------------------------------
  // GET PROFILE API
  // --------------------------------------------
  void callingGetProfile() async {
    print("hello world");
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: userId,
      };

      UserModel? userModel =
          await ApiMethods.getProfileApi(bodyParams: bodyParams);

      if (userModel != null &&
          userModel.status != '0' &&
          userModel.userData != null) {
        userDetails.value = userModel;
        inAsyncCall.value = false;
        print("userdetial are ${userDetails.value?.userData?.userName}");
      } else {
        CommonWidgets.snackBarView(
          title: userModel?.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      // CommonWidgets.snackBarView(title: 'Something went wrong...');
    }
  }
}
