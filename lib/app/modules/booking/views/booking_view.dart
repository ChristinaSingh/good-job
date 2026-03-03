import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../data/apis/api_models/get_booking_request_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);

  // Helper function to get color based on status
  Color _getStatusColor(String status) {
    String lowerStatus = status.toLowerCase();
    if (lowerStatus.contains('pending')) {
      return Colors.orange.shade800;
    } else if (lowerStatus.contains('completed')) {
      return Colors.green.shade800;
    } else if (lowerStatus.contains('cancel') ||
        lowerStatus.contains('reject')) {
      return Colors.red.shade800;
    }
    return primaryColor;
  }

  /// Helper widget to display a single row of booking data with professional design
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    bool isStatus = false,
  }) {
    // Check if the title is for Job Description (shortened to 'Job Desc.')
    final isJobDescription = title == 'Job Desc.';

    // Widget for the Value part
    Widget valueWidget = isStatus
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 4.px),
            decoration: BoxDecoration(
              color: _getStatusColor(value).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.px),
            ),
            child: Text(
              value,
              style: MyTextStyle.titleStyle12b.copyWith(
                fontWeight: FontWeight.w800, // Very Bold Status
                color: _getStatusColor(value),
              ),
            ),
          )
        : Text(
            value,
            style: MyTextStyle.titleStyle13b.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black87), // Bold Black Value
            maxLines: isJobDescription ? 2 : null,
            overflow:
                isJobDescription ? TextOverflow.ellipsis : TextOverflow.visible,
          );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.px),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 18.px,
          ),
          SizedBox(width: 8.px),
          Container(
            width: 90.px, // Fixed width for clean alignment
            child: Text(
              '$title:',
              style: MyTextStyle.titleStyle13b.copyWith(
                  fontWeight: FontWeight.w800, // Extra Bold Title
                  color: Colors.black),
            ),
          ),
          Expanded(child: valueWidget),
        ],
      ),
    );
  }

  // Proper Card Widget based on user's reference style
  Widget _buildBookingCard(
      BuildContext context, BookingRequestData item, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.px),
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.px),
        border: Border.all(color: Colors.grey.shade300, width: 1.px),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------- Primary Info Rows -------------------
          _buildInfoRow(
              icon: Icons.calendar_today_outlined,
              title: 'Date',
              value: item.bookingDate ?? ''),

          _buildInfoRow(
              icon: Icons.location_on_outlined,
              title: 'Location',
              value: item.location ?? ''),

          _buildInfoRow(
              icon: Icons.info_outline,
              title: 'Status',
              value: item.bookingRequestStatus ?? '',
              isStatus: true),

          Divider(height: 20.px, color: Colors.grey.shade300),

          // ------------------- Job Description (Detailed) -------------------
          Padding(
            padding: EdgeInsets.only(bottom: 6.px),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.description_outlined,
                  color: primaryColor,
                  size: 18.px,
                ),
                SizedBox(width: 8.px),
                Text(
                  'Job Description:',
                  style: MyTextStyle.titleStyle13b.copyWith(
                      fontWeight: FontWeight.w800, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 26.px), // Align value below icon
            child: Text(
              item.jobDescription ?? 'No description provided',
              style: MyTextStyle.titleStyle13b.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                  height: 1.4),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
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
              onPressed: () {
                // Assuming you want to click on project detail from any tab
                Get.toNamed(Routes.BOOKING_DETAILS_USER, arguments: item);
              },
              child: Text(
                "View Details",
                style: MyTextStyle.titleStyle14bw, // White Text Style
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonWidgets.appBar(
            title: StringConstants.booking, wantBackButton: false),
        body: Obx(() {
          controller.count.value;
          return CommonWidgets.customProgressBar(
            inAsyncCall: controller.inAsyncCall.value,
            child: Padding(
              padding: EdgeInsets.all(10.0.px),
              child: RefreshIndicator(
                onRefresh: controller.pullRefresh,
                child: Column(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.tabIndex.value = 0;
                                  },
                                  child: Text(
                                    StringConstants.pending,
                                    style: controller.tabIndex.value == 0
                                        ? MyTextStyle.titleStyle14b.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: primaryColor)
                                        : MyTextStyle.titleStyle14b.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700),
                                  ),
                                ),
                                SizedBox(height: 10.px),
                                Container(
                                  height:
                                      controller.tabIndex.value == 0 ? 3 : 1,
                                  decoration: BoxDecoration(
                                      color: controller.tabIndex.value == 0
                                          ? primaryColor
                                          : Colors.grey.shade300,
                                      borderRadius:
                                          BorderRadius.circular(1.5.px)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.tabIndex.value = 1;
                                  },
                                  child: Text(
                                    StringConstants.completed,
                                    style: controller.tabIndex.value == 1
                                        ? MyTextStyle.titleStyle14b.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: primaryColor)
                                        : MyTextStyle.titleStyle14b.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700),
                                  ),
                                ),
                                SizedBox(height: 10.px),
                                Container(
                                  height:
                                      controller.tabIndex.value == 1 ? 3 : 1,
                                  decoration: BoxDecoration(
                                      color: controller.tabIndex.value == 1
                                          ? primaryColor
                                          : Colors.grey.shade300,
                                      borderRadius:
                                          BorderRadius.circular(1.5.px)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.tabIndex.value = 2;
                                  },
                                  child: Text(
                                    StringConstants.cancelled,
                                    style: controller.tabIndex.value == 2
                                        ? MyTextStyle.titleStyle14b.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: primaryColor)
                                        : MyTextStyle.titleStyle14b.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700),
                                  ),
                                ),
                                SizedBox(height: 10.px),
                                Container(
                                  height:
                                      controller.tabIndex.value == 2 ? 3 : 1,
                                  decoration: BoxDecoration(
                                      color: controller.tabIndex.value == 2
                                          ? primaryColor
                                          : Colors.grey.shade300,
                                      borderRadius:
                                          BorderRadius.circular(1.5.px)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: showTabs()),
                    SizedBox(height: 80.px)
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Widget tabScreen() {
    switch (3) {
      case 0:
        return showProcessingBooking();
      case 1:
        return showCompleteBooking();
      case 2:
        return showCancelBooking();
      default:
        return showProcessingBooking();
    }
  }

  Widget showTabs() {
    switch (controller.tabIndex.value) {
      case 0:
        return (!controller.inAsyncCall.value &&
                controller.processingBooking.isEmpty)
            ? CommonWidgets.dataNotFound()
            : showProcessingBooking();
      case 1:
        return (!controller.inAsyncCall.value &&
                controller.completeBooking.isEmpty)
            ? CommonWidgets.dataNotFound()
            : showCompleteBooking();
      case 2:
        return (!controller.inAsyncCall.value &&
                controller.rejectBooking.isEmpty)
            ? CommonWidgets.dataNotFound()
            : showCancelBooking();

      default:
        return showProcessingBooking();
    }
  }

  Widget showProcessingBooking() {
    return ListView.builder(
        itemCount: controller.processingBooking.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10.px),
        itemBuilder: (context, index) {
          return _buildBookingCard(
              context, controller.processingBooking[index], index);
        });
  }

  Widget showCompleteBooking() {
    return ListView.builder(
        itemCount: controller.completeBooking.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10.px),
        itemBuilder: (context, index) {
          return _buildBookingCard(
              context, controller.completeBooking[index], index);
        });
  }

  Widget showCancelBooking() {
    return ListView.builder(
        itemCount: controller.rejectBooking.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10.px),
        itemBuilder: (context, index) {
          return _buildBookingCard(
              context, controller.rejectBooking[index], index);
        });
  }
}
