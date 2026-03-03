import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_chats_model.dart';
import '../../../data/apis/api_models/get_simple_model.dart';

class TypingController extends GetxController {
  Timer? _timer;
  RxBool inAsyncCall = false.obs;
  RxBool textMessageLoading = false.obs;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  final count = 0.obs;

  List<ChatsResult> chatList = [];
  String userId = '';
  Map<String, String?> parameter = Get.parameters;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(ApiKeyConstants.userId) ?? '';

    // 1. Initial load starts
    inAsyncCall.value = true;
    await callingGetMessageApi();
    inAsyncCall.value = false;
    // 2. Initial load finished, scroll is handled inside the API method

    startTimer();

    messageController.addListener(() {
      if (messageController.text.trim().isNotEmpty) {
        count.refresh();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    _timer?.cancel();
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void increment() => count.value++;

  // 💡 Helper function to scroll to the end
  void scrollToBottom() {
    // We use Future.delayed to ensure the UI has completely rendered the new items
    // before attempting to scroll to the bottom.
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      callingGetMessageApi(isPolling: true);
    });
  }

  void callingSendMessageApi() async {
    if (messageController.text.trim().isEmpty) {
      CommonWidgets.showMyToastMessage('Please enter a message');
      return;
    }

    String messageContent = messageController.text;
    messageController.clear();

    textMessageLoading.value = true;

    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.senderId: userId,
        ApiKeyConstants.receiverId: parameter[ApiKeyConstants.receiverId] ?? '',
        ApiKeyConstants.message: messageContent,
      };

      SimpleModel? simpleModel =
          await ApiMethods.addChatsApi(bodyParams: bodyParams);

      if (simpleModel != null && simpleModel.status != '0') {
        // Force a UI refresh and scroll after sending
        await callingGetMessageApi(isPolling: true);
      } else {
        CommonWidgets.showMyToastMessage(
            simpleModel?.message ?? 'Failed to send message.');
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage('Error sending message: $e');
    } finally {
      textMessageLoading.value = false;
    }
  }

  Future<void> callingGetMessageApi({bool isPolling = false}) async {
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.receiverId: parameter[ApiKeyConstants.receiverId] ?? '',
      };

      ChatsModel? chatsModel =
          await ApiMethods.getChatsApi(bodyParams: bodyParams);

      if (chatsModel != null &&
          chatsModel.status != '0' &&
          chatsModel.result != null) {
        // Only update if the list size is different
        if (chatList.length != chatsModel.result!.length) {
          chatList = chatsModel.result!;
          increment(); // Triggers TypingView build
          // 🚀 Crucial Fix: Scroll to bottom immediately after updating data
          scrollToBottom();
        }
      } else if (!isPolling) {
        CommonWidgets.showMyToastMessage(chatsModel!.message!);
      }
    } catch (e) {
      if (!isPolling) {
        CommonWidgets.showMyToastMessage('Error getting chats: $e');
      }
    }
  }
}
