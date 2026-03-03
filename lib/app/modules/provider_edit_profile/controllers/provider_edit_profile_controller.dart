import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:good_job/app/modules/provider_profile/controllers/provider_profile_controller.dart';
import 'package:google_places_flutter_api/google_places_flutter_api.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../../../../common/common_pickImage.dart'; // Ensure this import is correct
import '../../../../common/common_widgets.dart';
import '../../../../common/image_pick_and_crop.dart';
import '../../../../common/local_data.dart';
import '../../../../common/text_styles.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_user_model.dart';
import '../../../data/apis/api_models/update_profile_model.dart';
import '../../../data/constants/string_constants.dart';

class ProviderEditProfileController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobRoleController = TextEditingController();
  TextEditingController chargeController = TextEditingController();
  TextEditingController specialQualificationController =
      TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final isFullName = false.obs;
  final isEmail = false.obs;
  final isJobRole = false.obs;
  final isCharge = false.obs;
  final isPhone = false.obs;
  final isQualification = false.obs;
  final isLocation = false.obs;
  final isDescription = false.obs;
  final inAsyncCall = false.obs;
  String selectedJobId = '';

  FocusNode focusFullName = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusPhone = FocusNode();
  FocusNode focusJobRole = FocusNode();
  FocusNode focusCharge = FocusNode();
  FocusNode focusQualification = FocusNode();
  FocusNode focusLocation = FocusNode();
  FocusNode focusDescription = FocusNode();

  void startListener() {
    focusFullName.addListener(onFocusChange);
    focusEmail.addListener(onFocusChange);
    focusPhone.addListener(onFocusChange);
    focusJobRole.addListener(onFocusChange);
    focusCharge.addListener(onFocusChange);
    focusQualification.addListener(onFocusChange);
    focusLocation.addListener(onFocusChange);
    focusDescription.addListener(onFocusChange);
  }

  void onFocusChange() {
    isFullName.value = focusFullName.hasFocus;
    isEmail.value = focusEmail.hasFocus;
    isPhone.value = focusPhone.hasFocus;
    isJobRole.value = focusJobRole.hasFocus;
    isCharge.value = focusCharge.hasFocus;
    isQualification.value = focusQualification.hasFocus;
    isLocation.value = focusLocation.hasFocus;
    isDescription.value = focusDescription.hasFocus;
  }

  List<File?> imageList = [null, null, null, null, null, null, null, null];
  final count = 0.obs;
  final checkValue = 0.obs;
  final selectImage = Rxn<File>();
  final profileImage = ''.obs;
  String lat = '';
  String lon = '';
  UserModel userDetails = Get.arguments;

  // NEW: Observables for certificates and ID/License
  final selectedProfessionalCertificate = Rxn<File>();
  final selectedIDLicense = Rxn<File>();

  // NEW: Initial document image URLs (if loaded from existing profile)
  final professionalCertificateImageUrl = ''.obs;
  final idLicenseImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setInitialData();
    startListener();
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
  void setInitialData() {
    fullNameController.text = userDetails.userData?.userName ?? '';
    emailController.text = userDetails.userData?.email ?? '';
    phoneController.text = userDetails.userData?.mobile ?? '';
    selectedJobId = userDetails.userData?.jobRoleService ?? '';
    selectServices(selectedJobId);
    chargeController.text = userDetails.userData?.perHourCharge ?? '';
    specialQualificationController.text =
        userDetails.userData?.specialQualification ?? '';
    descriptionController.text = userDetails.userData?.description ?? '';
    locationController.text = userDetails.userData?.address ?? '';
    lat = userDetails.userData?.lat ?? '';
    lon = userDetails.userData?.lon ?? '';
    profileImage.value = userDetails.userData?.image ?? '';

    // NEW: Set initial image URLs for certificates and ID if available
    professionalCertificateImageUrl.value =
        userDetails.userData?.professionalCertificate ?? '';
    idLicenseImageUrl.value = userDetails.userData?.drivingLicense ?? '';

    print(
        'Professional Certificate: ${userDetails.userData?.professionalCertificate ?? 'N/A'}');
    print('Driving License: ${userDetails.userData?.drivingLicense ?? 'N/A'}');
  }

  void selectServices(String id) {
    for (int i = 0; i < LocalData.categoryList.length; i++) {
      if (LocalData.categoryList[i]['ser_id'] == id) {
        jobRoleController.text =
            LocalData.categoryList[i]['service_name'] ?? '';
        break;
      }
    }
  }

  // Modified showAlertDialog to handle new document types
  void showAlertDialog(int index, {String? docType}) {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                StringConstants.camera,
                style: MyTextStyle.titleStyle12bb,
              ),
              onPressed: () => pickCamera(index, docType: docType),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                StringConstants.gallery,
                style: MyTextStyle.titleStyle12bb,
              ),
              onPressed: () => pickGallery(index, docType: docType),
            ),
          ],
          title: Text(
            StringConstants.selectImage,
            style: MyTextStyle.titleStyle18bb,
          ),
          content: Text(
            StringConstants.chooseImageFromTheOptionsBelow,
            style: MyTextStyle.titleStyle14bb,
          ),
        );
      },
    );
  }

  // Modified pickCamera to handle new document types
  Future<void> pickCamera(int index, {String? docType}) async {
    Get.back();
    File? pickedFile = await ImagePickerAndCropper.pickImage(
      context: Get.context!,
      wantCropper: true,
      color: Theme.of(Get.context!).primaryColor,
    );

    if (pickedFile != null) {
      if (docType == 'certificate') {
        selectedProfessionalCertificate.value = pickedFile;
      } else if (docType == 'id_license') {
        selectedIDLicense.value = pickedFile;
      } else if (index == -1) {
        selectImage.value = pickedFile;
      } else {
        imageList[index] = pickedFile;
      }
    }
    increment(); // To trigger UI rebuild
  }

  // Modified pickGallery to handle new document types
  Future<void> pickGallery(int index, {String? docType}) async {
    Get.back();
    File? pickedFile = await ImagePickerAndCropper.pickImage(
      context: Get.context!,
      wantCropper: true,
      color: Theme.of(Get.context!).primaryColor,
      pickImageFromGallery: true,
    );

    if (pickedFile != null) {
      if (docType == 'certificate') {
        selectedProfessionalCertificate.value = pickedFile;
      } else if (docType == 'id_license') {
        selectedIDLicense.value = pickedFile;
      } else if (index == -1) {
        selectImage.value = pickedFile;
      } else {
        imageList[index] = pickedFile;
      }
    }
    increment(); // To trigger UI rebuild
  }

  clickOnAllLocationsTextField() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: Get.context!,
      apiKey:
          "AIzaSyDT62NXFvZu9qKdh96SkstdkV43cXadFyc", // Use the constant you defined
      mode: Mode.overlay,
    );
    if (p != null) {
      locationController.text = p.description ?? '';
      final locations = await locationFromAddress(p.description ?? '');
      lat = locations.first.latitude.toString();
      lon = locations.first.longitude.toString();
      print('Lat_Long :-$lat,$lon');
    }
  }

  void selectJobsRoles() {
    showModalBottomSheet(
      context: Get.context!,
      constraints: BoxConstraints(maxHeight: 500.px, minHeight: 300.px),
      isScrollControlled: false,
      backgroundColor: primary3Color,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.px,
              ),
              Center(
                child: Text(
                  StringConstants.selectJobRole.tr,
                  style: MyTextStyle.titleStyle16gr,
                ),
              ),
              SizedBox(
                height: 20.px,
              ),
              Expanded(
                // Added Expanded to make the ListView scrollable
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: LocalData.categoryList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.back();
                          selectedJobId =
                              LocalData.categoryList[index]['ser_id'] ?? '';
                          jobRoleController.text = LocalData.categoryList[index]
                                  ['service_name'] ??
                              '';
                        },
                        child: Container(
                          height: 40.px,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.px, vertical: 5.px),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.px,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.px),
                              border: Border.all(
                                  color: selectedJobId ==
                                          LocalData.categoryList[index]
                                              ['ser_id']
                                      ? primaryColor
                                      : primary3Color)),
                          child: Text(
                            '${LocalData.categoryList[index]['service_name']}',
                            style: MyTextStyle.titleStyle14bb,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> clickOnSubmitButton() async {
    List<File> serviceGalleryImages = [];
    imageList.forEach((element) {
      if (element != null) {
        serviceGalleryImages.add(element);
      }
    });

    print(
        "Profile Image: ${selectImage.value?.path ?? 'No profile image selected'}");
    print(
        "Professional Certificate: ${selectedProfessionalCertificate.value?.path ?? 'No certificate selected'}");
    print(
        "Driving License: ${selectedIDLicense.value?.path ?? 'No ID license selected'}");

    Map<String, File?> imageMap = {
      ApiKeyConstants.image: selectImage.value,
      'professional_certificates': selectedProfessionalCertificate.value,
      'driving_license': selectedIDLicense.value,
    };

    if (fullNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        jobRoleController.text.isNotEmpty &&
        specialQualificationController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        locationController.text.isNotEmpty) {
      try {
        Map<String, dynamic> postAddParameters = {
          ApiKeyConstants.userId: userDetails.userData?.id ?? '',
          ApiKeyConstants.userName: fullNameController.text,
          ApiKeyConstants.email: emailController.text,
          ApiKeyConstants.jobRoleService: selectedJobId,
          ApiKeyConstants.perHourCharge: chargeController.text,
          ApiKeyConstants.specialQualification:
              specialQualificationController.text,
          ApiKeyConstants.description: descriptionController.text,
          ApiKeyConstants.address: locationController.text,
          ApiKeyConstants.lat: lat,
          ApiKeyConstants.lon: lon,
        };

        inAsyncCall.value = true;

        print("POST Parameters: $postAddParameters");
        print("Gallery Images Count: ${serviceGalleryImages.length}");
        print(
            "Gallery Images Paths: ${serviceGalleryImages.map((e) => e.path).toList()}");
        UpdateProfileModel? response = await ApiMethods.updateProfileApi(
          bodyParams: postAddParameters,
          serviceImages: serviceGalleryImages,
          imageMap: imageMap,
        );

        print("API Response Message: ${response?.message}");
        inAsyncCall.value = false;

        if (response != null && response.status != '0') {
          CommonWidgets.showMyToastMessage('Profile updated successfully ...');
          ProviderProfileController profileController =
              Get.find<ProviderProfileController>();
          profileController.callingGetProfile();
          Get.back(result: true);
        } else {
          CommonWidgets.showMyToastMessage(response?.message ?? '');
        }
      } catch (e) {
        inAsyncCall.value = false;
        print("Error:- ${e.toString()}");
      }
    } else {
      CommonWidgets.showMyToastMessage('Please fill all required fields.');
    }
  }
}
