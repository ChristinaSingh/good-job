import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_constants/api_key_constants.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:good_job/common/colors.dart';
import 'package:good_job/common/common_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/local_data.dart';
import '../../../../common/text_styles.dart';
import '../../../data/apis/api_models/get_booking_request_model.dart';

class BookingTackingController extends GetxController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final cancelIndex = 0.obs;
  GoogleMapController? mapController;
  BookingRequestData bookingData = Get.arguments;
  LatLng initialposition =
      LatLng(double.parse(LocalData.lat), double.parse(LocalData.lon));
  double originLatitude = double.parse(LocalData.lat);
  double originLongitude = double.parse(LocalData.lon);
  Map<MarkerId, Marker> markers = {};

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> myPolylineCoordinates = [];
  List<String> cancelRegions = [
    'Changed my mind',
    'Found a different option',
    'Serviceman ask to cancel',
    'Other (Please specify)'
  ];
  @override
  void onInit() {
    super.onInit();
    addMarker(LatLng(originLatitude, originLongitude), "origin");
    print(
        'picuplatlong ${double.parse(bookingData.lat ?? '51.1657')} ,${double.parse(bookingData.lon ?? '10.4515')}');
    addMarker(
        LatLng(double.parse(bookingData.lat ?? '51.1657'),
            double.parse(bookingData.lon ?? '10.4515')),
        "destination");
    getPolyline(double.parse(bookingData.lat ?? '51.1657'),
        double.parse(bookingData.lon ?? '10.4515'));

    // Future.delayed(const Duration(seconds: 2), () {
    //   // getUserProfile();
    //   increment();
    // });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  addMarker(LatLng position, String id) async {
    MarkerId markerId = MarkerId(id);
    if (id == 'origin') {
      BitmapDescriptor descriptor = BitmapDescriptor.defaultMarker;
      // await BitmapDescriptor.fromAssetImage(
      //     const ImageConfiguration(devicePixelRatio: 3.2),
      //     IconConstants.icMapArrow);
      Marker marker =
          Marker(markerId: markerId, icon: descriptor, position: position);
      markers[markerId] = marker;
    } else {
      BitmapDescriptor descriptor = BitmapDescriptor.defaultMarker;
      Marker marker =
          Marker(markerId: markerId, icon: descriptor, position: position);
      markers[markerId] = marker;
    }
  }

  void getPolyline(double userLat, double userLong) async {
    print('Start polyline drawing .... $userLat $userLong');
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      // "AIzaSyDVGu8kdO0adFI__fwaV1m0ftSqEpD5NA8",
      "AIzaSyDT62NXFvZu9qKdh96SkstdkV43cXadFyc",
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(userLat, userLong),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    myPolylineCoordinates.addAll(polylineCoordinates);
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      color: primaryColor,
      width: 5,
    );
    polylines[id] = polyline;
    increment();
  }

  void fitPolyline() {
    print('print start bounding ....');
    if (mapController != null && myPolylineCoordinates.isNotEmpty) {
      LatLngBounds bounds = boundsFromLatLngList(myPolylineCoordinates);

      mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
      mapController!.getVisibleRegion().then((bounds) {
        double zoomLevel = calculateZoomLevel(bounds, myPolylineCoordinates);
        mapController!.animateCamera(CameraUpdate.zoomTo(zoomLevel));
      });

      print('print complete polyline bounding ....');
    } else {
      print('print Failed polyline bounding ....');
    }
  }

  double calculateZoomLevel(LatLngBounds bounds, List<LatLng> polyline) {
    double zoomLevel = 14.0; // Default zoom level

    double minZoomLat = 360.0;
    double maxZoomLat = -360.0;
    double minZoomLng = 360.0;
    double maxZoomLng = -360.0;

    for (LatLng point in polyline) {
      if (point.latitude < minZoomLat) minZoomLat = point.latitude;
      if (point.latitude > maxZoomLat) maxZoomLat = point.latitude;
      if (point.longitude < minZoomLng) minZoomLng = point.longitude;
      if (point.longitude > maxZoomLng) maxZoomLng = point.longitude;
    }

    double deltaLat = maxZoomLat - minZoomLat;
    double deltaLng = maxZoomLng - minZoomLng;

    double zoomLat = zoom(deltaLat);
    double zoomLng = zoom(deltaLng);

    zoomLevel = min(zoomLat, zoomLng);
    return zoomLevel - 1.0;
  }

  double zoom(double delta) {
    return log(360.0 / delta) / ln2;
  }

  // Function to compute the bounding box of polyline coordinates
  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double minLat = list.first.latitude;
    double maxLat = list.first.latitude;
    double minLng = list.first.longitude;
    double maxLng = list.first.longitude;

    for (LatLng latLng in list) {
      minLat = min(minLat, latLng.latitude);
      maxLat = max(maxLat, latLng.latitude);
      minLng = min(minLng, latLng.longitude);
      maxLng = max(maxLng, latLng.longitude);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  void clickOnRating() {
    Map<String, String> data = {
      ApiKeyConstants.providerId: bookingData.providerId ?? '',
      ApiKeyConstants.userId: bookingData.userId ?? '',
      ApiKeyConstants.name: bookingData.name ?? '',
      ApiKeyConstants.image: bookingData.image ?? '',
    };
    Get.toNamed(Routes.ADD_REVIEW, parameters: data);
  }

  /// Bottom Sheet .....
  void openCancelBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.px),
                topRight: Radius.circular(15.px))),
        backgroundColor: primary3Color,
        isScrollControlled: false,
        constraints: BoxConstraints(maxHeight: 500.px),
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
                height: 500.px,
                margin: EdgeInsets.all(8.px),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.px),
                        topRight: Radius.circular(15.px))),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            height: 25.px,
                            width: 25.px,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.px),
                                color: Colors.black87),
                            child: Icon(
                              Icons.close,
                              size: 20.px,
                              color: primary3Color,
                            )),
                      ),
                    ),
                    Text(
                      'Please select the reason for cancellation:',
                      style: MyTextStyle.titleStyle20bb,
                    ),
                    SizedBox(
                      height: 10.px,
                    ),
                    ListView.builder(
                        itemCount: cancelRegions.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(5.px),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cancelIndex.value = index;
                                    });
                                  },
                                  child: cancelIndex.value == index
                                      ? Icon(
                                          Icons.check_circle,
                                          size: 25.px,
                                          color: Colors.orangeAccent,
                                        )
                                      : Icon(
                                          Icons.circle_outlined,
                                          size: 25.px,
                                          color: Colors.orangeAccent,
                                        ),
                                ),
                                SizedBox(
                                  width: 10.px,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cancelRegions[index],
                                        style: MyTextStyle.titleStyle16b,
                                      ),
                                      SizedBox(
                                        height: 5.px,
                                      ),
                                      Divider(
                                        thickness: 1.px,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20.px,
                    ),
                    CommonWidgets.commonElevatedButton(
                        onPressed: () {},
                        child: Text(
                          StringConstants.submit,
                          style: MyTextStyle.titleStyle16bw,
                        ))
                  ],
                ));
          });
        });
  }
}
