import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:good_job/common/text_styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../data/constants/icons_constant.dart';
import '../controllers/booking_tacking_controller.dart';

class BookingTackingView extends GetView<BookingTackingController> {
  const BookingTackingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      controller.count.value;
      return CommonWidgets.customProgressBar(
          inAsyncCall: controller.inAsyncCall.value,
          child: Stack(
            children: [
              Positioned.fill(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height - 300.px,
                    child: MyGoogleMap()),
              ),
              Positioned(
                  top: 60.px,
                  left: 10.px,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Center(
                      child: CommonWidgets.appIcons(
                        assetName: IconConstants.icBack,
                        height: 36.px,
                        width: 36.px,
                      ),
                    ),
                  )),
              Positioned(
                bottom: 0,
                width: context.width,
                child: Container(
                  padding: EdgeInsets.all(15.px),
                  decoration: BoxDecoration(
                      color: primary3Color,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.px),
                          topRight: Radius.circular(15.px))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringConstants.providerIsArriving,
                            style: MyTextStyle.titleStyle18bb,
                          ),
                          Text(
                            '2 min',
                            style: MyTextStyle.titleStyle14b,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.px,
                      ),
                      Divider(
                        thickness: 1.px,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CommonWidgets.imageView(
                              image: controller.bookingData.image ??
                                  StringConstants.defaultNetworkImage,
                              width: 80.px,
                              height: 80.px,
                              defaultNetworkImage:
                                  StringConstants.defaultNetworkImage),
                          SizedBox(
                            width: 5.px,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              controller.clickOnRating();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.bookingData.name ?? '',
                                  style: MyTextStyle.titleStyle18bb,
                                ),
                                Row(
                                  children: [
                                    RatingBar.readOnly(
                                      filledIcon: Icons.star,
                                      filledColor: Colors.orangeAccent,
                                      emptyIcon: Icons.star,
                                      emptyColor: Colors.grey.withOpacity(0.5),
                                      initialRating: 3,
                                      size: 15.px,
                                      maxRating: 5,
                                    ),
                                    Text(
                                      '4.5 (2,495) ',
                                      style: MyTextStyle.titleStyle10b,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                          CommonWidgets.appIcons(
                              assetName: IconConstants.icCall,
                              width: 42.px,
                              height: 42.px),
                          SizedBox(
                            width: 10.px,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.openCancelBottomSheet(context);
                            },
                            child: CommonWidgets.appIcons(
                                assetName: IconConstants.icClose,
                                width: 42.px,
                                height: 42.px),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.px,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ));
    }));
  }

  Widget MyGoogleMap() {
    return GoogleMap(
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      markers: Set<Marker>.of(controller.markers.values),
      polylines: Set<Polyline>.of(controller.polylines.values),
      // onCameraMove: controller.onCameraMove,
      //initialCameraPosition:_kGooglePlex,
      initialCameraPosition: CameraPosition(
        // target:  LatLng(startLocation.value.latitude,startLocation.value.longitude),
        target: controller.initialposition,
        zoom: 15.0,
      ),
      onMapCreated: (createController) {
        controller.mapController = createController;
        controller.fitPolyline();
        controller.increment();
      },
      myLocationEnabled: true,
    );
  }
}
