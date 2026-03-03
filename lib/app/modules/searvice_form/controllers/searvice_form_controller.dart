import 'dart:async';
import 'dart:io';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:google_places_flutter_api/google_places_flutter_api.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_pickImage.dart';
import '../../../../common/image_pick_and_crop.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/add_booking_model.dart';

import '../../../data/apis/api_models/get_checkout_session_model.dart';
import '../../../data/constants/string_constants.dart';

class SearviceFormController extends GetxController {
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final EasyInfiniteDateTimelineController calender =
      EasyInfiniteDateTimelineController();
  DateTime focusDate = DateTime.now();

  final isLoading = false.obs;
  final email = 'user@example.com';

  Map<String, String?> parameters = Get.parameters;
  final count = 0.obs;
  final workingHours = 1.obs;
  String lat = '';
  String lon = '';
  List<File?> imageList = [null, null, null, null, null, null];

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
    jobDescriptionController.dispose();
    locationController.dispose();
    super.onClose();
  }

  void increment() => count.value++;

  void incrementWorkingHours() {
    workingHours.value++;
  }

  void decreaseWorkingHours() {
    if (workingHours.value > 1) {
      workingHours.value--;
    }
  }

  clickOnAllLocationsTextField() async {
    const googleApiKey = "AIzaSyDT62NXFvZu9qKdh96SkstdkV43cXadFyc";

    Prediction? p = await PlacesAutocomplete.show(
      context: Get.context!,
      apiKey: googleApiKey,
      mode: Mode.overlay,
    );
    if (p != null) {
      locationController.text = p.description ?? '';
      try {
        final locations = await locationFromAddress(p.description ?? '');
        if (locations.isNotEmpty) {
          lat = locations.first.latitude.toString();
          lon = locations.first.longitude.toString();
          print('Lat_Long :-$lat,$lon');
        }
      } catch (e) {
        CommonWidgets.showMyToastMessage('Error fetching coordinates.');
      }
    }
  }

  void showAlertDialog(int index) {
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
              onPressed: () => pickCamera(index),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                StringConstants.gallery,
                style: MyTextStyle.titleStyle12bb,
              ),
              onPressed: () => pickGallery(index),
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

  Future<void> pickCamera(int index) async {
    Get.back();
    final pickedFile = await ImagePickerAndCropper.pickImage(
      context: Get.context!,
      wantCropper: true,
      color: Theme.of(Get.context!).primaryColor,
    );
    if (pickedFile != null) {
      imageList[index] = pickedFile;
      increment();
    }
  }

  Future<void> pickGallery(int index) async {
    Get.back();
    final pickedFile = await ImagePickerAndCropper.pickImage(
        context: Get.context!,
        wantCropper: true,
        color: Theme.of(Get.context!).primaryColor,
        pickImageFromGallery: true);
    if (pickedFile != null) {
      imageList[index] = pickedFile;
      increment();
    }
  }

  void clickOnBookButton() async {
    List<File> fileList = [];
    for (var element in imageList) {
      if (element != null) {
        fileList.add(element);
      }
    }

    if (fileList.isEmpty) {
      CommonWidgets.showMyToastMessage('Please select at least one image.');
      return;
    }
    if (jobDescriptionController.text.isEmpty ||
        locationController.text.isEmpty) {
      CommonWidgets.showMyToastMessage(
          'Please fill all required details (description and location).');
      return;
    }
    if (lat.isEmpty || lon.isEmpty) {
      CommonWidgets.showMyToastMessage(
          'Location coordinates are missing. Please re-select the location.');
      return;
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString(ApiKeyConstants.userId);
    String? serviceId = parameters[ApiKeyConstants.serviceId];

    if (userId == null || serviceId == null) {
      CommonWidgets.showMyToastMessage(
          'User or Service information is missing. Cannot proceed.');
      return;
    }

    try {
      isLoading.value = true;

      Map<String, String> data = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.bookingDate: DateFormat('yyyy-MM-dd').format(focusDate),
        ApiKeyConstants.jobDescription: jobDescriptionController.text,
        ApiKeyConstants.workingHours: workingHours.value.toString(),
        ApiKeyConstants.location: locationController.text,
        ApiKeyConstants.lat: lat,
        ApiKeyConstants.lon: lon,
        ApiKeyConstants.serviceId: serviceId,
      };

      AddBookingModel? response =
          await ApiMethods.addBookingApi(bodyParams: data, imageList: fileList);

      if (response != null && response.status != '0') {
        isLoading.value = false;
        Get.offAndToNamed(Routes.BOOKING_SUCESS_POP_UP);
      } else {
        CommonWidgets.showMyToastMessage(
            response?.message ?? 'Booking failed. Please try again.');
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage(
          "An unexpected error occurred during booking.");
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> submitPayment(String bookingId) async {
  //   String userEmail = email.isNotEmpty ? email : 'dummy@gmail.com';
  //   String price = parameters[ApiKeyConstants.amount] ?? '0';
  //
  //   if (price == '0') {
  //     CommonWidgets.showMyToastMessage('Error: Service price is not set.');
  //     return;
  //   }
  //
  //   Map<String, String> queryParameters = {
  //     ApiKeyConstants.email: userEmail,
  //     ApiKeyConstants.price: price,
  //     ApiKeyConstants.bookingId: bookingId,
  //   };
  //
  //   isLoading.value = true;
  //   try {
  //     CheckOutSessionModel? checkOutSessionModel =
  //         await ApiMethods.createCheckOutSession(bodyParams: queryParameters);
  //     if (checkOutSessionModel != null &&
  //         checkOutSessionModel.data?.url != null) {
  //       Map<String, String> dataParameter = {
  //         ApiKeyConstants.url: checkOutSessionModel.data!.url!,
  //       };
  //
  //       dynamic resultUrl = await Get.toNamed(Routes.WEB_VIEW_PAYMENT,
  //           parameters: dataParameter);
  //
  //       if (resultUrl != null &&
  //           resultUrl is String &&
  //           resultUrl.contains('handle-checkout-success')) {
  //         Get.offNamed(Routes.WAITING_REQUEST);
  //       } else {
  //         CommonWidgets.showMyToastMessage('Payment was cancelled or failed.');
  //       }
  //     } else {
  //       CommonWidgets.showMyToastMessage('Failed to create payment session.');
  //     }
  //   } catch (e) {
  //     CommonWidgets.showMyToastMessage(
  //         'An unexpected error occurred during payment initiation.');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
