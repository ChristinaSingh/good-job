import 'dart:async';

import 'package:get/get.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:good_job/common/local_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_booking_request_model.dart';
import '../../../data/apis/api_models/get_simple_model.dart';
import '../../../data/constants/string_constants.dart';

class BookingController extends GetxController {
  final tabIndex = 0.obs;
  final count = 0.obs;
  final inAsyncCall = true.obs;
  List<BookingRequestData> processingBooking = [];
  List<BookingRequestData> completeBooking = [];
  List<BookingRequestData> rejectBooking = [];
  String userId = '';
  Timer? _timer;
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';
    super.onInit();
    callingBookingRequestList();
    callingCompleteBookingList();
    callingCancelBookingList();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      callingBookingRequestList();
      callingCompleteBookingList();
      callingCancelBookingList();
    });
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
  void clickOnMessageIcon(int index) {
    switch (tabIndex.value) {
      case 0:
        {
          Map<String, String> data = {
            ApiKeyConstants.receiverId:
                processingBooking[index].providerId ?? '',
            ApiKeyConstants.name: processingBooking[index].name ?? '',
            ApiKeyConstants.image: processingBooking[index].image ?? '',
          };
          Get.toNamed(Routes.TYPING, parameters: data);
          break;
        }
      case 1:
        {
          Map<String, String> data = {
            ApiKeyConstants.receiverId: completeBooking[index].providerId ?? '',
            ApiKeyConstants.name: completeBooking[index].name ?? '',
            ApiKeyConstants.image: completeBooking[index].image ?? '',
          };
          Get.toNamed(Routes.TYPING, parameters: data);
          break;
        }
      case 2:
        {
          Map<String, String> data = {
            ApiKeyConstants.receiverId: rejectBooking[index].providerId ?? '',
            ApiKeyConstants.name: rejectBooking[index].name ?? '',
            ApiKeyConstants.image: rejectBooking[index].image ?? '',
          };
          Get.toNamed(Routes.TYPING, parameters: data);
          break;
        }
    }
  }

  void clickOnProcessingBookingProfile(int index) {
    Get.toNamed(Routes.BOOKING_TACKING, arguments: processingBooking[index]);
  }

  void clickOnCompleteBookingProfile(int index) {
    Get.toNamed(Routes.BOOKING_TACKING, arguments: completeBooking[index]);
  }

  void clickOnCancelBookingProfile(int index) {
    Get.toNamed(Routes.BOOKING_TACKING, arguments: rejectBooking[index]);
  }

  Future<void> pullRefresh() async {
    inAsyncCall.value = true;
    if (tabIndex.value == 0) {
      callingBookingRequestList();
    } else {
      if (tabIndex.value == 1) {
        callingCompleteBookingList();
      } else {
        callingCancelBookingList();
      }
    }
  }

  void changeUpDown(int index) {
    processingBooking[index].upDown =
        !(processingBooking[index].upDown ?? false);
    increment();
  }

  void clickOnAcceptRejectButton(int index) {
    CommonWidgets.showAlertDialog(
      title: StringConstants.booking,
      content: 'Do you want to cancel booking request?',
      onPressedYes: () {
        Get.back();
        callingAcceptRejectBooking(index);
      },
    );
  }

  void callingAcceptRejectBooking(int index) async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.bookingId:
            processingBooking[index].bookingRequestId ?? '',
        ApiKeyConstants.status: 'CANCEL'
      };
      inAsyncCall.value = true;
      SimpleModel? simpleModel = await ApiMethods.acceptRejectBookingRequestApi(
          bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != '0') {
        processingBooking.removeAt(index);
        callingBookingRequestList();
        callingCancelBookingList();
        increment();
        CommonWidgets.showMyToastMessage(simpleModel.message ?? '');
      } else {
        CommonWidgets.showMyToastMessage(simpleModel!.message!);
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
  }

  void callingBookingRequestList() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.currentLat: LocalData.lat,
        ApiKeyConstants.currentLon: LocalData.lon,
        ApiKeyConstants.type: 'upcoming'
      };
      BookingRequestModel? getProviderBookingRequest =
          await ApiMethods.getUserBookingRequestApi(bodyParams: bodyParams);
      if (getProviderBookingRequest != null &&
          getProviderBookingRequest.status != '0' &&
          getProviderBookingRequest.data != null &&
          getProviderBookingRequest.data!.isNotEmpty) {
        processingBooking = getProviderBookingRequest.data!;
        increment();
      } else {
        print('Processing List not present..............');
        // CommonWidgets.showMyToastMessage(getProviderBookingRequest!.message!);
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
    increment();
  }

  void callingCompleteBookingList() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.currentLat: LocalData.lat,
        ApiKeyConstants.currentLon: LocalData.lon,
        ApiKeyConstants.type: 'complete'
      };
      BookingRequestModel? getProviderBookingRequest =
          await ApiMethods.getUserBookingRequestApi(bodyParams: bodyParams);
      if (getProviderBookingRequest != null &&
          getProviderBookingRequest.status != '0' &&
          getProviderBookingRequest.data != null &&
          getProviderBookingRequest.data!.isNotEmpty) {
        completeBooking = getProviderBookingRequest.data!;
        increment();
      } else {
        print('Completed List not present..............');
        // CommonWidgets.showMyToastMessage(getProviderBookingRequest!.message!);
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
    increment();
  }

  void callingCancelBookingList() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.currentLat: LocalData.lat,
        ApiKeyConstants.currentLon: LocalData.lon,
        ApiKeyConstants.type: 'cancel'
      };
      BookingRequestModel? getProviderBookingRequest =
          await ApiMethods.getUserBookingRequestApi(bodyParams: bodyParams);
      if (getProviderBookingRequest != null &&
          getProviderBookingRequest.status != '0' &&
          getProviderBookingRequest.data != null &&
          getProviderBookingRequest.data!.isNotEmpty) {
        rejectBooking = getProviderBookingRequest.data!;
        increment();
      } else {
        print('Cancelled List not present..............');
        //CommonWidgets.showMyToastMessage('Cancelled List not present...');
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
    increment();
  }
}
