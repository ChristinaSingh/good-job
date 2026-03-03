import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/data/constants/icons_constant.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/searvice_form_controller.dart';

class SearviceFormView extends GetView<SearviceFormController> {
  const SearviceFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBar(
        title: controller.parameters[ApiKeyConstants.title],
      ),
      body: Obx(() {
        // Reactive rebuild whenever controller.count changes
        controller.count.value;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 3.px),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ✅ Calendar Section with Green Border
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.px),
                    border: Border.all(
                      color: primaryColor, // 💚 green border
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: 20.px),
                  child: Padding(
                    padding: EdgeInsets.all(10.px),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2024, 1, 1),
                      lastDay: DateTime.utc(2026, 12, 31),
                      focusedDay: controller.focusDate,
                      calendarFormat: CalendarFormat.month,
                      selectedDayPredicate: (day) =>
                          isSameDay(controller.focusDate, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        controller.focusDate = selectedDay;
                        controller.increment(); // updates count
                      },
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: MyTextStyle.titleStyle16bb,
                        leftChevronIcon:
                            Icon(Icons.chevron_left, color: primaryColor),
                        rightChevronIcon:
                            Icon(Icons.chevron_right, color: primaryColor),
                      ),
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        isTodayHighlighted: true,
                        todayDecoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: const TextStyle(color: Colors.white),
                        todayTextStyle: const TextStyle(color: Colors.black),
                        weekendTextStyle:
                            const TextStyle(color: Colors.redAccent),
                        cellMargin: EdgeInsets.all(4.px),
                      ),
                    ),
                  ),
                ),

                /// ✅ Approximate Working Hours Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.px),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.only(top: 10.px, bottom: 20.px),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.px, vertical: 20.px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringConstants.approximateWorkingHours,
                              style: MyTextStyle.titleStyle16bb,
                            ),
                            Text(
                              StringConstants.maximumWorkingHours24,
                              style: MyTextStyle.titleStyle10b,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 90.px,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (controller.workingHours.value > 1) {
                                    controller.decreaseWorkingHours();
                                  }
                                },
                                child: CommonWidgets.appIcons(
                                  assetName: IconConstants.icMinus,
                                  width: 27.px,
                                  height: 26.px,
                                ),
                              ),
                              Text(
                                controller.workingHours.value.toString(),
                                style: MyTextStyle.titleStyle16bb,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.workingHours.value < 25) {
                                    controller.incrementWorkingHours();
                                  }
                                },
                                child: CommonWidgets.appIcons(
                                  assetName: IconConstants.icPlus,
                                  width: 27.px,
                                  height: 26.px,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// ✅ Job Description
                Text(
                  StringConstants.tellUsAboutTheJob,
                  style: MyTextStyle.titleStyle14gr,
                ),
                CommonWidgets.commonTextFieldForLoginSignUP(
                  controller: controller.jobDescriptionController,
                  hintText: StringConstants.description,
                  maxLines: 7,
                  isCard: true,
                ),
                SizedBox(height: 20.px),

                /// ✅ Location
                Text(
                  StringConstants.whereIsTheJob,
                  style: MyTextStyle.titleStyle14gr,
                ),
                CommonWidgets.commonTextFieldForLoginSignUP(
                  controller: controller.locationController,
                  hintText: StringConstants.yourLocation,
                  readOnly: true,
                  isCard: true,
                  onTap: () {
                    controller.clickOnAllLocationsTextField();
                  },
                ),
                SizedBox(height: 10.px),

                Text(
                  StringConstants.aHouseHoldMustBeAvailableUntilCompleteOfJob,
                  style: MyTextStyle.titleStyle13gr.copyWith(color: Colors.red),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10.px),

                /// ✅ Photos Section
                Text(
                  StringConstants.showUsTheWork,
                  style: MyTextStyle.titleStyle20bb,
                  textAlign: TextAlign.center,
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10.px,
                    crossAxisSpacing: 10.px,
                    childAspectRatio: 1.0,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.imageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        controller.showAlertDialog(index);
                      },
                      child: DottedBorder(
                        color: primaryColor,
                        dashPattern: const [4, 2],
                        strokeWidth: 2.px,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(14.px),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            controller.imageList[index] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15.px),
                                    child: Image.file(
                                      controller.imageList[index]!,
                                      height: 75.px,
                                      width: 75.px,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : const SizedBox(),
                            Center(
                              child: CommonWidgets.appIcons(
                                assetName: IconConstants.icAdd,
                                height: 25.px,
                                width: 25.px,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.px),

                Text(
                  StringConstants
                      .pleaseIncludeAMinimum4ClearPhotoRelatedToTheJob,
                  style: MyTextStyle.titleStyle13gr,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10.px),

                /// ✅ Submit Button
                CommonWidgets.commonElevatedButton(
                  showLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.clickOnBookButton();
                  },
                  child: Text(
                    StringConstants.addJob,
                    style: MyTextStyle.titleStyle16bw,
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
