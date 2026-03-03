import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_booking_request_model.dart';
import 'package:good_job/app/data/apis/api_models/get_simple_model.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';

class ProviderHomeController extends GetxController {
  TextEditingController bidAmountController = TextEditingController();
  final count = 0.obs;
  final inAsyncCall = false.obs;
  String userId = '';
  List<BookingRequestData> bookingRequest = [];
  Timer? _timer;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';

    // Initial data fetch with loader
    callingBookingRequestList(showLoader: true);

    // Start periodic updates every 10 seconds without showing the loader
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      callingBookingRequestList(showLoader: false);
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel timer when the controller is disposed
    super.onClose();
  }

  void increment() => count.value++;

  void clickOnNotification() {
    Get.toNamed(Routes.NOTIFICATION);
  }

  void clickOnProject(int index) {
    Get.toNamed(Routes.PROVIDER_PROJECT_DETAIL,
        arguments: bookingRequest[index]);
  }

  void clickOnViewButton(int index) {
    Get.toNamed(Routes.PROVIDER_MAP, arguments: bookingRequest[index]);
  }

  void showAlertBoxForBid(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 280.px,
            child: Padding(
              padding: EdgeInsets.all(15.px),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 20.px,
                      color: Colors.redAccent,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      StringConstants.bid,
                      style: MyTextStyle.titleStyle20bb,
                    ),
                  ),
                  SizedBox(height: 20.px),
                  CommonWidgets.commonTextFieldForLoginSignUP(
                    hintText: StringConstants.enterAmount,
                    controller: bidAmountController,
                    isCard: true,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 30.px),
                  CommonWidgets.commonElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      StringConstants.save,
                      style: MyTextStyle.titleStyle16bw,
                    ),
                    buttonMargin: EdgeInsets.symmetric(
                        horizontal: 25.px, vertical: 10.px),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Fetches the booking request list. Shows loader only when manually refreshed.
  Future<void> callingBookingRequestList({bool showLoader = true}) async {
    try {
      if (showLoader) {
        inAsyncCall.value = true; // Show loader only for manual refresh
      }

      Map<String, String> bodyParams = {
        ApiKeyConstants.providerId: userId,
      };

      BookingRequestModel? getProviderBookingRequest =
          await ApiMethods.getProviderBookingRequest(bodyParams: bodyParams);
      if (getProviderBookingRequest != null &&
          getProviderBookingRequest.status != '0' &&
          getProviderBookingRequest.data != null) {
        // Update only if new data is different from the existing one
        if (bookingRequest.length != getProviderBookingRequest.data!.length) {
          bookingRequest = getProviderBookingRequest.data!;
          update(); // Notify UI about changes
        }
      } else {
        bookingRequest = [];
      }
    } catch (e) {
      if (showLoader) {
        CommonWidgets.showMyToastMessage('Something went wrong...');
      }
    } finally {
      if (showLoader) {
        inAsyncCall.value = false;
      }
    }
  }

  void clickOnAcceptRejectButton(int index, String status) {
    CommonWidgets.showAlertDialog(
      title: StringConstants.booking,
      content: 'Do you want to $status booking request?',
      onPressedYes: () {
        Get.back();
        Future.delayed(Duration.zero, () {
          callingAcceptRejectBooking(index, status);
        });
      },
    );
  }

  Future<void> callingAcceptRejectBooking(int index, String status) async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.bookingId: bookingRequest[index].bookingRequestId ?? '',
        ApiKeyConstants.status: status,
      };

      inAsyncCall.value = true;

      SimpleModel? simpleModel = await ApiMethods.acceptRejectBookingRequestApi(
          bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != '0') {
        bookingRequest.removeAt(index);
        increment();
        // CommonWidgets.showMyToastMessage(simpleModel.message ?? 'Booking request updated successfully');
      } else {
        // CommonWidgets.showMyToastMessage(simpleModel?.message ?? 'Failed to update the booking request');
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage('Something went wrong...');
    } finally {
      inAsyncCall.value = false;
    }
  }
}
