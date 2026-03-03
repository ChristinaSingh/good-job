  // import 'package:flutter/material.dart';
  // import 'package:get/get.dart';
  // import 'package:responsive_sizer/responsive_sizer.dart';
  //
  // import '../../../../common/colors.dart';
  // import '../../../../common/common_widgets.dart';
  // import '../../../../common/local_data.dart';
  // import '../../../../common/text_styles.dart';
  // import '../../../data/apis/api_models/get_booking_request_model.dart';
  // import '../../../data/constants/icons_constant.dart';
  // import '../../../data/constants/string_constants.dart';
  // import '../controllers/provider_home_controller.dart';
  //
  // class ProviderHomeView extends GetView<ProviderHomeController> {
  //   const ProviderHomeView({Key? key}) : super(key: key);
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       body: Obx(() {
  //         return CommonWidgets.customProgressBar(
  //           inAsyncCall: controller.inAsyncCall.value,
  //           child: SafeArea(
  //             child: Column(
  //               children: [
  //                 _buildHeader(),
  //                 _buildContent(),
  //               ],
  //             ),
  //           ),
  //         );
  //       }),
  //     );
  //   }
  //
  //   Widget _buildHeader() {
  //     return Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 10.px),
  //       child: Row(
  //         children: [
  //           Icon(Icons.location_on_rounded, size: 25.px, color: primaryColor),
  //           SizedBox(width: 5.px),
  //           _buildLocationDetails(),
  //           const Spacer(),
  //           _buildNotificationButton(),
  //         ],
  //       ),
  //     );
  //   }
  //
  //   Widget _buildLocationDetails() {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Text(StringConstants.currentLocation, style: MyTextStyle.titleStyle12b),
  //             SizedBox(width: 5.px),
  //             Icon(Icons.keyboard_arrow_down_outlined, size: 20.px, color: primaryColor),
  //           ],
  //         ),
  //         Text('${LocalData.address}', style: MyTextStyle.titleStyle16bb),
  //       ],
  //     );
  //   }
  //
  //   Widget _buildNotificationButton() {
  //     return GestureDetector(
  //       onTap: () => controller.clickOnNotification(),
  //       child: CommonWidgets.appIcons(
  //         assetName: IconConstants.icNotification,
  //         height: 50.px,
  //         width: 50.px,
  //       ),
  //     );
  //   }
  //
  //   Widget _buildContent() {
  //     return Expanded(
  //       child: controller.bookingRequest.isEmpty
  //           ? CommonWidgets.dataNotFound(text: 'You have no pending booking')
  //           : _buildServiceRequestList(),
  //     );
  //   }
  //
  //   Widget _buildServiceRequestList() {
  //     return ListView.builder(
  //       itemCount: controller.bookingRequest.length,
  //       padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 5.px),
  //       itemBuilder: (context, index) {
  //         BookingRequestData item = controller.bookingRequest[index];
  //         return GestureDetector(
  //           onTap: () => controller.clickOnProject(index),
  //           child: _buildServiceRequestCard(item, index),
  //         );
  //       },
  //     );
  //   }
  //
  //   Widget _buildServiceRequestCard(BookingRequestData item, int index) {
  //     return Card(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.px)),
  //       elevation: 3,
  //       color: primary3Color,
  //       margin: EdgeInsets.symmetric(vertical: 8.px),
  //       child: Padding(
  //         padding: EdgeInsets.all(12.px),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 CommonWidgets.imageView(
  //                   image: item.image ?? StringConstants.defaultNetworkImage,
  //                   width: 100.px,
  //                   height: 110.px,
  //                 ),
  //                 SizedBox(width: 10.px),
  //                 Expanded(child: _buildServiceRequestDetails(item)),
  //               ],
  //             ),
  //             SizedBox(height: 15.px),
  //             _buildActionButtons(item, index),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //
  //   Widget _buildServiceRequestDetails(BookingRequestData item) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(item.name ?? '', style: MyTextStyle.titleStyle20gr),
  //         SizedBox(height: 5.px),
  //         _buildLocationRow(item),
  //         SizedBox(height: 5.px),
  //         _buildTimeDateRow(item),
  //         SizedBox(height: 5.px),
  //         _buildDistanceRow(item),
  //       ],
  //     );
  //   }
  //
  //   Widget _buildLocationRow(BookingRequestData item) {
  //     return Row(
  //       children: [
  //         Icon(Icons.location_on_rounded, size: 18.px, color: Colors.grey),
  //         SizedBox(width: 5.px),
  //         Expanded(
  //           child: Text(
  //             item.location ?? '',
  //             style: MyTextStyle.titleStyle12b,
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  //
  //   Widget _buildTimeDateRow(BookingRequestData item) {
  //     return Row(
  //       children: [
  //         // Icon(Icons.access_time_outlined, size: 18.px, color: Colors.grey),
  //         // SizedBox(width: 5.px),
  //         // Text('Time: ${item.bookingDate}', style: MyTextStyle.titleStyle10b),
  //         // Spacer(),
  //         Icon(Icons.date_range, size: 18.px, color: Colors.grey),
  //         SizedBox(width: 5.px),
  //         Text('Date: ${item.bookingDate}', style: MyTextStyle.titleStyle10b),
  //       ],
  //     );
  //   }
  //
  //   Widget _buildDistanceRow(BookingRequestData item) {
  //     return Row(
  //       children: [
  //         CommonWidgets.appIcons(assetName: IconConstants.icSend, height: 18.px, width: 18.px),
  //         SizedBox(width: 5.px),
  //         Expanded(
  //           child: Text(
  //             'Distance: ${item.distance} miles',
  //             style: MyTextStyle.titleStyle12b,
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  //
  //   Widget _buildActionButtons(BookingRequestData item, int index) {
  //     return Row(
  //       children: [
  //         Expanded(
  //           child: CommonWidgets.commonElevatedButton(
  //             onPressed: () => controller.clickOnAcceptRejectButton(index, 'CANCEL'),
  //             child: Text(StringConstants.decline, style: MyTextStyle.titleStyle16bw),
  //             buttonColor: Colors.redAccent,
  //           ),
  //         ),
  //         SizedBox(width: 10.px),
  //         Expanded(
  //           child: CommonWidgets.commonElevatedButton(
  //             onPressed: () => controller.clickOnAcceptRejectButton(index, 'ACCEPT'),
  //             child: Text(StringConstants.accept, style: MyTextStyle.titleStyle16bw),
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  // }
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:responsive_sizer/responsive_sizer.dart';

  import '../../../../common/colors.dart';
  import '../../../../common/common_widgets.dart';
  import '../../../../common/local_data.dart';
  import '../../../../common/text_styles.dart';
  import '../../../data/apis/api_models/get_booking_request_model.dart';
  import '../../../data/constants/icons_constant.dart';
  import '../../../data/constants/string_constants.dart';
  import '../controllers/provider_home_controller.dart';

  class ProviderHomeView extends GetView<ProviderHomeController> {
    const ProviderHomeView({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Obx(() {
          return CommonWidgets.customProgressBar(
            inAsyncCall: controller.inAsyncCall.value,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildContent(),
                ],
              ),
            ),
          );
        }),
      );
    }

    // ---------------- HEADER ----------------
    Widget _buildHeader() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 12.px),
        child: Row(
          children: [
            Icon(Icons.location_on_rounded, size: 24.px, color: primaryColor),
            SizedBox(width: 8.px),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringConstants.currentLocation,
                    style: MyTextStyle.titleStyle12b.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 2.px),
                  Text(
                    LocalData.address ?? "Fetching location...",
                    style: MyTextStyle.titleStyle16bb.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => controller.clickOnNotification(),
              child: CommonWidgets.appIcons(
                assetName: IconConstants.icNotification,
                height: 40.px,
                width: 40.px,
              ),
            ),
          ],
        ),
      );
    }

    // ---------------- CONTENT ----------------
    Widget _buildContent() {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.px),
          child: controller.bookingRequest.isEmpty
              ? Center(
            child: CommonWidgets.dataNotFound(
                text: 'No pending booking requests'),
          )
              : ListView.builder(
            padding: EdgeInsets.only(top: 10.px, bottom: 20.px),
            itemCount: controller.bookingRequest.length,
            itemBuilder: (context, index) {
              BookingRequestData item = controller.bookingRequest[index];
              return _buildBookingItem(item, index);
            },
          ),
        ),
      );
    }

    // ---------------- BOOKING ITEM ----------------
    Widget _buildBookingItem(BookingRequestData item, int index) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8.px),
        padding: EdgeInsets.all(12.px),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.px),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.px),
                  child: CommonWidgets.imageView(
                    image: item.image ?? StringConstants.defaultNetworkImage,
                    width: 90.px,
                    height: 90.px,
                  ),
                ),
                SizedBox(width: 12.px),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name ?? '',
                        style: MyTextStyle.titleStyle18bb.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.px),
                      Row(
                        children: [
                          Icon(Icons.calendar_month,
                              size: 16.px, color: Colors.grey),
                          SizedBox(width: 4.px),
                          Text(
                            item.bookingDate ?? '',
                            style: MyTextStyle.titleStyle12b
                                .copyWith(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.px),
                      Row(
                        children: [
                          Icon(Icons.directions_walk,
                              size: 16.px, color: Colors.grey),
                          SizedBox(width: 4.px),
                          Text(
                            "Distance: ${item.distance ?? "N/A"} miles",
                            style: MyTextStyle.titleStyle12b
                                .copyWith(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.px),
            Divider(color: Colors.grey.shade300, thickness: 1),
            SizedBox(height: 6.px),

            // Full address below image
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined,
                    color: Colors.grey.shade600, size: 18.px),
                SizedBox(width: 6.px),
                Expanded(
                  child: Text(
                    item.location ?? "No address provided",
                    style: MyTextStyle.titleStyle13b.copyWith(
                      color: Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.px),

            // ----------- View Details Button -----------
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.px)),

                  padding:
                  EdgeInsets.symmetric(horizontal: 20.px, vertical: 10.px),
                  elevation: 0,
                ),
                onPressed: () => controller.clickOnProject(index),
                child: Text(
                  "View Details",
                  style: MyTextStyle.titleStyle14bw,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
