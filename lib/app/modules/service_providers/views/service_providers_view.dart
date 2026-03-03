import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../data/apis/api_models/get_service_provider_model.dart';
import '../controllers/service_providers_controller.dart';

class ServiceProvidersView extends GetView<ServiceProvidersController> {
  const ServiceProvidersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonWidgets.appBar(
            title: '${controller.parameters[ApiKeyConstants.title]} List'),
        body: Obx(() {
          controller.count.value;
          return CommonWidgets.customProgressBar(
            inAsyncCall: controller.inAsyncCall.value,
            child: Padding(
              padding: EdgeInsets.all(10.px),
              child: Column(
                children: [
                  Expanded(child: showServiceProviders()),
                  if (!controller.inAsyncCall.value &&
                      controller.providerList.isEmpty)
                    CommonWidgets.dataNotFound()
                ],
              ),
            ),
          );
        }));
  }

  Widget showServiceProviders() {
    return ListView.builder(
        itemCount: controller.providerList.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          ServiceProviderData item = controller.providerList[index];
          return GestureDetector(
            onTap: () {
              controller.clickOnProvider(index);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.px)),
              elevation: 2.px,
              color: primary3Color,
              margin: EdgeInsets.all(5.px),
              child: Container(
                padding: EdgeInsets.all(10.px),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CommonWidgets.imageView(
                            image: item.image ??
                                StringConstants.defaultNetworkImage,
                            width: 100.px,
                            height: 100.px,
                            defaultNetworkImage:
                                StringConstants.defaultNetworkImage),
                        SizedBox(
                          width: 5.px,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.userName ?? '',
                              style: MyTextStyle.titleStyle20gr,
                            ),
                            SizedBox(
                              height: 5.px,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20.px,
                                  color: primaryColor,
                                ),
                                Text(
                                  '4.8 (3.279 reviews)',
                                  style: MyTextStyle.titleStyle14b,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.px,
                            ),
                            Text(
                              '\$${item.perHourCharge ?? '0'}',
                              style: MyTextStyle.titleStyle30gr,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.px,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 20.px,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5.px,
                        ),
                        Expanded(
                          child: Text(
                            item.address ?? '',
                            style: MyTextStyle.titleStyle12b,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.px,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              size: 20.px,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 5.px,
                            ),
                            Text(
                              'Time: 9:30am',
                              style: MyTextStyle.titleStyle12b,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 20.px,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 5.px,
                            ),
                            Text(
                              'Time: 9:30am',
                              style: MyTextStyle.titleStyle12b,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.px,
                    ),
                    Row(
                      children: [
                        CommonWidgets.appIcons(
                            assetName: IconConstants.icSend,
                            height: 20.px,
                            width: 20.px),
                        SizedBox(
                          width: 5.px,
                        ),
                        Text(
                          'Distance to request in  ${item.distance} miles ',
                          style: MyTextStyle.titleStyle12b,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.px,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
