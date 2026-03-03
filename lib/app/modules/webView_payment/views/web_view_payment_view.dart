import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/colors.dart';
import '../../../../common/common_widgets.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/web_view_payment_controller.dart';

class WebViewPaymentView extends GetView<WebViewPaymentController> {
  const WebViewPaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary3Color,
        appBar: CommonWidgets.appBar(
            title: StringConstants.payment, showColorBackButton: true),
        body: Obx(() {
          controller.count.value;
          return CommonWidgets.customProgressBar(
              inAsyncCall: controller.showProgressBar.value,
              child: WebViewWidget(controller: controller.webViewController));
        }));
  }
}
