import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_booking_request_model.dart';
import '../../../data/apis/api_models/get_simple_model.dart';
import '../../../data/constants/string_constants.dart';
import '../../provider_booking/controllers/provider_booking_controller.dart';

class ProviderProjectDetailController extends GetxController {
  BookingRequestData bookingDetails = Get.arguments;
  var currentPage = 0.obs;
  var count = 0.obs;
  final isLoading = false.obs;
  final inAsyncCall = false.obs;

  // Controller for Final Price Input
  final amountController = TextEditingController();

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
    amountController.dispose();
    super.onClose();
  }

  void increment() => count.value++;

  void clickOnChat() {
    {
      Map<String, String> data = {
        ApiKeyConstants.receiverId: bookingDetails.userId ?? '',
        ApiKeyConstants.name: bookingDetails.name ?? '',
        ApiKeyConstants.image: bookingDetails.image ?? '',
      };
      Get.toNamed(Routes.TYPING, parameters: data);
    }
  }

  void clickOnViewButton() {
    Get.toNamed(Routes.PROVIDER_MAP, arguments: bookingDetails);
  }

  // Modified entry point for ACCEPT/DECLINE
  void clickOnAcceptRejectButton(String status) {
    if (status == 'ACCEPT') {
      showAmountInputDialog(); // Start the two-step acceptance flow
    } else {
      // Logic for DECLINE/CANCEL/INPROGRESS
      CommonWidgets.showAlertDialog(
        title: StringConstants.booking,
        content: 'Do you want to ${status.toLowerCase()} the booking request?',
        onPressedYes: () {
          Get.back();
          Future.delayed(Duration.zero, () {
            callingAcceptRejectBooking(status);
          });
        },
      );
    }
  }

  // 🚀 STEP 1: Show Final Price Input Dialog (LKR & Final Price)
  void showAmountInputDialog() {
    amountController.clear();
    Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.px)),
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        actionsPadding:
            EdgeInsets.symmetric(horizontal: 20.px, vertical: 15.px),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with Icon and Title
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.px, horizontal: 20.px),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.px),
                  topRight: Radius.circular(20.px),
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.request_quote_rounded,
                      color: Colors.green.shade700, size: 38.px),
                  SizedBox(height: 8.px),
                  Text(
                    'Input Final Price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.px,
                        color: Colors.green.shade900),
                  ),
                ],
              ),
            ),

            // Input Area
            Padding(
              padding: EdgeInsets.all(20.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please input the **final agreed price** to accept the booking:',
                    style:
                        TextStyle(fontSize: 14.px, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 15.px),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    style: TextStyle(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: 'e.g., 5000 LKR',
                      labelText: 'Final Price',
                      prefixText: 'LKR ',
                      prefixStyle: TextStyle(
                          fontSize: 16.px, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.px),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.px),
                        borderSide:
                            BorderSide(color: Colors.green.shade600, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.px, vertical: 16.px),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 15.px),
            ),
            child: Text('Cancel',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 15.px)),
          ),
          // Next Button
          ElevatedButton(
            onPressed: () {
              if (amountController.text.trim().isEmpty ||
                  double.tryParse(amountController.text.trim()) == null) {
                CommonWidgets.showMyToastMessage('Please enter a valid price.');
                return;
              }
              Get.back(); // Close price dialog
              showConfirmationDialog(amountController.text.trim());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.px)),
              padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 12.px),
            ),
            child: Text('Next (Confirm)',
                style: TextStyle(color: Colors.white, fontSize: 15.px)),
          ),
        ],
      ),
    );
  }

  // 🚀 STEP 2: Show Confirmation Dialog (LKR & Final Price)
  void showConfirmationDialog(String finalAmount) {
    Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.px)),
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.fromLTRB(20.px, 25.px, 20.px, 0),
        contentPadding: EdgeInsets.fromLTRB(20.px, 15.px, 20.px, 10.px),
        actionsPadding:
            EdgeInsets.symmetric(horizontal: 20.px, vertical: 15.px),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.orange.shade700, size: 28.px),
            SizedBox(width: 10.px),
            Text('Confirm Acceptance',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.px)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey.shade300, thickness: 1.px),
            SizedBox(height: 10.px),
            Text(
              'Are you sure you want to accept this booking?',
              style: TextStyle(fontSize: 15.px, color: Colors.black87),
            ),
            SizedBox(height: 10.px),
            Container(
              padding: EdgeInsets.all(10.px),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10.px),
              ),
              child: Row(
                children: [
                  Icon(Icons.price_change_outlined,
                      color: Colors.blue.shade700, size: 20.px),
                  SizedBox(width: 8.px),
                  Text(
                    'Final Price:',
                    style: TextStyle(
                        fontSize: 14.px,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade900),
                  ),
                  SizedBox(width: 5.px),
                  Text(
                    'LKR $finalAmount',
                    style: TextStyle(
                        fontSize: 15.px,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Review Quote Button
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 15.px),
            ),
            child: Text('No, Review Price',
                style: TextStyle(color: Colors.redAccent, fontSize: 15.px)),
          ),
          // Accept Button
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close confirmation dialog
              callingAcceptRejectBooking('ACCEPT', amount: finalAmount);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.shade500,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.px)),
              padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 12.px),
            ),
            child: Text('Yes, Accept Booking',
                style: TextStyle(color: Colors.white, fontSize: 15.px)),
          ),
        ],
      ),
    );
  }

  // Updated: API method now updates local status and amount
  void callingAcceptRejectBooking(String status, {String? amount}) async {
    inAsyncCall.value = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString(ApiKeyConstants.userId) ?? '';
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.bookingId: bookingDetails.bookingRequestId ?? '',
        ApiKeyConstants.status: status,
        ApiKeyConstants.providerId: userId,
      };

      // Conditionally add the amount field for ACCEPT status
      if (status == 'ACCEPT' && amount != null) {
        bodyParams[ApiKeyConstants.amount] = amount;
      }

      SimpleModel? simpleModel = await ApiMethods.acceptRejectBookingRequestApi(
          bodyParams: bodyParams);

      if (simpleModel != null && simpleModel.status != '0') {
        CommonWidgets.showMyToastMessage(
            simpleModel.message ?? 'Booking Status Updated Successfully!');

        // Crucial Step 1: Update local status
        bookingDetails.bookingRequestStatus = status;

        // Update the amount locally if it was sent
        if (status == 'ACCEPT' && amount != null) {
          bookingDetails.amount = amount;
        }

        // Crucial Step 2: Trigger UI update
        increment();

        // Optionally refresh the main list
        if (status == 'CANCEL' &&
            Get.isRegistered<ProviderBookingController>()) {
          Get.find<ProviderBookingController>().fetchAllBookings();
          Get.back();
        }
      } else {
        CommonWidgets.showMyToastMessage(
            simpleModel?.message ?? 'Failed to update booking status.');
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage('An error occurred during API call: $e');
    } finally {
      inAsyncCall.value = false;
    }
  }

  // Updated: Start Job button now updates local status and UI
  void clickOnStartJobButton() async {
    inAsyncCall.value = true;
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.bookingId: bookingDetails.bookingRequestId ?? '',
        ApiKeyConstants.status: 'INPROGRESS'
      };

      SimpleModel? simpleModel = await ApiMethods.acceptRejectBookingRequestApi(
          bodyParams: bodyParams);

      if (simpleModel != null && simpleModel.status != '0') {
        CommonWidgets.showMyToastMessage(
            simpleModel.message ?? 'Work Started!');

        // Crucial Step 1: Update local status
        bookingDetails.bookingRequestStatus = 'INPROGRESS';

        // Crucial Step 2: Trigger UI update
        increment();
      } else {
        CommonWidgets.showMyToastMessage(simpleModel!.message!);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage('An error occurred: $e');
    } finally {
      inAsyncCall.value = false;
    }
  }

  void clickOnEndJobButton() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.bookingId: bookingDetails.bookingRequestId ?? '',
        ApiKeyConstants.providerId: bookingDetails.providerId ?? '',
        ApiKeyConstants.amount: bookingDetails.amount ?? ''
      };
      inAsyncCall.value = true;
      SimpleModel? simpleModel =
          await ApiMethods.collectBookingAmountApi(bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != '0') {
        CommonWidgets.showMyToastMessage("Booking Completed Successfully!");

        // Update local status for consistency, though it will navigate away
        bookingDetails.bookingRequestStatus = 'COMPLETED';
        increment();

        if (Get.isRegistered<ProviderBookingController>()) {
          Get.find<ProviderBookingController>().fetchAllBookings();
        }

        Future.delayed(const Duration(seconds: 3), () {
          // Navigate back to the main booking list or dashboard
          Get.until((route) =>
              Get.currentRoute == Routes.PROVIDER_BOOKING || route.isFirst);
        });
      } else {

        CommonWidgets.showMyToastMessage(simpleModel!.message!);
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
  }
}
