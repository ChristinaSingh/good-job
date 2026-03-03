// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// import '../../../../common/colors.dart';
// import '../../../../common/common_widgets.dart';
// import '../../../../common/text_styles.dart';
// import '../../../data/constants/string_constants.dart';
// import '../controllers/booking_details_user_controller.dart';
//
// class BookingDetailsUserView extends GetView<BookingDetailsUserController> {
//   const BookingDetailsUserView({super.key});
//
//   // Helper function to get user-friendly booking status text
//   String _getBookingStatusDisplay(String status) {
//     switch (status) {
//       case 'PENDING':
//         return 'Waiting for Acceptance';
//       case 'ACCEPT':
//         return 'Accepted & Assigned';
//       case 'PROGRESS':
//         return 'Work in Progress';
//       case 'COMPLETED':
//       case 'DONE':
//         return 'Work has been Completed';
//       case 'CANCEL':
//         return 'Cancelled by User';
//       default:
//         return 'Status: $status';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: CommonWidgets.appBar(title: StringConstants.detail),
//       body: Obx(() {
//         controller.count.value;
//
//         final String currentPaymentStatus =
//             controller.paymentStatus.value.toUpperCase();
//
//         final String rawBookingStatus =
//             (controller.bookingDetails.bookingRequestStatus ?? '')
//                 .toUpperCase();
//
//         final bool isCompleted =
//             rawBookingStatus == 'COMPLETED' || rawBookingStatus == 'DONE';
//         final String displayBookingStatus =
//             _getBookingStatusDisplay(rawBookingStatus);
//
//         final bool isPaymentPending =
//             currentPaymentStatus == 'PENDING' || currentPaymentStatus.isEmpty;
//         final bool isPaymentCompleted = currentPaymentStatus == 'COMPLETED';
//         final bool isAccepted = rawBookingStatus == 'ACCEPT';
//         final bool isProgress = rawBookingStatus == 'PROGRESS';
//
//         final bool isProviderAssigned =
//             controller.bookingDetails.name != null &&
//                 controller.bookingDetails.name!.isNotEmpty;
//
//         final bool shouldEnablePayNow = isPaymentPending && isAccepted;
//         final bool shouldShowPayNowButton = !isPaymentCompleted;
//
//         final bool isPaymentLoading = controller.isLoading.value;
//
//         Color getStatusColor(String status) {
//           switch (status) {
//             case 'COMPLETED':
//             case 'DONE':
//               return Colors.green.shade700;
//             case 'ACCEPT':
//             case 'PROGRESS':
//               return Colors.blue.shade700;
//             case 'PENDING':
//               return Colors.orange.shade700;
//             case 'CANCEL':
//               return Colors.red.shade700;
//             default:
//               return Colors.black54;
//           }
//         }
//
//         return CommonWidgets.customProgressBar(
//           inAsyncCall: controller.inAsyncCall.value,
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 12.px),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Obx(() {
//                   controller.count.value;
//                   final gallery =
//                       controller.bookingDetails.bookingGallery ?? [];
//                   if (gallery.isEmpty) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(20.px),
//                       child: CommonWidgets.imageView(
//                         image: controller.bookingDetails.image ?? '',
//                         width: double.infinity,
//                         height: 200.px,
//                       ),
//                     );
//                   }
//                   return Column(
//                     children: [
//                       Stack(
//                         children: [
//                           CarouselSlider.builder(
//                             itemCount: gallery.length,
//                             itemBuilder: (context, index, realIndex) {
//                               final img = gallery[index].image ?? '';
//                               return Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 5.px),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(18.px),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black12,
//                                       blurRadius: 6,
//                                       offset: const Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(18.px),
//                                   child: CommonWidgets.imageView(
//                                     image: img,
//                                     width: double.infinity,
//                                     height: 220.px,
//                                   ),
//                                 ),
//                               );
//                             },
//                             options: CarouselOptions(
//                               height: 220.px,
//                               autoPlay: true,
//                               enlargeCenterPage: true,
//                               autoPlayInterval: const Duration(seconds: 3),
//                               viewportFraction: 1,
//                               onPageChanged: (index, reason) {
//                                 controller.currentPage.value = index;
//                               },
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 15.px,
//                             left: 0,
//                             right: 0,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: gallery.asMap().entries.map((entry) {
//                                 return Obx(() => AnimatedContainer(
//                                       duration:
//                                           const Duration(milliseconds: 300),
//                                       width: controller.currentPage.value ==
//                                               entry.key
//                                           ? 20.px
//                                           : 8.px,
//                                       height: 8.px,
//                                       margin: EdgeInsets.symmetric(
//                                           horizontal: 3.px),
//                                       color: controller.currentPage.value ==
//                                               entry.key
//                                           ? primaryColor
//                                           : Colors.grey.shade400,
//                                     ));
//                               }).toList(),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   );
//                 }),
//                 SizedBox(height: 20.px),
//                 Container(
//                   padding: EdgeInsets.all(16.px),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20.px),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (isProviderAssigned) ...[
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 20.px,
//                               backgroundImage: NetworkImage(
//                                 controller.bookingDetails.image ??
//                                     'https://cdn-icons-png.flaticon.com/512/149/149071.png',
//                               ),
//                               backgroundColor: Colors.grey.shade200,
//                             ),
//                             SizedBox(width: 10.px),
//                             Expanded(
//                               child: Text(
//                                 controller.bookingDetails.name ?? '',
//                                 style: MyTextStyle.titleStyle20gr.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10.px),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(Icons.location_on,
//                                 color: primaryColor, size: 18.px),
//                             SizedBox(width: 5.px),
//                             Expanded(
//                               child: Text(
//                                 controller.bookingDetails.location ??
//                                     'No address available',
//                                 style: MyTextStyle.titleStyle13b.copyWith(
//                                   color: Colors.grey.shade700,
//                                   height: 1.4,
//                                 ),
//                                 maxLines: 3,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 12.px),
//                         Row(
//                           children: [
//                             Icon(Icons.access_time,
//                                 color: primaryColor, size: 18.px),
//                             SizedBox(width: 5.px),
//                             Text(
//                               '9:30 AM',
//                               style: MyTextStyle.titleStyle13b
//                                   .copyWith(color: Colors.grey.shade800),
//                             ),
//                             const Spacer(),
//                             Icon(Icons.calendar_month,
//                                 color: primaryColor, size: 18.px),
//                             SizedBox(width: 5.px),
//                             Text(
//                               controller.bookingDetails.bookingDate ?? '',
//                               style: MyTextStyle.titleStyle13b
//                                   .copyWith(color: Colors.grey.shade800),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 12.px),
//                         Row(
//                           children: [
//                             Icon(Icons.send_outlined,
//                                 color: primaryColor, size: 18.px),
//                             SizedBox(width: 5.px),
//                             Text(
//                               '${controller.bookingDetails.distance ?? 0} miles',
//                               style: MyTextStyle.titleStyle13b
//                                   .copyWith(color: Colors.grey.shade800),
//                             ),
//                             const Spacer(),
//                             Icon(Icons.phone, color: primaryColor, size: 18.px),
//                             SizedBox(width: 5.px),
//                             Text(
//                               '+91 ${controller.bookingDetails.mobile ?? ''}',
//                               style: MyTextStyle.titleStyle13b
//                                   .copyWith(color: Colors.grey.shade800),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 18.px),
//                         Divider(color: Colors.grey.shade300, thickness: 1),
//                         SizedBox(height: 12.px),
//                       ] else ...[
//                         Padding(
//                           padding: EdgeInsets.only(bottom: 12.px),
//                           child: Center(
//                             child: Text(
//                               isAccepted
//                                   ? 'Provider details will be available after payment.'
//                                   : 'Waiting for provider acceptance...',
//                               textAlign: TextAlign.center,
//                               style: MyTextStyle.titleStyle16bb.copyWith(
//                                 color: Colors.black54,
//                                 fontStyle: FontStyle.italic,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Divider(color: Colors.grey.shade300, thickness: 1),
//                         SizedBox(height: 12.px),
//                       ],
//                       // --- BOOKING STATUS DISPLAY ---
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Booking Status",
//                             style: MyTextStyle.titleStyle18gr.copyWith(
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5.px,
//                           ),
//                           Text(
//                             displayBookingStatus,
//                             style: MyTextStyle.titleStyle14bb.copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: getStatusColor(rawBookingStatus),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 18.px),
//                       // --- JOB DESCRIPTION AND WORKING HOURS ---
//                       Text(
//                         StringConstants.jobDescription,
//                         style: MyTextStyle.titleStyle18gr
//                             .copyWith(fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(height: 6.px),
//                       Text(
//                         controller.bookingDetails.jobDescription ?? '',
//                         style: MyTextStyle.titleStyle13bb.copyWith(
//                           color: Colors.grey.shade800,
//                           height: 1.5,
//                         ),
//                       ),
//                       SizedBox(height: 18.px),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 StringConstants.workingHours,
//                                 style: MyTextStyle.titleStyle16bb
//                                     .copyWith(fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(height: 4.px),
//                               Text(
//                                 '${controller.bookingDetails.workingHours ?? "0"} hrs',
//                                 style: MyTextStyle.titleStyle14bb
//                                     .copyWith(color: Colors.grey.shade800),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 25.px),
//                       // --- PAYMENT DETAILS ---
//                       Text(
//                         "Payment Details:",
//                         style: MyTextStyle.titleStyle18gr.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       SizedBox(height: 10.px),
//                       Container(
//                         padding: EdgeInsets.all(12.px),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(12.px),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Payment Status:",
//                                   style: MyTextStyle.titleStyle16bb.copyWith(
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 Obx(() => Text(
//                                       controller.paymentStatus.value.isEmpty
//                                           ? 'N/A'
//                                           : controller.paymentStatus.value
//                                               .toUpperCase(),
//                                       style:
//                                           MyTextStyle.titleStyle16bb.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         color: isPaymentCompleted
//                                             ? Colors.green.shade700
//                                             : isPaymentPending
//                                                 ? Colors.red.shade700
//                                                 : Colors.orange.shade700,
//                                       ),
//                                     )),
//                               ],
//                             ),
//                             SizedBox(height: 8.px),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Amount:",
//                                   style: MyTextStyle.titleStyle16bb.copyWith(
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 Text(
//                                   "${controller.bookingDetails.amount ?? '0'} LKR",
//                                   style: MyTextStyle.titleStyle16bb.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blueGrey.shade800,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 15.px),
//                       if (!isCompleted) ...[
//                         AnimatedSwitcher(
//                           duration: const Duration(milliseconds: 400),
//                           child: shouldShowPayNowButton
//                               ? SizedBox(
//                                   key: const ValueKey("payNowButton"),
//                                   width: double.infinity,
//                                   child: ElevatedButton(
//                                     onPressed: (shouldEnablePayNow &&
//                                             !isPaymentLoading)
//                                         ? () => controller.submitPayment()
//                                         : null,
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: (shouldEnablePayNow &&
//                                               !isPaymentLoading)
//                                           ? Colors.amber.shade700
//                                           : Colors.grey.shade400,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.px),
//                                       ),
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 12.px),
//                                     ),
//                                     child: isPaymentLoading
//                                         ? SizedBox(
//                                             height: 18.px,
//                                             width: 18.px,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2,
//                                               color: Colors.white,
//                                             ),
//                                           )
//                                         : Text(
//                                             "PAY NOW",
//                                             style: MyTextStyle.titleStyle16bw
//                                                 .copyWith(
//                                               fontWeight: FontWeight.bold,
//                                               color: shouldEnablePayNow
//                                                   ? Colors.white
//                                                   : Colors.black54,
//                                             ),
//                                           ),
//                                   ),
//                                 )
//                               : Container(
//                                   key: const ValueKey("paymentCompleted"),
//                                   padding:
//                                       EdgeInsets.symmetric(vertical: 12.px),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "✅ Payment Completed",
//                                     style: MyTextStyle.titleStyle16bb.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.green.shade700,
//                                     ),
//                                   ),
//                                 ),
//                         ),
//                         SizedBox(height: 20.px),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: (isPaymentLoading ||
//                                         controller.inAsyncCall.value)
//                                     ? null
//                                     : () => controller
//                                         .clickOnAcceptRejectButton('CANCEL'),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.redAccent,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.px),
//                                   ),
//                                   padding:
//                                       EdgeInsets.symmetric(vertical: 12.px),
//                                 ),
//                                 child: Text("Cancel Booking",
//                                     style: MyTextStyle.titleStyle16bw),
//                               ),
//                             ),
//                             SizedBox(width: 12.px),
//                             if (isProviderAssigned)
//                               Expanded(
//                                 child: ElevatedButton.icon(
//                                   onPressed: (isPaymentLoading ||
//                                           controller.inAsyncCall.value)
//                                       ? null
//                                       : () => controller.clickOnChat(),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.indigo.shade500,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(10.px),
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 10.px, vertical: 12.px),
//                                     elevation: 1,
//                                   ),
//                                   icon: Icon(Icons.chat_outlined,
//                                       color: Colors.white, size: 18.px),
//                                   label: Text("Chat",
//                                       style: MyTextStyle.titleStyle14bw),
//                                 ),
//                               ),
//                           ],
//                         ),
//                         SizedBox(height: 20.px),
//                       ] else ...[
//                         SizedBox(height: 15.px),
//                         Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(vertical: 15.px),
//                             child: Text(
//                               "✅ Work has been completed.",
//                               style: TextStyle(
//                                 fontSize: 16.px,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.green.shade700,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/booking_details_user_controller.dart';

class BookingDetailsUserView extends GetView<BookingDetailsUserController> {
  const BookingDetailsUserView({super.key});

  // Helper function to get user-friendly booking status text
  String _getBookingStatusDisplay(String status) {
    switch (status) {
      case 'PENDING':
        return 'Waiting for Acceptance';
      case 'ACCEPT':
        return 'Accepted & Assigned';
      case 'PROGRESS':
        return 'Work in Progress';
      case 'COMPLETED':
      case 'DONE':
        return 'Work has been Completed';
      case 'CANCEL':
        return 'Cancelled by User';
      default:
        return 'Status: $status';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CommonWidgets.appBar(title: StringConstants.detail),
      body: Obx(() {
        controller.count.value;

        final String currentPaymentStatus =
            controller.paymentStatus.value.toUpperCase();

        final String rawBookingStatus =
            (controller.bookingDetails.bookingRequestStatus ?? '')
                .toUpperCase();

        final bool isCompleted =
            rawBookingStatus == 'COMPLETED' || rawBookingStatus == 'DONE';
        // --- Added isCancelled flag ---
        final bool isCancelled = rawBookingStatus == 'CANCEL';
        // ------------------------------
        final String displayBookingStatus =
            _getBookingStatusDisplay(rawBookingStatus);

        final bool isPaymentPending =
            currentPaymentStatus == 'PENDING' || currentPaymentStatus.isEmpty;
        final bool isPaymentCompleted = currentPaymentStatus == 'COMPLETED';
        final bool isAccepted = rawBookingStatus == 'ACCEPT';
        final bool isProgress = rawBookingStatus == 'PROGRESS';

        final bool isProviderAssigned =
            controller.bookingDetails.name != null &&
                controller.bookingDetails.name!.isNotEmpty;

        final bool shouldEnablePayNow = isPaymentPending && isAccepted;
        final bool shouldShowPayNowButton = !isPaymentCompleted;

        final bool isPaymentLoading = controller.isLoading.value;

        Color getStatusColor(String status) {
          switch (status) {
            case 'COMPLETED':
            case 'DONE':
              return Colors.green.shade700;
            case 'ACCEPT':
            case 'PROGRESS':
              return Colors.blue.shade700;
            case 'PENDING':
              return Colors.orange.shade700;
            case 'CANCEL':
              return Colors.red.shade700;
            default:
              return Colors.black54;
          }
        }

        return CommonWidgets.customProgressBar(
          inAsyncCall: controller.inAsyncCall.value,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 12.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  controller.count.value;
                  final gallery =
                      controller.bookingDetails.bookingGallery ?? [];
                  if (gallery.isEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20.px),
                      child: CommonWidgets.imageView(
                        image: controller.bookingDetails.image ?? '',
                        width: double.infinity,
                        height: 200.px,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Stack(
                        children: [
                          CarouselSlider.builder(
                            itemCount: gallery.length,
                            itemBuilder: (context, index, realIndex) {
                              final img = gallery[index].image ?? '';
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.px),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.px),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18.px),
                                  child: CommonWidgets.imageView(
                                    image: img,
                                    width: double.infinity,
                                    height: 220.px,
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 220.px,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                controller.currentPage.value = index;
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 15.px,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: gallery.asMap().entries.map((entry) {
                                return Obx(() => AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: controller.currentPage.value ==
                                              entry.key
                                          ? 20.px
                                          : 8.px,
                                      height: 8.px,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 3.px),
                                      color: controller.currentPage.value ==
                                              entry.key
                                          ? primaryColor
                                          : Colors.grey.shade400,
                                    ));
                              }).toList(),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }),
                SizedBox(height: 20.px),
                Container(
                  padding: EdgeInsets.all(16.px),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.px),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isProviderAssigned) ...[
                        // --- PROVIDER DETAILS BLOCK ---
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20.px,
                              backgroundImage: NetworkImage(
                                controller.bookingDetails.image ??
                                    'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                              ),
                              backgroundColor: Colors.grey.shade200,
                            ),
                            SizedBox(width: 10.px),
                            Expanded(
                              child: Text(
                                controller.bookingDetails.name ?? '',
                                style: MyTextStyle.titleStyle20gr.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.px),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on,
                                color: primaryColor, size: 18.px),
                            SizedBox(width: 5.px),
                            Expanded(
                              child: Text(
                                controller.bookingDetails.location ??
                                    'No address available',
                                style: MyTextStyle.titleStyle13b.copyWith(
                                  color: Colors.grey.shade700,
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.px),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                color: primaryColor, size: 18.px),
                            SizedBox(width: 5.px),
                            Text(
                              '9:30 AM',
                              style: MyTextStyle.titleStyle13b
                                  .copyWith(color: Colors.grey.shade800),
                            ),
                            const Spacer(),
                            Icon(Icons.calendar_month,
                                color: primaryColor, size: 18.px),
                            SizedBox(width: 5.px),
                            Text(
                              controller.bookingDetails.bookingDate ?? '',
                              style: MyTextStyle.titleStyle13b
                                  .copyWith(color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.px),
                        Row(
                          children: [
                            Icon(Icons.send_outlined,
                                color: primaryColor, size: 18.px),
                            SizedBox(width: 5.px),
                            Text(
                              '${controller.bookingDetails.distance ?? 0} miles',
                              style: MyTextStyle.titleStyle13b
                                  .copyWith(color: Colors.grey.shade800),
                            ),
                            const Spacer(),
                            Icon(Icons.phone, color: primaryColor, size: 18.px),
                            SizedBox(width: 5.px),
                            Text(
                              '+91 ${controller.bookingDetails.mobile ?? ''}',
                              style: MyTextStyle.titleStyle13b
                                  .copyWith(color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.px),
                        Divider(color: Colors.grey.shade300, thickness: 1),
                        SizedBox(height: 12.px),
                      ]
                      // --- FIX: Waiting message only if NOT Assigned, NOT Completed, NOT Cancelled ---
                      else if (!isCompleted && !isCancelled) ...[
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.px),
                          child: Center(
                            child: Text(
                              isAccepted
                                  ? 'Provider details will be available after payment.'
                                  : 'Waiting for provider acceptance...',
                              textAlign: TextAlign.center,
                              style: MyTextStyle.titleStyle16bb.copyWith(
                                color: Colors.black54,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey.shade300, thickness: 1),
                        SizedBox(height: 12.px),
                      ],
                      // --- END OF FIX ---

                      // --- BOOKING STATUS DISPLAY ---
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Booking Status",
                            style: MyTextStyle.titleStyle18gr.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5.px,
                          ),
                          Text(
                            displayBookingStatus,
                            style: MyTextStyle.titleStyle14bb.copyWith(
                              fontWeight: FontWeight.bold,
                              color: getStatusColor(rawBookingStatus),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.px),
                      // --- JOB DESCRIPTION AND WORKING HOURS ---
                      Text(
                        StringConstants.jobDescription,
                        style: MyTextStyle.titleStyle18gr
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 6.px),
                      Text(
                        controller.bookingDetails.jobDescription ?? '',
                        style: MyTextStyle.titleStyle13bb.copyWith(
                          color: Colors.grey.shade800,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 18.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StringConstants.workingHours,
                                style: MyTextStyle.titleStyle16bb
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4.px),
                              Text(
                                '${controller.bookingDetails.workingHours ?? "0"} hrs',
                                style: MyTextStyle.titleStyle14bb
                                    .copyWith(color: Colors.grey.shade800),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 25.px),
                      // --- PAYMENT DETAILS ---
                      Text(
                        "Payment Details:",
                        style: MyTextStyle.titleStyle18gr.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10.px),
                      Container(
                        padding: EdgeInsets.all(12.px),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12.px),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment Status:",
                                  style: MyTextStyle.titleStyle16bb.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Obx(() => Text(
                                      controller.paymentStatus.value.isEmpty
                                          ? 'N/A'
                                          : controller.paymentStatus.value
                                              .toUpperCase(),
                                      style:
                                          MyTextStyle.titleStyle16bb.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isPaymentCompleted
                                            ? Colors.green.shade700
                                            : isPaymentPending
                                                ? Colors.red.shade700
                                                : Colors.orange.shade700,
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(height: 8.px),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Amount:",
                                  style: MyTextStyle.titleStyle16bb.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  "${controller.bookingDetails.amount ?? '0'} LKR",
                                  style: MyTextStyle.titleStyle16bb.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.px),
                      // --- BUTTONS/STATUS MESSAGES BLOCK (Checks for Completed and Cancelled) ---
                      if (!isCompleted && !isCancelled) ...[
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: shouldShowPayNowButton
                              ? SizedBox(
                                  key: const ValueKey("payNowButton"),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: (shouldEnablePayNow &&
                                            !isPaymentLoading)
                                        ? () => controller.submitPayment()
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: (shouldEnablePayNow &&
                                              !isPaymentLoading)
                                          ? Colors.amber.shade700
                                          : Colors.grey.shade400,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.px),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.px),
                                    ),
                                    child: isPaymentLoading
                                        ? SizedBox(
                                            height: 18.px,
                                            width: 18.px,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            "PAY NOW",
                                            style: MyTextStyle.titleStyle16bw
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: shouldEnablePayNow
                                                  ? Colors.white
                                                  : Colors.black54,
                                            ),
                                          ),
                                  ),
                                )
                              : Container(
                                  key: const ValueKey("paymentCompleted"),
                                  padding:
                                      EdgeInsets.symmetric(vertical: 12.px),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "✅ Payment Completed",
                                    style: MyTextStyle.titleStyle16bb.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(height: 20.px),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: (isPaymentLoading ||
                                        controller.inAsyncCall.value)
                                    ? null
                                    : () => controller
                                        .clickOnAcceptRejectButton('CANCEL'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.px),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(vertical: 12.px),
                                ),
                                child: Text("Cancel Booking",
                                    style: MyTextStyle.titleStyle16bw),
                              ),
                            ),
                            SizedBox(width: 12.px),
                            if (isProviderAssigned)
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: (isPaymentLoading ||
                                          controller.inAsyncCall.value)
                                      ? null
                                      : () => controller.clickOnChat(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo.shade500,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.px),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.px, vertical: 12.px),
                                    elevation: 1,
                                  ),
                                  icon: Icon(Icons.chat_outlined,
                                      color: Colors.white, size: 18.px),
                                  label: Text("Chat",
                                      style: MyTextStyle.titleStyle14bw),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 20.px),
                      ] else if (isCancelled) ...[
                        // --- Cancelled Message ---
                        SizedBox(height: 15.px),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.px),
                            child: Text(
                              "❌ Booking has been cancelled by the user.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.px,
                                fontWeight: FontWeight.w600,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.px),
                      ] else ...[
                        // --- Completed Message ---
                        SizedBox(height: 15.px),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.px),
                            child: Text(
                              "✅ Work has been completed.",
                              style: TextStyle(
                                fontSize: 16.px,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
