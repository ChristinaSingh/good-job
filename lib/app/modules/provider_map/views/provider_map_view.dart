import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/text_styles.dart';
import '../../../data/constants/icons_constant.dart';
import '../../../data/constants/string_constants.dart';
import '../controllers/provider_map_controller.dart';

class ProviderMapView extends GetView<ProviderMapController> {
  const ProviderMapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // This line is not necessary, but if you're using count for reactivity, ensure it's used properly
      controller.count.value;

      return CommonWidgets.customProgressBar(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: CommonWidgets.commonElevatedButton(
          //   onPressed: () {
          //     controller.clickOnStartWorkButton();
          //   },
          //   child: Text(
          //     "Arrived at Location\nTap to Start Work",
          //     style: MyTextStyle.titleStyle16bw,
          //   ),
          //   buttonColor: primaryColor,
          //   buttonMargin: EdgeInsets.symmetric(horizontal: 5.px, vertical: 10.px),
          // ),
          body: Obx(() {
            controller.count.value;

            return Stack(
              children: [
                Positioned.fill(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: MyGoogleMap(controller),
                  ),
                ),
                Positioned(
                  top: 50.px,
                  left: 20.px,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(shape: BoxShape.circle , color: primaryColor),
                      child: Center(
                        child: CommonWidgets.appIcons(
                          assetName: IconConstants.icBack,
                          height: 36.px,
                          width: 36.px,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.px, // Adjusted positioning for the details card
                  left: 20.px,
                  right: 20.px,
                  child: Container(
                    padding: EdgeInsets.all(12.px),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.px),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.bookingData.name ?? '',
                          style: MyTextStyle.titleStyle20gr,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: 20.px, color: Colors.grey),
                            SizedBox(width: 5.px),
                            Expanded(
                              child: Text(
                                controller.bookingData.location ?? '',
                                style: MyTextStyle.titleStyle14b,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.px),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 20.px, color: Colors.grey),
                            SizedBox(width: 5.px),
                            Text('+91 ${controller.bookingData.mobile}', style: MyTextStyle.titleStyle14b),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }

  Widget MyGoogleMap(ProviderMapController controller) {
    return GoogleMap(
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      markers: Set<Marker>.of(controller.markers.values),
      polylines: Set<Polyline>.of(controller.polylines.values),
      initialCameraPosition: CameraPosition(
        target: LatLng(controller.originLatitude, controller.originLongitude),
        zoom: 15.0,
      ),
      onMapCreated: (GoogleMapController createController) {
        controller.mapController = createController;
        controller.fitPolyline();
        controller.increment();
      },
      myLocationEnabled: false,
    );
  }
}
