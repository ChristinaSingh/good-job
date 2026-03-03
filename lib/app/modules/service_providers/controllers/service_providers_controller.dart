import 'dart:io';

import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_service_provider_model.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';

class ServiceProvidersController extends GetxController {
  Map<String, String?> parameters = Get.parameters;
  List<File> fileList = Get.arguments;
  List<ServiceProviderData> providerList = [];
  final count = 0.obs;
  final inAsyncCall = true.obs;
  String userId = '';
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';
    super.onInit();
    callingServiceProviderList();
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

  void clickOnProvider(int index) {
    Map<String, String> data = {
      ApiKeyConstants.userId: userId,
      ApiKeyConstants.bookingDate:
          parameters[ApiKeyConstants.bookingDate] ?? '',
      ApiKeyConstants.providerId: providerList[index].id ?? '',
      ApiKeyConstants.jobDescription:
          parameters[ApiKeyConstants.jobDescription] ?? '',
      ApiKeyConstants.workingHours:
          parameters[ApiKeyConstants.workingHours] ?? '',
      ApiKeyConstants.amount: providerList[index].perHourCharge ?? '0',
      ApiKeyConstants.location: parameters[ApiKeyConstants.location] ?? '',
      ApiKeyConstants.lat: parameters[ApiKeyConstants.lat] ?? '',
      ApiKeyConstants.lon: parameters[ApiKeyConstants.lon] ?? '',
      ApiKeyConstants.serviceId: parameters[ApiKeyConstants.serviceId] ?? '',
    };
    Get.toNamed(Routes.SERVICE_PROVIDERS_DETAILS,
        arguments: {
          'select_image': fileList,
          'review': providerList[index].reviews
        },
        parameters: data);
  }

  void callingServiceProviderList() async {
    try {
      print("i am callling bro");
      Map<String, String> bodyParams = {
        ApiKeyConstants.serviceId: "2",
        ApiKeyConstants.lat: parameters[ApiKeyConstants.lat] ?? '',
        ApiKeyConstants.lon: parameters[ApiKeyConstants.lon] ?? '',
      };
      ServiceProviderModel? serviceProviderModel =
          await ApiMethods.getServiceProviderList(bodyParams: bodyParams);
      if (serviceProviderModel != null &&
          serviceProviderModel.status != '0' &&
          serviceProviderModel.data != null &&
          serviceProviderModel.data!.isNotEmpty) {
        providerList = serviceProviderModel.data!;
      } else {
        CommonWidgets.showMyToastMessage(serviceProviderModel!.message!);
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
  }
}
