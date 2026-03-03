// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../common/common_widgets.dart';
// import '../../../../common/local_data.dart';
// import '../../../data/apis/api_constants/api_key_constants.dart';
// import '../../../data/apis/api_methods/api_methods.dart';
// import '../../../data/apis/api_models/get_booking_request_model.dart';
// import '../../../data/apis/api_models/get_simple_model.dart';
// import '../../../data/constants/string_constants.dart';
// import '../../../routes/app_pages.dart';
//
// class ProviderBookingController extends GetxController {
//   final tabIndex = 0.obs;
//   final count = 0.obs;
//   final inAsyncCall = true.obs;
//   List<BookingRequestData> processingBooking = [];
//   List<BookingRequestData> completeBooking = [];
//   List<BookingRequestData> rejectBooking = [];
//   String userId = '';
//   @override
//   void onInit() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userId = prefs.getString(ApiKeyConstants.userId) ?? '';
//     super.onInit();
//     callingBookingRequestList();
//     callingCompleteBookingList();
//     callingCancelBookingList();
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
//   void changeUpDown(int index) {
//     processingBooking[index].upDown =
//         !(processingBooking[index].upDown ?? false);
//     increment();
//   }
//
//   void clickOnProject(int index) {
//     Get.toNamed(Routes.PROVIDER_PROJECT_DETAIL,
//         arguments: processingBooking[index]);
//   }
//
//   void clickOnViewButton(int index) {
//     Get.toNamed(Routes.PROVIDER_MAP, arguments: processingBooking[index]);
//   }
//
//   void callingBookingRequestList() async {
//     processingBooking.clear();
//     try {
//       Map<String, String> bodyParams = {
//         ApiKeyConstants.providerId: userId,
//         ApiKeyConstants.currentLat: LocalData.lat,
//         ApiKeyConstants.currentLon: LocalData.lon,
//         ApiKeyConstants.type: 'upcoming'
//       };
//       BookingRequestModel? getProviderBookingRequest =
//           await ApiMethods.getProviderBookingRequestApi(bodyParams: bodyParams);
//       if (getProviderBookingRequest != null &&
//           getProviderBookingRequest.status != '0' &&
//           getProviderBookingRequest.data != null &&
//           getProviderBookingRequest.data!.isNotEmpty) {
//         processingBooking = getProviderBookingRequest.data!;
//         print(" booking details are ${processingBooking[0].name}");
//         increment();
//       } else {
//         print('Processing List not present..............');
//         // CommonWidgets.showMyToastMessage(getProviderBookingRequest!.message!);
//       }
//       inAsyncCall.value = false;
//     } catch (e) {
//       inAsyncCall.value = false;
//       CommonWidgets.showMyToastMessage('Some thing is wrong ...');
//     }
//   }
//
//   void callingCompleteBookingList() async {
//     completeBooking.clear();
//     try {
//       Map<String, String> bodyParams = {
//         ApiKeyConstants.providerId: userId,
//         ApiKeyConstants.currentLat: LocalData.lat,
//         ApiKeyConstants.currentLon: LocalData.lon,
//         ApiKeyConstants.type: 'complete'
//       };
//       BookingRequestModel? getProviderBookingRequest =
//           await ApiMethods.getProviderBookingRequestApi(bodyParams: bodyParams);
//       if (getProviderBookingRequest != null &&
//           getProviderBookingRequest.status != '0' &&
//           getProviderBookingRequest.data != null &&
//           getProviderBookingRequest.data!.isNotEmpty) {
//         completeBooking = getProviderBookingRequest.data!;
//         increment();
//       } else {
//         print('Completed List not present..............');
//         // CommonWidgets.showMyToastMessage(getProviderBookingRequest!.message!);
//       }
//       inAsyncCall.value = false;
//     } catch (e) {
//       inAsyncCall.value = false;
//       CommonWidgets.showMyToastMessage('Some thing is wrong ...');
//     }
//   }
//
//   void callingCancelBookingList() async {
//     rejectBooking.clear();
//     try {
//       Map<String, String> bodyParams = {
//         ApiKeyConstants.providerId: userId,
//         ApiKeyConstants.currentLat: LocalData.lat,
//         ApiKeyConstants.currentLon: LocalData.lon,
//         ApiKeyConstants.type: 'cancel'
//       };
//       BookingRequestModel? getProviderBookingRequest =
//           await ApiMethods.getProviderBookingRequestApi(bodyParams: bodyParams);
//       if (getProviderBookingRequest != null &&
//           getProviderBookingRequest.status != '0' &&
//           getProviderBookingRequest.data != null &&
//           getProviderBookingRequest.data!.isNotEmpty) {
//         rejectBooking = getProviderBookingRequest.data!;
//         increment();
//       } else {
//         print('Cancelled List not present..............');
//         //CommonWidgets.showMyToastMessage('Cancelled List not present...');
//       }
//       inAsyncCall.value = false;
//     } catch (e) {
//       inAsyncCall.value = false;
//       CommonWidgets.showMyToastMessage('Some thing is wrong ...');
//     }
//   }
//
//   void clickOnAcceptRejectButton(int index, String status) {
//     CommonWidgets.showAlertDialog(
//       title: StringConstants.booking,
//       content: 'Do you want to $status booking request?',
//       onPressedYes: () {
//         callingAcceptRejectBooking(index, status);
//         Get.back();
//       },
//     );
//   }
//
//   void callingAcceptRejectBooking(int index, String status) async {
//     try {
//       Map<String, String> bodyParams = {
//         ApiKeyConstants.bookingId:
//             processingBooking[index].bookingRequestId ?? '',
//         ApiKeyConstants.status: status
//       };
//       inAsyncCall.value = true;
//       SimpleModel? simpleModel = await ApiMethods.acceptRejectBookingRequestApi(
//           bodyParams: bodyParams);
//       if (simpleModel != null && simpleModel.status != '0') {
//         processingBooking.removeAt(index);
//         inAsyncCall.value = true;
//         callingBookingRequestList();
//         callingCompleteBookingList();
//         callingCancelBookingList();
//         increment();
//         CommonWidgets.showMyToastMessage(simpleModel.message ?? '');
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
import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/local_data.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_booking_request_model.dart';
import '../../../data/apis/api_models/get_simple_model.dart';
import '../../../data/constants/string_constants.dart';
import '../../../routes/app_pages.dart';

class ProviderBookingController extends GetxController {
  final tabIndex = 0.obs;
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final isFirstLoad = true.obs;
  List<BookingRequestData> processingBooking = [];
  List<BookingRequestData> completeBooking = [];
  List<BookingRequestData> rejectBooking = [];
  String userId = '';
  Timer? _timer;
  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';
    fetchAllBookings();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      fetchAllBookings(showLoader: false);
    });
  }

  void increment() => count.value++;

  void changeUpDown(int index) {
    processingBooking[index].upDown =
        !(processingBooking[index].upDown ?? false);
    increment();
  }

  void clickOnProject(int index) async {
    var result = await Get.toNamed(
      Routes.PROVIDER_PROJECT_DETAIL,
      arguments: processingBooking[index],
    );
    print("Result is: $result");
    if (result == true) {
      print("Welcome, data updated!");
      fetchAllBookings();
      update();
    }
  }

  void clickOnViewButton(int index) {
    Get.toNamed(Routes.PROVIDER_MAP, arguments: processingBooking[index]);
  }

  Future<void> fetchAllBookings({bool showLoader = true}) async {
    if (showLoader && isFirstLoad.value) {
      inAsyncCall.value = true; // Show loader only first time
    }

    await Future.wait([
      _fetchBookingRequestList(),
      _fetchCompleteBookingList(),
      _fetchCancelBookingList()
    ]);

    if (isFirstLoad.value) {
      isFirstLoad.value = false;
      inAsyncCall.value = false;
    }
  }

  Future<void> _fetchBookingRequestList() async {
    processingBooking.clear();
    processingBooking = await _fetchBookingList('upcoming');
  }

  Future<void> _fetchCompleteBookingList() async {
    completeBooking.clear();
    completeBooking = await _fetchBookingList('complete');
  }

  Future<void> _fetchCancelBookingList() async {
    rejectBooking.clear();
    rejectBooking = await _fetchBookingList('cancel');
  }

  Future<List<BookingRequestData>> _fetchBookingList(String type) async {
    print("i am calling");
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.providerId: userId,
        ApiKeyConstants.currentLat: LocalData.lat,
        ApiKeyConstants.currentLon: LocalData.lon,
        ApiKeyConstants.type: type
      };

      BookingRequestModel? response =
          await ApiMethods.getProviderBookingRequestApi(bodyParams: bodyParams);
      if (response != null &&
          response.status != '0' &&
          response.data != null &&
          response.data!.isNotEmpty) {
        return response.data!;
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage('Something went wrong...');
    }
    return [];
  }

  void clickOnAcceptRejectButton(int index, String status) {
    CommonWidgets.showAlertDialog(
      title: StringConstants.booking,
      content: 'Do you want to $status this booking request?',
      onPressedYes: () {
        _acceptRejectBooking(index, status);
        Get.back();
      },
    );
  }

  Future<void> _acceptRejectBooking(int index, String status) async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.bookingId:
            processingBooking[index].bookingRequestId ?? '',
        ApiKeyConstants.status: status
      };

      inAsyncCall.value = true;
      SimpleModel? response = await ApiMethods.acceptRejectBookingRequestApi(
          bodyParams: bodyParams);
      if (response != null && response.status != '0') {
        processingBooking.removeAt(index);
        fetchAllBookings();
        CommonWidgets.showMyToastMessage(response.message ?? '');
      } else {
        CommonWidgets.showMyToastMessage(response!.message!);
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage('Something went wrong...');
    } finally {
      inAsyncCall.value = false;
    }
  }
}
