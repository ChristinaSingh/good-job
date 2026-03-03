import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/common/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonWidgets.appBar(title: StringConstants.payment),
        body: Obx(() {
          controller.count.value;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Select the payment method you want to use.',
                  style: MyTextStyle.titleStyleCustom(
                      14, FontWeight.w400, Colors.grey),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Services',
                    style: MyTextStyle.titleStyle16bb,
                  ),
                  subtitle: Text(
                    'Wet Service (Split AC)',
                    style: MyTextStyle.titleStyle12gr,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$20.00',
                      style: MyTextStyle.titleStyle12gr,
                    ),
                    Text(
                      '01',
                      style: MyTextStyle.titleStyle12gr,
                    )
                  ],
                ),
                SizedBox(
                  height: 20.px,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment',
                    style: MyTextStyle.titleStyle16bb,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service Charge',
                      style: MyTextStyle.titleStyle12gr,
                    ),
                    Text(
                      '\$20.00',
                      style: MyTextStyle.titleStyle12gr,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub Total',
                      style: MyTextStyle.titleStyle12gr,
                    ),
                    Text(
                      '\$00.00',
                      style: MyTextStyle.titleStyle12gr,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL',
                      style: MyTextStyle.titleStyle14bb,
                    ),
                    Text(
                      '\$20.00',
                      style: MyTextStyle.titleStyle12gr,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.px,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(10.px),
                    itemCount: controller.paymentType.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          controller.paymentType[index],
                          style: MyTextStyle.titleStyle16bb,
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            controller.changeSelectIndex(index);
                          },
                          child: index == controller.paymentTypeIndex.value
                              ? Icon(
                                  Icons.radio_button_checked,
                                  size: 20.px,
                                  color: primaryColor,
                                )
                              : Icon(
                                  Icons.radio_button_off,
                                  size: 20.px,
                                  color: primaryColor,
                                ),
                        ),
                      );
                    }),
                const Spacer(),
                CommonWidgets.commonElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Add Card',
                      style: MyTextStyle.titleStyle14gr,
                    ),
                    buttonColor: primaryColor.withOpacity(0.2)),
                SizedBox(
                  height: 20.px,
                ),
                CommonWidgets.commonElevatedButton(
                    onPressed: () {
                      controller.clickOnSubmitButton();
                    },
                    child: Text(
                      StringConstants.submit,
                      style: MyTextStyle.titleStyle16bw,
                    ),
                    buttonColor: primaryColor),
                SizedBox(
                  height: 50.px,
                ),
              ],
            ),
          );
        }));
  }
}
