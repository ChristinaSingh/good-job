import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_user_model.dart';
import '../../../data/constants/string_constants.dart';

class OtpVerificationController extends GetxController {
  TextEditingController pin = TextEditingController();
  Map<String, String?> parameters = Get.parameters;
  final count = 0.obs;
  final showLoading = false.obs;
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    requestNotificationPermission();
  }

  Future<void> requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      getDeviceToken();
    } else {
      print("User denied notification permission");
    }
  }

  Future<void> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      if (GetPlatform.isAndroid) {
        deviceToken = await messaging.getToken();
        print('Android Device Token: $deviceToken');
      } else if (GetPlatform.isIOS) {
        String? apnsToken;
        while (apnsToken == null) {
          apnsToken = await messaging.getAPNSToken();
          if (apnsToken == null) {
            await Future.delayed(const Duration(seconds: 1));
          }
        }
        print("APNS Token: $apnsToken");
        deviceToken = await messaging.getToken();
        print("Firebase Token: $deviceToken");
      }
    } catch (e) {
      print("Error getting device token: $e");
    }
  }

  // void clickOnOtpVerificationButton() async {
  //   if (pin.text.trim().isNotEmpty) {
  //     try {
  //       showLoading.value = true;
  //       Map<String, String> bodyParams = {
  //         ApiKeyConstants.mobile: parameters[ApiKeyConstants.mobile] ?? '',
  //         ApiKeyConstants.countryCode:
  //             parameters[ApiKeyConstants.countryCode] ?? '',
  //         ApiKeyConstants.otp: pin.text.toString(),
  //         ApiKeyConstants.type: parameters[ApiKeyConstants.type] ?? 'USER',
  //         ApiKeyConstants.deviceToken: deviceToken.toString() ?? '',
  //       };
  //
  //       UserModel? userModel =
  //           await ApiMethods.otpVerificationApi(bodyParams: bodyParams);
  //
  //       if (userModel != null &&
  //           userModel.status != '0' &&
  //           userModel.userData != null) {
  //         SharedPreferences sp = await SharedPreferences.getInstance();
  //
  //         if (userModel.userData!.type == 'USER') {
  //           CommonWidgets.showMyToastMessage("Login Successful");
  //           sp.setString(ApiKeyConstants.userId, userModel.userData!.id ?? '');
  //           sp.setString(ApiKeyConstants.type, userModel.userData!.type ?? '');
  //           sp.setString(
  //               ApiKeyConstants.email, userModel.userData!.email ?? '');
  //           Get.offAllNamed(Routes.SPLASH);
  //         } else {
  //           CommonWidgets.showMyToastMessage("Login Successful");
  //           if (userModel.status != '0' && userModel.userData != null) {
  //             sp.setString(
  //                 ApiKeyConstants.userId, userModel.userData!.id ?? '');
  //             sp.setString(
  //                 ApiKeyConstants.type, userModel.userData!.type ?? '');
  //             sp.setString(
  //                 ApiKeyConstants.email, userModel.userData!.email ?? '');
  //             Get.offAllNamed(Routes.SPLASH);
  //
  //             // } else {
  //             //   Map<String, String> data = {
  //             //     ApiKeyConstants.userId: userModel.userData!.id ?? '',
  //             //     ApiKeyConstants.mobile: userModel.userData!.mobile ?? '',
  //             //   };
  //             //   if (userModel.userData!.step == '1') {
  //             //     Get.offNamed(Routes.CREATE_YOUR_PROFILE, parameters: data);
  //             //   } else {
  //             //     Get.offNamed(Routes.PROVIDER_DOCUMERNT, parameters: data);
  //             //   }
  //           }
  //         }
  //       } else {
  //         CommonWidgets.snackBarView(title: userModel!.message!);
  //       }
  //     } catch (e) {
  //       print("Error: $e");
  //     } finally {
  //       showLoading.value = false;
  //     }
  //   } else {
  //     CommonWidgets.snackBarView(title: StringConstants.allFieldsRequired);
  //   }
  // }

  void clickOnOtpVerificationButton() async {
    if (pin.text.trim().isEmpty) {
      CommonWidgets.snackBarView(title: StringConstants.allFieldsRequired);
      return;
    }

    try {
      showLoading.value = true;

      Map<String, String> bodyParams = {
        ApiKeyConstants.mobile: parameters[ApiKeyConstants.mobile] ?? '',
        ApiKeyConstants.countryCode:
            parameters[ApiKeyConstants.countryCode] ?? '',
        ApiKeyConstants.otp: pin.text.trim(),
        ApiKeyConstants.type: parameters[ApiKeyConstants.type] ?? 'USER',
        ApiKeyConstants.deviceToken: deviceToken ?? '',
      };

      UserModel? userModel =
          await ApiMethods.otpVerificationApi(bodyParams: bodyParams);

      if (userModel == null) {
        CommonWidgets.snackBarView(title: "Something went wrong");
        return;
      }

      if (userModel.status == '0' || userModel.userData == null) {
        CommonWidgets.snackBarView(title: userModel.message ?? "Login failed");
        return;
      }

      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(ApiKeyConstants.userId, userModel.userData!.id ?? '');
      sp.setString(ApiKeyConstants.type, userModel.userData!.type ?? '');
      sp.setString(ApiKeyConstants.email, userModel.userData!.email ?? '');

      CommonWidgets.showMyToastMessage("Login Successful");

      if (userModel.userData!.type == 'USER') {
        // Regular user → go to splash/main screen
        Get.offAllNamed(Routes.SPLASH);
      } else {
        // PROVIDER flow
        String step = userModel.userData!.step ?? '0';
        Map<String, String> data = {
          ApiKeyConstants.userId: userModel.userData!.id ?? '',
          ApiKeyConstants.mobile: userModel.userData!.mobile ?? '',
        };

        if (step == '1') {
          // Step 1 → Create Profile
          Get.offNamed(Routes.CREATE_YOUR_PROFILE, parameters: data);
        } else if (step == '2') {
          // Step 2 → Upload documents
          Get.offNamed(Routes.PROVIDER_DOCUMERNT, parameters: data);
        } else {
          // Step 3 or higher → Provider NavBar / main screen
          Get.offAllNamed(Routes.PROVIDER_NAV_BAR);
        }
      }
    } catch (e) {
      print("OTP Error: $e");
      CommonWidgets.snackBarView(title: "Something went wrong");
    } finally {
      showLoading.value = false;
    }
  }

  // void clickOnOtpVerificationButton() async {
  //   if (pin.text.trim().isEmpty) {
  //     CommonWidgets.snackBarView(title: StringConstants.allFieldsRequired);
  //     return;
  //   }
  //
  //   try {
  //     showLoading.value = true;
  //
  //     Map<String, String> bodyParams = {
  //       ApiKeyConstants.mobile: parameters[ApiKeyConstants.mobile] ?? '',
  //       ApiKeyConstants.countryCode:
  //           parameters[ApiKeyConstants.countryCode] ?? '',
  //       ApiKeyConstants.otp: pin.text.trim(),
  //       ApiKeyConstants.type: parameters[ApiKeyConstants.type] ?? 'USER',
  //       ApiKeyConstants.deviceToken: deviceToken ?? '',
  //     };
  //
  //     UserModel? userModel =
  //         await ApiMethods.otpVerificationApi(bodyParams: bodyParams);
  //
  //     if (userModel == null) {
  //       CommonWidgets.snackBarView(title: "Something went wrong");
  //       return;
  //     }
  //
  //     if (userModel.status == '0' || userModel.userData == null) {
  //       CommonWidgets.snackBarView(title: userModel.message ?? "Login failed");
  //       return;
  //     }
  //
  //     SharedPreferences sp = await SharedPreferences.getInstance();
  //
  //     sp.setString(ApiKeyConstants.userId, userModel.userData!.id ?? '');
  //     sp.setString(ApiKeyConstants.type, userModel.userData!.type ?? '');
  //     sp.setString(ApiKeyConstants.email, userModel.userData!.email ?? '');
  //
  //     CommonWidgets.showMyToastMessage("Login Successful");
  //
  //     if (userModel.userData!.type == 'USER') {
  //       Get.offAllNamed(Routes.SPLASH);
  //     } else {
  //       if (userModel.userData!.step == '1') {
  //         Map<String, String> data = {
  //           ApiKeyConstants.userId: userModel.userData!.id ?? '',
  //           ApiKeyConstants.mobile: userModel.userData!.mobile ?? '',
  //         };
  //         Get.offNamed(Routes.CREATE_YOUR_PROFILE, parameters: data);
  //       } else {
  //         Map<String, String> data = {
  //           ApiKeyConstants.userId: userModel.userData!.id ?? '',
  //           ApiKeyConstants.mobile: userModel.userData!.mobile ?? '',
  //         };
  //         Get.offNamed(Routes.PROVIDER_DOCUMERNT, parameters: data);
  //       }
  //     }
  //   } catch (e) {
  //     print("OTP Error: $e");
  //   } finally {
  //     showLoading.value = false;
  //   }
  // }
}
