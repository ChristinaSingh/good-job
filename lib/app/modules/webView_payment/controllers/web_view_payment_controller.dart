import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/colors.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';

class WebViewPaymentController extends GetxController {
  final showProgressBar = true.obs;
  Map<String, String?> parameters = Get.parameters;
  late WebViewController webViewController;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(primary3Color)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              showProgressBar.value = false;
              increment();
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            print('Current page url:-${url}');
            if (url.contains('handle-checkout-success')) {
              Get.back(result: url);
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(parameters[ApiKeyConstants.url] ?? ''));
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
}
