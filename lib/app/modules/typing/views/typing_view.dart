import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/apis/api_models/get_chats_model.dart';
import '../../../data/constants/icons_constant.dart';
import '../controllers/typing_controller.dart';

class TypingView extends GetView<TypingController> {
  const TypingView({Key? key}) : super(key: key);

  final Color senderBubbleColor = const Color(0xFF007AFF); // Vibrant Blue
  final Color receiverBubbleColor = const Color(0xFFE5E5EA); // Clean Light Gray
  final Color quickReplyButtonColor =
      const Color(0xFFEFEFF4); // Very light neutral background

  @override
  Widget build(BuildContext context) {
    // The controller now handles the initial scroll after data is fetched.
    // Ensure the TypingController is implemented with the `scrollToBottom()` method as provided previously.

    return Obx(() {
      controller.count.value;

      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.px),
          child: Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: primary3Color,
                surfaceTintColor: primary3Color,
                leading: IconButton(
                  icon: CommonWidgets.appIcons(
                    assetName: IconConstants.icBack,
                    height: 34.px,
                    width: 34.px,
                    borderRadius: 0.px,
                  ),
                  onPressed: () => Get.back(),
                ),
                title: Row(
                  children: [
                    CommonWidgets.imageView(
                      image: controller.parameter[ApiKeyConstants.image] ??
                          StringConstants.defaultNetworkImage,
                      height: 40.px,
                      width: 40.px,
                      borderRadius: 20.px,
                      defaultNetworkImage: StringConstants.defaultNetworkImage,
                    ),
                    SizedBox(width: 10.px),
                    Expanded(
                      child: Text(
                        controller.parameter[ApiKeyConstants.name] ?? '',
                        style: MyTextStyle.titleStyle20gr
                            .copyWith(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1.px,
                color: Colors.grey.withOpacity(0.4),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Obx(() {
                    controller.count.value;
                    return showChat(context);
                  }),
                ),

                // ➡️ QUICK REPLY SUGGESTIONS BAR (at the bottom, just above input)
                _buildQuickSuggestions(),

                // Sending message indicator
                Obx(() {
                  if (controller.textMessageLoading.value) {
                    return Padding(
                      padding: EdgeInsets.only(left: 15.px, bottom: 5.px),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sending message...',
                          style: TextStyle(
                              fontSize: 12.px, color: Colors.grey[600]),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                // Spacer for the floating input field
                SizedBox(height: 80.px),
              ],
            ),

            // 🌀 Initial Full-Screen Progress Bar
            if (controller.inAsyncCall.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10.px, left: 10.px, right: 10.px),
          child: Container(
            // 1. Cleaner background: White or light background
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.px),
              border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.px), // Added a subtle border
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(0.08), // Reduced shadow opacity
                  blurRadius: 8.px,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.px,
                  vertical: 2.px), // Adjusted vertical padding
              child: Row(
                children: [
                  SizedBox(width: 5.px),

                  // TextField remains focused and expanded
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      minLines: 1,
                      maxLines: 5,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 14.px, color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Write your message...',
                        hintStyle: Theme.of(Get.context!)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color:
                                    Colors.grey.shade500), // Lighter hint text
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.px,
                            vertical:
                                10.px), // Adjust padding for better alignment
                      ),
                    ),
                  ),

                  SizedBox(width: 5.px),

                  // 3. Dynamic Send Icon
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        if (controller.messageController.text
                                .trim()
                                .isNotEmpty &&
                            !controller.textMessageLoading.value) {
                          controller.callingSendMessageApi();
                        } else if (controller.messageController.text
                            .trim()
                            .isEmpty) {
                          CommonWidgets.showMyToastMessage(
                              'Please enter message');
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.px), // Adjusted padding
                        child: controller.textMessageLoading.value
                            ? CupertinoActivityIndicator(
                                color: senderBubbleColor)
                            : CommonWidgets.appIcons(
                                assetName: IconConstants.icSendMessage,
                                height: 28
                                    .px, // Slightly smaller icon for better balance
                                width: 28.px,
                                borderRadius: 0.px,
                                color: controller.messageController.text
                                        .trim()
                                        .isNotEmpty
                                    ? senderBubbleColor
                                    : Colors.grey[400],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // --- Widget for Quick Replies with Expanded Prompts ---
  Widget _buildQuickSuggestions() {
    // EXPANDED PROMPT LIST
    final List<String> quickPrompts = [
      'What is your final price for this job?',
      'Can you start the job tomorrow?',
      'I need to confirm the deadline.',
      'That amount works for me, let\'s book it!',
      'When are you available next week?',
      'Can we reschedule the start time?',
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.px),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10.px),
        child: Row(
          children: quickPrompts.map((prompt) {
            return Padding(
              padding: EdgeInsets.only(right: 8.px),
              child: ActionChip(
                onPressed: () {
                  // Set text and send immediately for quick replies
                  controller.messageController.text = prompt;
                  controller.callingSendMessageApi();
                },
                label: Text(
                  prompt,
                  style: TextStyle(
                    fontSize: 13.px,
                    color: Colors.black87,
                  ),
                ),
                backgroundColor: quickReplyButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.px),
                  side: BorderSide.none,
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 12.px, vertical: 6.px),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---

  Widget showChat(BuildContext context) {
    if (controller.chatList.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 50.px),
        child: CommonWidgets.dataNotFound(),
      );
    }

    return ListView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.only(top: 10.px, bottom: 10.px),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: controller.chatList.length,
      itemBuilder: (context, index) {
        ChatsResult item = controller.chatList[index];
        bool isSender = item.senderId == controller.userId;

        final maxWidth = MediaQuery.of(context).size.width * 0.75;

        String timeString = DateFormat('hh:mm a').format(DateTime.now());

        return Container(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.px, horizontal: 12.px),
                  decoration: BoxDecoration(
                    color: isSender ? senderBubbleColor : receiverBubbleColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.px),
                      topRight: Radius.circular(16.px),
                      bottomLeft:
                          isSender ? Radius.circular(16.px) : Radius.zero,
                      bottomRight:
                          isSender ? Radius.zero : Radius.circular(16.px),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 1.px,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    item.message ?? '',
                    style: MyTextStyle.titleStyle12bb.copyWith(
                      color: isSender ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: isSender
                    ? EdgeInsets.only(right: 4.px, top: 4.px)
                    : EdgeInsets.only(left: 4.px, top: 4.px),
                child: Text(
                  timeString,
                  style: TextStyle(
                    fontSize: 10.px,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
