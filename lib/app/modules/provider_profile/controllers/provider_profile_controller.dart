import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_user_model.dart';
import '../../../data/constants/icons_constant.dart';
import '../../../data/constants/string_constants.dart';
import '../../../routes/app_pages.dart';

class ProviderProfileController extends GetxController {
  List<Map<String, String>> itemList = [
    {'image': IconConstants.icProfileCircle, 'title': StringConstants.profile},
    {'image': IconConstants.icPayment, 'title': StringConstants.wallet},
    {
      'image': IconConstants.icNotificationCircle,
      'title': StringConstants.notifications
    },
    {'image': IconConstants.icSupport, 'title': StringConstants.support},
    {'image': IconConstants.icSupport, 'title': StringConstants.contactUs},
    {'image': IconConstants.icAboutUs, 'title': StringConstants.aboutUs},
    {
      'image': IconConstants.icPrivacyPolicy,
      'title': StringConstants.privacyPolicy
    },
    {'image': IconConstants.icLogout, 'title': StringConstants.logout}
  ];

  final count = 0.obs;
  final inAsyncCall = true.obs;

  String userId = '';

  /// Make userDetails reactive
  Rxn<UserModel> userDetails = Rxn<UserModel>();

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';
    super.onInit();
    callingGetProfile();
  }

  void clickOnItem(int index) async {
    switch (index) {
      case 0:
        dynamic result = await Get.toNamed(
          Routes.PROVIDER_EDIT_PROFILE,
          arguments: userDetails.value,
        );
        if (result != null && result) {
          callingGetProfile();
        }
        break;
      case 1:
        Get.toNamed(Routes.PROVIDER_WALLET);
        break;
      case 2:
        Get.toNamed(Routes.NOTIFICATION_SETTING, arguments: userDetails.value)
            ?.then((_) {
          callingGetProfile();
        });

        break;
      case 3:
        Get.toNamed(Routes.SUPPORT);
        break;
      case 4:
        Get.toNamed(Routes.CONTACT_US);
        break;
      case 5:
        Get.toNamed(Routes.ABOUT_US);
        break;
      case 6:
        Get.toNamed(Routes.PRIVACY_POLICY);
        break;
      case 7:
        CommonWidgets.showAlertDialog(
          onPressedYes: () => clickOnYes(),
        );
        break;
    }
  }

  clickOnYes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(ApiKeyConstants.token, '');
    sharedPreferences.clear();
    Get.offAllNamed(Routes.SPLASH);
  }

  void callingGetProfile() async {
    try {
      Map<String, String> bodyParams = {ApiKeyConstants.userId: userId};
      UserModel? userModel =
          await ApiMethods.getProfileApi(bodyParams: bodyParams);

      if (userModel != null &&
          userModel.status != '0' &&
          userModel.userData != null) {
        userDetails.value = userModel;
        inAsyncCall.value = false;
      } else {
        CommonWidgets.snackBarView(title: userModel!.message!);
      }
    } catch (e) {
      CommonWidgets.snackBarView(title: 'Something went wrong ...');
    }
  }
}
