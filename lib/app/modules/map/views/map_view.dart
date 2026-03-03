import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_job/common/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/common_widgets.dart';
import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            markers: Set<Marker>.of(controller.markers.values),
            // onCameraMove: controller.onCameraMove,
            initialCameraPosition: CameraPosition(
              target: controller.myCurrentPosition,
              zoom: 15.0,
            ),
            onMapCreated: (mapController) {
              controller.xController = mapController;
              zoomToLocation();
              controller.increment();
            },
            myLocationEnabled: true,
            onTap: controller.onMapTapped,
          ),
          Positioned(
              top: 110.px,
              left: 20.px,
              right: 20.px,
              child: Container(
                height: 60.px,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.px),
                    color: primary3Color),
                child: CommonWidgets.commonTextFieldForLoginSignUP(
                  controller: controller.searchController,
                  onTap: () {
                    controller.clickOnAllLocationsTextField();
                  },
                  suffixIcon: Icon(
                    Icons.location_on_rounded,
                    size: 25.px,
                    color: primaryColor,
                  ),
                ),
              )),
          // if (controller.showDetails.value)
          //   Positioned(
          //       bottom: 100.px,
          //       left: 20.px,
          //       right: 20.px,
          //       child: Stack(
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               controller.clickOnEventOpenEventDetail(
          //                   controller.showDetailIndex.value);
          //             },
          //             child: Container(
          //               height: 130.px,
          //               padding: EdgeInsets.all(10.px),
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(20.px),
          //                   color: primary3Color),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   CommonWidgets.imageView(
          //                       image: controller
          //                               .eventList[
          //                                   controller.showDetailIndex.value]
          //                               .images![0]
          //                               .image ??
          //                           '',
          //                       height: 120.px,
          //                       width: 135.px),
          //                   Expanded(
          //                     child: Padding(
          //                       padding: EdgeInsets.only(left: 5.px),
          //                       child: Column(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceAround,
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Text(
          //                             controller
          //                                     .eventList[controller
          //                                         .showDetailIndex.value]
          //                                     .title ??
          //                                 '',
          //                             style: MyTextStyle.titleStyle18bb,
          //                             overflow: TextOverflow.ellipsis,
          //                           ),
          //                           CommonWidgets.gradientText(
          //                               controller
          //                                   .eventList[controller
          //                                       .showDetailIndex.value]
          //                                   .dateTime
          //                                   .toString(),
          //                               12),
          //                           Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.start,
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.center,
          //                             children: [
          //                               CommonWidgets.appIcons(
          //                                 assetName: IconConstants.icLocation,
          //                                 height: 25.px,
          //                                 width: 25.px,
          //                               ),
          //                               Expanded(
          //                                 child: Text(
          //                                   controller
          //                                           .eventList[controller
          //                                               .showDetailIndex.value]
          //                                           .address ??
          //                                       '',
          //                                   style: MyTextStyle.titleStyle12b,
          //                                   overflow: TextOverflow.ellipsis,
          //                                 ),
          //                               ),
          //                             ],
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //               top: 5.px,
          //               right: 5.px,
          //               child: GestureDetector(
          //                 onTap: () {
          //                   controller.showDetails.value = false;
          //                 },
          //                 child: Icon(
          //                   Icons.cancel_outlined,
          //                   size: 25.px,
          //                   color: Colors.purpleAccent,
          //                 ),
          //               ))
          //         ],
          //       ))
        ],
      );
    });
  }

  void zoomToLocation() async {
    if (controller.xController != null) {
      final CameraPosition newPosition = CameraPosition(
        target: controller.myCurrentPosition,
        zoom: 15.0, // Adjust the zoom level as needed
      );

      await controller.xController!
          .animateCamera(CameraUpdate.newCameraPosition(newPosition));
    }
  }
}
