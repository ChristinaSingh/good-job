import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_payment_history_model.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/provider_wallet_controller.dart';

class ProviderWalletView extends GetView<ProviderWalletController> {
  const ProviderWalletView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonWidgets.appBar(
          title: StringConstants.wallet,
        ),
        body: Obx(() {
          controller.count.value;
          return Column(
            children: [
              Container(
                height: 150.px,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.px),
                    color: primaryColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      StringConstants.yourAvailableBalance,
                      style: MyTextStyle.titleStyle14bw,
                    ),
                    Container(
                      height: 45.px,
                      margin: EdgeInsets.only(top: 10.px),
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.px, vertical: 10.px),
                      alignment: Alignment.center,
                      child: Text(
                        '\$${controller.totalAmount}',
                        style: MyTextStyle.titleStyle18bw,
                      ),
                    )
                  ],
                ),
              ),
              controller.inAsyncCall.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : Expanded(child: showUpcomingServices())
            ],
          );
        }));
  }

  Widget showUpcomingServices() {
    return ListView.builder(
        itemCount: controller.historyList.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          PaymentHistoryData item = controller.historyList[index];
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.px)),
            elevation: 2.px,
            color: primary3Color,
            margin: EdgeInsets.all(5.px),
            child: Container(
              padding: EdgeInsets.all(10.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '\$${item.amount}',
                        style: MyTextStyle.titleStyle18bb,
                      ),
                      SizedBox(
                        height: 5.px,
                      ),
                      Text(
                        item.user![0].userName ?? '',
                        style: MyTextStyle.titleStyle12b,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CommonWidgets.appIcons(assetName: IconConstants.icCredit),
                      SizedBox(
                        height: 5.px,
                      ),
                      Text(
                        item.user![0].createdAt.toString().substring(0, 10),
                        style: MyTextStyle.titleStyle12b,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
