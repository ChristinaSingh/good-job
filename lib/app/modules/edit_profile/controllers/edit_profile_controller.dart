import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/modules/profile/controllers/profile_controller.dart';
// Note: Replace these with your actual imports if they are different
import 'package:good_job/common/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_pickImage.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/image_pick_and_crop.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_user_model.dart';
import '../../../data/apis/api_models/update_profile_model.dart';
import '../../../data/constants/string_constants.dart';

class EditProfileController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController genderController = TextEditingController(); // REMOVED
  TextEditingController phoneController = TextEditingController();

  final isFullName = false.obs;
  final isEmail = false.obs;
  // final isGender = false.obs; // REMOVED - not needed for Dropdown
  final isPhone = false.obs;
  final selectImage = Rxn<File>();
  final isLoading = false.obs;
  final profileImage = ''.obs;

  // NEW: Observables for Gender Dropdown
  final RxList<String> genderOptions = ['Male', 'Female', 'Other'].obs;
  final RxString selectedGender = 'Male'.obs; // Default selected value

  Map<String, File> imageMap = {};
  Map<String, dynamic> bodyParamsForUpdateProfile = {};

  // Assuming UserData is passed as arguments
  UserData userData = Get.arguments;

  FocusNode focusFullName = FocusNode();
  FocusNode focusEmail = FocusNode();
  // FocusNode focusGender = FocusNode(); // REMOVED - not needed for Dropdown
  FocusNode focusPhone = FocusNode();
  late SharedPreferences sharedPreferences;

  void startListener() {
    focusFullName.addListener(onFocusChange);
    focusEmail.addListener(onFocusChange);
    // focusGender.addListener(onFocusChange); // REMOVED
    focusPhone.addListener(onFocusChange);
  }

  void onFocusChange() {
    isFullName.value = focusFullName.hasFocus;
    isEmail.value = focusEmail.hasFocus;
    // isGender.value = focusGender.hasFocus; // REMOVED
    isPhone.value = focusPhone.hasFocus;
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    startListener();
    setInitialValue();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // Clean up focus listeners
    focusFullName.removeListener(onFocusChange);
    focusEmail.removeListener(onFocusChange);
    focusPhone.removeListener(onFocusChange);

    // Dispose controllers and nodes
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    focusFullName.dispose();
    focusEmail.dispose();
    focusPhone.dispose();

    super.onClose();
  }

  void increment() => count.value++;

  void setInitialValue() {
    fullNameController.text = userData.userName ?? '';
    emailController.text = userData.email ?? '';
    phoneController.text = userData.mobile ?? '';

    // Set the initial gender from userData if available and valid
    String initialGender = userData.gender ?? 'Male';
    if (genderOptions.contains(initialGender)) {
      selectedGender.value = initialGender;
    } else {
      selectedGender.value = 'Male'; // Fallback
    }

    profileImage.value = userData.image ?? '';
  }

  // --- Image Picking Dialog Methods ---

  void showAlertDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // Assuming MyAlertDialog is a custom widget wrapper for CupertinoAlertDialog
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: cameraTextButtonView(),
              onPressed: () => clickCameraTextButtonView(),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: galleryTextButtonView(),
              onPressed: () => clickGalleryTextButtonView(),
            ),
          ],
          title: selectImageTextView(),
          content: contentTextView(),
        );
      },
    );
  }

  Widget selectImageTextView() => Text(
        StringConstants.selectImage,
        style: MyTextStyle.titleStyle18bb,
      );

  Widget contentTextView() => Text(
        StringConstants.chooseImageFromTheOptionsBelow,
        style: MyTextStyle.titleStyle14bb,
      );

  Widget cameraTextButtonView() => Text(
        StringConstants.camera,
        style: MyTextStyle.titleStyle10gr,
      );

  Widget galleryTextButtonView() => Text(
        StringConstants.gallery,
        style: MyTextStyle.titleStyle10gr,
      );

  Future<void> clickCameraTextButtonView() async {
    pickCamera();
    Get.back(); // Close the dialog
  }

  Future<void> clickGalleryTextButtonView() async {
    pickGallery();
    Get.back(); // Close the dialog
  }

  Future<void> pickCamera() async {
    selectImage.value = await ImagePickerAndCropper.pickImage(
      context: Get.context!,
      wantCropper: true,
      color: Theme.of(Get.context!).primaryColor,
    );
    increment(); // To force UI update if needed
  }

  Future<void> pickGallery() async {
    selectImage.value = await ImagePickerAndCropper.pickImage(
        context: Get.context!,
        wantCropper: true,
        color: Theme.of(Get.context!).primaryColor,
        pickImageFromGallery: true);
    increment(); // To force UI update if needed
  }

  // --- API Call Method ---

  Future<void> callingUpdateProfile() async {
    // Check all fields, including the selected gender
    if (fullNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        selectedGender.value.isNotEmpty) {
      try {
        if (selectImage.value != null) {
          imageMap = {
            ApiKeyConstants.image: selectImage.value ?? File(''),
          };
          bodyParamsForUpdateProfile = {
            ApiKeyConstants.userId: userData.id ?? '',
            ApiKeyConstants.userName: fullNameController.text.toString(),
            ApiKeyConstants.email: emailController.text.toString(),
            ApiKeyConstants.gender:
                selectedGender.value.toString(), // Use selectedGender
          };
        } else {
          // If no new image is selected, don't pass 'image' or pass empty string
          bodyParamsForUpdateProfile = {
            ApiKeyConstants.userId: userData.id ?? '',
            ApiKeyConstants.userName: fullNameController.text.toString(),
            ApiKeyConstants.gender:
                selectedGender.value.toString(), // Use selectedGender
            ApiKeyConstants.email: emailController.text.toString(),
            // ApiKeyConstants.image: '',
          };
          imageMap = {};
        }

        isLoading.value = true;
        print(
            "bodyParamsForUpdateProfileParams:::::$bodyParamsForUpdateProfile");

        // Assuming ApiMethods.updateProfileApi is the correct method
        UpdateProfileModel? userModel = await ApiMethods.updateProfileApi(
            bodyParams: bodyParamsForUpdateProfile, imageMap: imageMap);

        if (userModel != null && userModel.status != "0") {
          isLoading.value = false;
          print("hello word");
          ProfileController profileController = Get.find<ProfileController>();
          profileController.callingGetProfile();

          // CommonWidgets.showMyToastMessage(userModel.message!); // Uncomment if needed
          Get.back(result: true);
        } else {
          isLoading.value = false;
          print("Profile Update Failed....");
          // CommonWidgets.showMyToastMessage(userModel!.message!); // Uncomment if needed
        }
      } catch (e) {
        isLoading.value = false;
        print('Error :-${e.toString()}');
        CommonWidgets.showMyToastMessage(e.toString());
      }
    } else {
      CommonWidgets.showMyToastMessage('Please enter all fields...');
    }
  }
}
