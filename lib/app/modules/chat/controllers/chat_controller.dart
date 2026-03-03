import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_conversation_model.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';

class ChatController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<ConversationResult> userList = [];
  List<ConversationResult> filterUserList = [];
  RxBool isAsyncCall = false.obs;
  final count = 0.obs;
  final isLoading = true.obs;
  String userId = '';
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';
    super.onInit();
    callingConversationApi();
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

  changeFilterUsersList(String query) {
    filterUserList = userList
        .where((item) => item.userName
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    update();
  }

  clickOnUser(int index) {
    Map<String, String> data = {
      ApiKeyConstants.receiverId: filterUserList[index].id ?? "",
      ApiKeyConstants.name: filterUserList[index].userName ?? "",
      ApiKeyConstants.image: filterUserList[index].image ?? "",
    };
    Get.toNamed(Routes.TYPING, parameters: data);
  }

  void callingConversationApi() async {
    isAsyncCall.value = true;
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: userId,
      };
      ConversationModel? conversationModel =
          await ApiMethods.getConversationApi(bodyParams: bodyParams);
      if (conversationModel != null &&
          conversationModel.status != '0' &&
          conversationModel.result != null) {
        userList = conversationModel.result!;
        filterUserList = userList;
        isAsyncCall.value = false;
      } else {
        CommonWidgets.showMyToastMessage(
            conversationModel?.message ?? 'There is no conversation data...');
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    } finally {
      isAsyncCall.value = false;
    }
  }
}
