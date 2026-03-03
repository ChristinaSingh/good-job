import 'dart:io';

import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_service_provider_detail_model.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/add_booking_model.dart';
import '../../../data/apis/api_models/get_checkout_session_model.dart';
import '../../../data/apis/api_models/get_service_provider_model.dart';

class ServiceProvidersDetailsController extends GetxController {
  Map<String, String?> parameters = Get.parameters;
  //List<File> fileList = Get.arguments;
  late List<File> fileList;
  Map<String, dynamic> argumentData = Get.arguments;
  final count = 0.obs;
  final inAsyncCall = true.obs;
  final isLoading = false.obs;
  List<Reviews> reviewList = [];

  ServiceProviderDetailData? userDetails;
  String email = '';
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString(ApiKeyConstants.email) ?? 'demo@gmail.com';

    super.onInit();
    fileList = argumentData['select_image'];
    reviewList = argumentData['review'];
    callingGetProfile();
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

  void callingGetProfile() async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: parameters[ApiKeyConstants.providerId] ?? '',
      };
      ServiceProviderDetailModel? serviceProviderDetailModel =
          await ApiMethods.getServiceProviderDetails(bodyParams: bodyParams);
      if (serviceProviderDetailModel != null &&
          serviceProviderDetailModel.status != '0' &&
          serviceProviderDetailModel.data != null) {
        userDetails = serviceProviderDetailModel.data!;
      } else {
        CommonWidgets.snackBarView(title: serviceProviderDetailModel!.message!);
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.snackBarView(title: 'Some thing is wrong ...');
    }
  }

  void clickOnBookButton() async {
    try {
      Map<String, String> data = {
        ApiKeyConstants.userId: parameters[ApiKeyConstants.userId] ?? '',
        ApiKeyConstants.bookingDate:
            parameters[ApiKeyConstants.bookingDate] ?? '',
        ApiKeyConstants.providerId:
            parameters[ApiKeyConstants.providerId] ?? '',
        ApiKeyConstants.jobDescription:
            parameters[ApiKeyConstants.jobDescription] ?? '',
        ApiKeyConstants.workingHours:
            parameters[ApiKeyConstants.workingHours] ?? '',
        ApiKeyConstants.amount: parameters[ApiKeyConstants.amount] ?? '',
        ApiKeyConstants.location: parameters[ApiKeyConstants.location] ?? '',
        ApiKeyConstants.lat: parameters[ApiKeyConstants.lat] ?? '',
        ApiKeyConstants.lon: parameters[ApiKeyConstants.lon] ?? '',
        ApiKeyConstants.serviceId: parameters[ApiKeyConstants.serviceId] ?? '',
      };
      isLoading.value = true;
      AddBookingModel? response =
          await ApiMethods.addBookingApi(bodyParams: data, imageList: fileList);
      print("response:-${response!.message.toString()}");
      if (response != null && response.status != '0') {
        isLoading.value = false;

        submitPayment(response.data?.insertedId.toString() ?? '');
      } else {
        CommonWidgets.showMyToastMessage(response.message ?? '');
      }
    } catch (e) {
      print("Error:-${e.toString()}");
    }
    isLoading.value = false;
  }

  Future<void> submitPayment(String bookingId) async {
    Map<String, String> queryParameters = {
      ApiKeyConstants.email: (email.isNotEmpty) ? email : 'dummy@gmail.com',
      ApiKeyConstants.price: parameters[ApiKeyConstants.amount] ?? '0',
      ApiKeyConstants.bookingId: bookingId,
    };
    isLoading.value = true;
    CheckOutSessionModel? checkOutSessionModel =
        await ApiMethods.createCheckOutSession(bodyParams: queryParameters);
    if (checkOutSessionModel != null && checkOutSessionModel.data != null) {
      Map<String, String> dataParameter = {
        ApiKeyConstants.url: checkOutSessionModel.data!.url ?? ''
      };
      dynamic? resultUrl =
          await Get.toNamed(Routes.WEB_VIEW_PAYMENT, parameters: dataParameter);
      if (resultUrl != null && resultUrl.contains('handle-checkout-success')) {
        print("Come back from payment screen:-");

        Get.offNamed(Routes.WAITING_REQUEST);
      }
    } else {
      CommonWidgets.showMyToastMessage('Some things is wrong....');
    }
    isLoading.value = false;
  }
}
