import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common/text_styles.dart';
import '../../../data/constants/icons_constant.dart';
import '../controllers/provider_project_detail_controller.dart';

class ProviderProjectDetailView
    extends GetView<ProviderProjectDetailController> {
  const ProviderProjectDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CommonWidgets.appBar(title: StringConstants.detail),
      body: Obx(() {
        controller.count.value;

        final String paymentStatus =
            (controller.bookingDetails.paymentStatus ?? '').toUpperCase();
        final bool isPaymentCompleted = paymentStatus == 'COMPLETED';
        final String bookingStatus =
            (controller.bookingDetails.bookingRequestStatus ?? '')
                .toUpperCase();

        final bool isPending = bookingStatus == 'PENDING';
        final bool isAccepted = bookingStatus == 'ACCEPT';
        final bool isInProgress = bookingStatus == 'INPROGRESS';
        final bool isCompleted =
            bookingStatus == 'COMPLETED' || bookingStatus == 'DONE';

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
                          viewportFraction: 0.9,
                          onPageChanged: (index, reason) {
                            controller.currentPage.value = index;
                          },
                        ),
                      ),
                      SizedBox(height: 10.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: gallery.asMap().entries.map((entry) {
                          return Obx(() => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: controller.currentPage.value == entry.key
                                    ? 20.px
                                    : 8.px,
                                height: 8.px,
                                margin: EdgeInsets.symmetric(horizontal: 3.px),
                                color: controller.currentPage.value == entry.key
                                    ? primaryColor
                                    : Colors.grey.shade400,
                              ));
                        }).toList(),
                      ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amount",
                                style: MyTextStyle.titleStyle16bb
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4.px),
                              Text(
                                'LKR ${controller.bookingDetails.amount ?? "0"}',
                                style: MyTextStyle.titleStyle14bb.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.px),
                      if (isAccepted || isInProgress || isCompleted) ...[
                        Divider(color: Colors.grey.shade300, thickness: 1),
                        SizedBox(height: 15.px),
                        Text(
                          "Payment Status:",
                          style: MyTextStyle.titleStyle18gr.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10.px),
                        Container(
                          padding: EdgeInsets.all(12.px),
                          decoration: BoxDecoration(
                            color: isPaymentCompleted
                                ? Colors.green.shade50
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12.px),
                            border: Border.all(
                                color: isPaymentCompleted
                                    ? Colors.green.shade300
                                    : Colors.red.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isPaymentCompleted
                                    ? "Payment Received"
                                    : "Payment Pending",
                                style: MyTextStyle.titleStyle16bb.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isPaymentCompleted
                                      ? Colors.green.shade800
                                      : Colors.red.shade800,
                                ),
                              ),
                              Text(
                                paymentStatus.isEmpty
                                    ? 'PENDING'
                                    : paymentStatus,
                                style: MyTextStyle.titleStyle16bb.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isPaymentCompleted
                                      ? Colors.green.shade800
                                      : Colors.red.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.px),
                      ],
                      if (isAccepted)
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 20.px, left: 5.px, right: 5.px),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              controller.clickOnStartJobButton();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.px),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14.px),
                              minimumSize: Size(double.infinity, 0),
                            ),
                            icon: Icon(Icons.location_on_outlined,
                                color: Colors.white),
                            label: Text(
                              "Reacted at location | Tap to start work",
                              style: MyTextStyle.titleStyle16bw.copyWith(
                                  fontSize: 17.px, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      if (isInProgress)
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.px),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              controller.clickOnEndJobButton();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.px),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14.px),
                              minimumSize: Size(double.infinity, 0),
                            ),
                            icon: Icon(Icons.check_circle_outline,
                                color: Colors.white),
                            label: Text(
                              "Press here to Complete Job",
                              style: MyTextStyle.titleStyle16bw.copyWith(
                                  fontSize: 17.px, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      if (isPending)
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => controller
                                    .clickOnAcceptRejectButton('CANCEL'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.px),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(vertical: 12.px),
                                ),
                                child: Text("Decline",
                                    style: MyTextStyle.titleStyle16bw),
                              ),
                            ),
                            SizedBox(width: 12.px),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  controller
                                      .clickOnAcceptRejectButton('ACCEPT');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.px),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(vertical: 12.px),
                                ),
                                child: Text(
                                  StringConstants.accept,
                                  style: MyTextStyle.titleStyle16bw,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (isAccepted || isInProgress)
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () => controller.clickOnChat(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.px),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.px, vertical: 12.px),
                              elevation: 1,
                            ),
                            icon:
                                Icon(Icons.chat_outlined, color: Colors.white),
                            label: Text("Chat with Client",
                                style: MyTextStyle.titleStyle14bw),
                          ),
                        ),
                      SizedBox(height: 20.px),
                      if (isAccepted)
                        Center(
                          child: TextButton.icon(
                            onPressed: () => controller.clickOnViewButton(),
                            icon: Icon(Icons.directions,
                                color: primaryColor, size: 20.px),
                            label: Text(
                              StringConstants.directions,
                              style: MyTextStyle.titleStyle16bb.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
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
