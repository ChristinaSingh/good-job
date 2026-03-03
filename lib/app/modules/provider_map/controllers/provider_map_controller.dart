/// testing code

///final code
import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:good_job/common/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/local_data.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/apis/api_models/get_booking_request_model.dart';
import '../../../data/apis/api_models/get_simple_model.dart';
import '../../../data/constants/icons_constant.dart';

class ProviderMapController extends GetxController {
  GoogleMapController? mapController;
  BookingRequestData bookingData = Get.arguments;
  LatLng initialPosition =
      LatLng(double.parse(LocalData.lat), double.parse(LocalData.lon));
  double originLatitude = double.parse(LocalData.lat);
  double originLongitude = double.parse(LocalData.lon);
  Map<MarkerId, Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> myPolylineCoordinates = [];
  final count = 0.obs;
  late StreamSubscription<Position> positionStream;
  RxBool inAsyncCall = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermissionAndGetLocation();
  }

  @override
  void onClose() {
    positionStream.cancel();
    super.onClose();
  }

  void increment() => count.value++;

  // Check for permission and get location only once
  Future<void> checkPermissionAndGetLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permission denied.');
        return;
      }
    }

    positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      updateCurrentLocation(LatLng(position.latitude, position.longitude));
      getPolyline(double.parse(bookingData.lat ?? '51.1657'),
          double.parse(bookingData.lon ?? '10.4515'));
    });
  }

  // Update the current location and markers
  void updateCurrentLocation(LatLng newLocation) async {
    MarkerId markerId = MarkerId("origin");
    BitmapDescriptor descriptor = await getMarkerIcon(IconConstants.icMapArrow);

    // Update marker position
    markers[markerId] = Marker(
      markerId: markerId,
      icon: descriptor,
      position: newLocation,
    );

    // Ensure destination marker is added only once
    if (!markers.containsKey(MarkerId('destination'))) {
      addMarker(
        LatLng(double.parse(bookingData.lat ?? '51.1657'),
            double.parse(bookingData.lon ?? '10.4515')),
        "destination",
        IconConstants.icDestination,
      );
    }

    // Clear old polyline to prevent misalignment
    myPolylineCoordinates.add(newLocation);

    addPolyLine(myPolylineCoordinates);
    fitPolyline();

    // Start animating the marker to follow the polyline
    await animateMarkerToLocation(LatLng(
        double.parse(bookingData.lat ?? '51.1657'),
        double.parse(bookingData.lon ?? '10.4515')));

    update();
  }

  // Animate the marker from the origin to the destination along the polyline
  Future<void> animateMarkerToLocation(LatLng destination) async {
    // For animation, update marker position in steps
    for (int i = 0; i < myPolylineCoordinates.length; i++) {
      LatLng newPosition = myPolylineCoordinates[i];

      // Update the marker position in the markers map
      markers[MarkerId("origin")] =
          markers[MarkerId("origin")]!.copyWith(positionParam: newPosition);

      // Animate the camera to the new marker position
      mapController!.animateCamera(CameraUpdate.newLatLng(newPosition));

      // Delay to make the movement smooth
      await Future.delayed(
          Duration(milliseconds: 100)); // Adjust the duration for smoothness
    }
  }

  // Add marker to the map
  Future<void> addMarker(LatLng position, String id, String icon) async {
    MarkerId markerId = MarkerId(id);
    BitmapDescriptor descriptor = await getMarkerIcon(icon);

    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
    );
    markers[markerId] = marker;
  }

  // Get the marker icon asynchronously
  Future<BitmapDescriptor> getMarkerIcon(String icon) async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 3.2),
      icon,
    );
  }

  // Get the polyline between the origin and destination
  Future<void> getPolyline(double userLat, double userLong) async {
    print('Start polyline drawing .... $userLat $userLong');

    // Reset polyline coordinates to prevent incorrect paths
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDT62NXFvZu9qKdh96SkstdkV43cXadFyc",
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(userLat, userLong),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print("Polyline error: ${result.errorMessage}");
    }

    // Replace instead of appending to avoid incorrect paths
    myPolylineCoordinates.clear();
    myPolylineCoordinates.addAll(polylineCoordinates);

    addPolyLine(myPolylineCoordinates);
  }

  // Add polyline to the map
  void addPolyLine(List<LatLng> polylineCoordinates) {
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

  // Fit the bounds of the polyline and adjust zoom
  void fitPolyline() {
    if (mapController != null && myPolylineCoordinates.isNotEmpty) {
      LatLngBounds bounds = boundsFromLatLngList([
        LatLng(originLatitude, originLongitude),
        LatLng(double.parse(bookingData.lat ?? '51.1657'),
            double.parse(bookingData.lon ?? '10.4515'))
      ]);

      mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
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

  // Function to calculate the zoom level
  double calculateZoomLevel(LatLngBounds bounds, List<LatLng> polyline) {
    double zoomLevel = 14.0; // Default zoom level

    // Adjust the zoom level based on polyline bounds
    double deltaLat = bounds.northeast.latitude - bounds.southwest.latitude;
    double deltaLng = bounds.northeast.longitude - bounds.southwest.longitude;

    // Calculate the zoom level based on the latitudinal and longitudinal deltas
    double zoomLat = zoom(deltaLat);
    double zoomLng = zoom(deltaLng);

    zoomLevel = min(zoomLat, zoomLng);

    // Ensure the zoom level is within a reasonable range
    zoomLevel = zoomLevel > 18.0 ? 18.0 : zoomLevel; // Set an upper zoom limit
    zoomLevel = zoomLevel < 10.0 ? 10.0 : zoomLevel; // Set a lower zoom limit

    return zoomLevel;
  }

  double zoom(double delta) {
    return log(360.0 / delta) / ln2;
  }

  void clickOnStartWorkButton() async {
    inAsyncCall.value = true;
    try {
      Map<String, String> bodyParams = {
        ApiKeyConstants.bookingId: bookingData.bookingRequestId ?? '',
        ApiKeyConstants.status: 'INPROGRESS'
      };

      SimpleModel? simpleModel = await ApiMethods.acceptRejectBookingRequestApi(
          bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != '0') {
        // CommonWidgets.showMyToastMessage(simpleModel.message ?? '');
        Get.toNamed(Routes.PROVIDER_WORKING_PROCESS, arguments: bookingData);
      } else {
        CommonWidgets.showMyToastMessage(simpleModel!.message!);
      }
      inAsyncCall.value = false;
    } catch (e) {
      inAsyncCall.value = false;
      CommonWidgets.showMyToastMessage('Some thing is wrong ...');
    }
  }
}

///alternate code
// import 'dart:async';
// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:good_job/app/routes/app_pages.dart';
// import 'package:good_job/common/colors.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../../../common/local_data.dart';
// import '../../../data/apis/api_models/get_booking_request_model.dart';
// import '../../../data/constants/icons_constant.dart';
//
// class ProviderMapController extends GetxController {
//   GoogleMapController? mapController;
//   BookingRequestData bookingData = Get.arguments;
//   LatLng initialPosition =
//   LatLng(double.parse(LocalData.lat), double.parse(LocalData.lon));
//   double originLatitude = double.parse(LocalData.lat);
//   double originLongitude = double.parse(LocalData.lon);
//   Map<MarkerId, Marker> markers = {};
//
//   PolylinePoints polylinePoints = PolylinePoints();
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> myPolylineCoordinates = [];
//   final count = 0.obs;
//   late StreamSubscription<Position> positionStream;
//   @override
//   void onInit() {
//     super.onInit();
//     checkPermissionAndGetLocation();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     positionStream.cancel();
//     super.onClose();
//   }
//
//   void increment() => count.value++;
//
//   Future<void> checkPermissionAndGetLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       print('Location services are disabled.');
//       return;
//     }
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         print('Location permission denied.');
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       print('Location permission permanently denied, we cannot request permission.');
//       return;
//     }
//
//     positionStream = Geolocator.getPositionStream(
//       locationSettings: LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 10,
//       ),
//     ).listen((Position position) {
//       print('Updated location: Latitude: ${position.latitude}, Longitude: ${position.longitude}');
//       originLatitude = position.latitude;
//       originLongitude = position.longitude;
//       updateCurrentLocation(LatLng(originLatitude, originLongitude));
//       getPolyline(double.parse(bookingData.lat ?? '51.1657'),
//           double.parse(bookingData.lon ?? '10.4515'));
//     });
//   }
//
//   void updateCurrentLocation(LatLng newLocation) {
//     addMarker(newLocation, "origin", IconConstants.icMapArrow); // Origin marker
//     if (!markers.containsKey(MarkerId('destination'))) {
//       addMarker(
//         LatLng(double.parse(bookingData.lat ?? '51.1657'), double.parse(bookingData.lon ?? '10.4515')),
//         "destination",
//         IconConstants.icDestination,
//       );
//     }
//     if (myPolylineCoordinates.isNotEmpty) {
//       myPolylineCoordinates.add(newLocation);
//     } else {
//       myPolylineCoordinates.add(newLocation);
//     }
//     addPolyLine(myPolylineCoordinates);
//     fitPolyline();
//   }
//
//   void addMarker(LatLng position, String id, String icon) async {
//     MarkerId markerId = MarkerId(id);
//     BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(devicePixelRatio: 3.2),
//       icon,
//     );
//
//     Marker marker = Marker(
//       markerId: markerId,
//       icon: descriptor,
//       position: position,
//     );
//     markers[markerId] = marker;
//   }
//
//   void getPolyline(double userLat, double userLong) async {
//     print('Start polyline drawing .... $userLat $userLong');
//     List<LatLng> polylineCoordinates = [];
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "AIzaSyDT62NXFvZu9qKdh96SkstdkV43cXadFyc",  // Your API Key
//       PointLatLng(originLatitude, originLongitude),
//       PointLatLng(userLat, userLong),
//       travelMode: TravelMode.driving,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     myPolylineCoordinates.addAll(polylineCoordinates);
//     addPolyLine(polylineCoordinates);
//   }
//
//   void addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       points: polylineCoordinates,
//       color: primaryColor,
//       width: 5,
//     );
//     polylines[id] = polyline;
//     increment();
//   }
//
//   void fitPolyline() {
//     print('Starting to fit the bounds...');
//     if (mapController != null && myPolylineCoordinates.isNotEmpty) {
//       LatLngBounds bounds = boundsFromLatLngList(myPolylineCoordinates);
//       LatLngBounds completeBounds = boundsFromLatLngList([
//         LatLng(originLatitude, originLongitude),
//         LatLng(double.parse(bookingData.lat ?? '51.1657'), double.parse(bookingData.lon ?? '10.4515'))
//       ]);
//
//       mapController!.animateCamera(CameraUpdate.newLatLngBounds(completeBounds, 50));
//       mapController!.getVisibleRegion().then((visibleBounds) {
//         double zoomLevel = calculateZoomLevel(visibleBounds, myPolylineCoordinates);
//         mapController!.animateCamera(CameraUpdate.zoomTo(zoomLevel));
//       });
//
//       print('Bounds set successfully.');
//     } else {
//       print('Failed to fit bounds: No polyline coordinates found.');
//     }
//   }
//
//   // Function to compute the bounding box of polyline coordinates
//   LatLngBounds boundsFromLatLngList(List<LatLng> list) {
//     double minLat = list.first.latitude;
//     double maxLat = list.first.latitude;
//     double minLng = list.first.longitude;
//     double maxLng = list.first.longitude;
//
//     for (LatLng latLng in list) {
//       minLat = min(minLat, latLng.latitude);
//       maxLat = max(maxLat, latLng.latitude);
//       minLng = min(minLng, latLng.longitude);
//       maxLng = max(maxLng, latLng.longitude);
//     }
//
//     return LatLngBounds(
//       southwest: LatLng(minLat, minLng),
//       northeast: LatLng(maxLat, maxLng),
//     );
//   }
//
//   double calculateZoomLevel(LatLngBounds bounds, List<LatLng> polyline) {
//     double zoomLevel = 14.0; // Default zoom level
//
//     // Adjust the zoom level based on polyline bounds
//     double deltaLat = bounds.northeast.latitude - bounds.southwest.latitude;
//     double deltaLng = bounds.northeast.longitude - bounds.southwest.longitude;
//
//     // Calculate the zoom level based on the latitudinal and longitudinal deltas
//     double zoomLat = zoom(deltaLat);
//     double zoomLng = zoom(deltaLng);
//
//     zoomLevel = min(zoomLat, zoomLng);
//
//     // Ensure the zoom level is within a reasonable range
//     zoomLevel = zoomLevel > 18.0 ? 18.0 : zoomLevel;  // Set an upper zoom limit
//     zoomLevel = zoomLevel < 10.0 ? 10.0 : zoomLevel;  // Set a lower zoom limit
//
//     return zoomLevel;
//   }
//
//   double zoom(double delta) {
//     return log(360.0 / delta) / ln2;
//   }
//
//   // Function that is triggered when the "Start" button is clicked
//   void clickOnStartButton() {
//     Get.toNamed(Routes.PROVIDER_WORKING_PROCESS, arguments: bookingData);
//   }
// }

// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../../../common/colors.dart';
// import '../../../data/apis/api_models/get_booking_request_model.dart';
// import '../../../data/constants/icons_constant.dart';
// import '../../../routes/app_pages.dart';
//
// class ProviderMapController extends GetxController {
//   GoogleMapController? mapController;
//   BookingRequestData bookingData = Get.arguments;
//   LatLng initialPosition = LatLng(0.0, 0.0);  // Default value for initial position
//   double originLatitude = 0.0;
//   double originLongitude = 0.0;
//   Map<MarkerId, Marker> markers = {};
//
//   PolylinePoints polylinePoints = PolylinePoints();
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> myPolylineCoordinates = [];
//
//   final count = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _getCurrentLocation();  // Fetch current location when the controller is initialized
//     print(
//         'picuplatlong ${double.parse(bookingData.lat ?? '51.1657')} ,${double.parse(bookingData.lon ?? '10.4515')}');
//     addMarker(
//         LatLng(double.parse(bookingData.lat ?? '51.1657'),
//             double.parse(bookingData.lon ?? '10.4515')),
//         "destination");
//     getPolyline(double.parse(bookingData.lat ?? '51.1657'),
//         double.parse(bookingData.lon ?? '10.4515'));
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   void increment() => count.value++;
//
//   void clickOnStartButton() {
//     Get.toNamed(Routes.PROVIDER_WORKING_PROCESS, arguments: bookingData);
//   }
//
//   // Function to get the current location of the user
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return;
//       }
//     }
//
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     // Update the origin coordinates
//     originLatitude = position.latitude;
//     originLongitude = position.longitude;
//
//     // Update initial position to user's current location
//     initialPosition = LatLng(originLatitude, originLongitude);
//
//     // Add marker for current location (source)
//     addMarker(initialPosition, "origin");
//
//     // Recalculate polyline and adjust camera once the location is updated
//     getPolyline(double.parse(bookingData.lat ?? '51.1657'),
//         double.parse(bookingData.lon ?? '10.4515'));
//     fitPolyline();
//   }
//
//   // Add marker function
//   addMarker(LatLng position, String id) async {
//     MarkerId markerId = MarkerId(id);
//     BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(devicePixelRatio: 3.2),
//       IconConstants.icMapArrow,  // Ensure you have the correct asset path here
//     );
//     Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }
//
//   // Function to get polyline between the current location (origin) and the destination
//   void getPolyline(double userLat, double userLong) async {
//     print('Start polyline drawing .... $userLat $userLong');
//     List<LatLng> polylineCoordinates = [];
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "AIzaSyDT62NXFvZu9qKdh96SkstdkV43cXadFyc", // Replace with your actual API key
//       PointLatLng(originLatitude, originLongitude),
//       PointLatLng(userLat, userLong),
//       travelMode: TravelMode.driving,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     myPolylineCoordinates.addAll(polylineCoordinates);
//     addPolyLine(polylineCoordinates);
//   }
//
//   // Add polyline to the map
//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       points: polylineCoordinates,
//       color: primaryColor,
//       width: 5,
//     );
//     polylines[id] = polyline;
//     increment();
//   }
//
//   // Function to adjust map to fit polyline
//   void fitPolyline() {
//     print('print start bounding ....');
//     if (mapController != null && myPolylineCoordinates.isNotEmpty) {
//       LatLngBounds bounds = boundsFromLatLngList(myPolylineCoordinates);
//       mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
//       mapController!.getVisibleRegion().then((bounds) {
//         double zoomLevel = calculateZoomLevel(bounds, myPolylineCoordinates);
//         mapController!.animateCamera(CameraUpdate.zoomTo(zoomLevel));
//       });
//       print('print complete polyline bounding ....');
//     } else {
//       print('print Failed polyline bounding ....');
//     }
//   }
//
//   // Function to compute zoom level
//   double calculateZoomLevel(LatLngBounds bounds, List<LatLng> polyline) {
//     double zoomLevel = 14.0; // Default zoom level
//     double minZoomLat = 360.0;
//     double maxZoomLat = -360.0;
//     double minZoomLng = 360.0;
//     double maxZoomLng = -360.0;
//
//     for (LatLng point in polyline) {
//       if (point.latitude < minZoomLat) minZoomLat = point.latitude;
//       if (point.latitude > maxZoomLat) maxZoomLat = point.latitude;
//       if (point.longitude < minZoomLng) minZoomLng = point.longitude;
//       if (point.longitude > maxZoomLng) maxZoomLng = point.longitude;
//     }
//
//     double deltaLat = maxZoomLat - minZoomLat;
//     double deltaLng = maxZoomLng - minZoomLng;
//
//     double zoomLat = zoom(deltaLat);
//     double zoomLng = zoom(deltaLng);
//
//     zoomLevel = min(zoomLat, zoomLng);
//     return zoomLevel - 1.0;
//   }
//
//   double zoom(double delta) {
//     return log(360.0 / delta) / ln2;
//   }
//
//   // Function to compute the bounding box of polyline coordinates
//   LatLngBounds boundsFromLatLngList(List<LatLng> list) {
//     double minLat = list.first.latitude;
//     double maxLat = list.first.latitude;
//     double minLng = list.first.longitude;
//     double maxLng = list.first.longitude;
//
//     for (LatLng latLng in list) {
//       minLat = min(minLat, latLng.latitude);
//       maxLat = max(maxLat, latLng.latitude);
//       minLng = min(minLng, latLng.longitude);
//       maxLng = max(maxLng, latLng.longitude);
//     }
//
//     return LatLngBounds(
//       southwest: LatLng(minLat, minLng),
//       northeast: LatLng(maxLat, maxLng),
//     );
//   }
// }
