import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:good_job/app/data/apis/api_models/get_all_provider_model.dart';
import 'package:good_job/app/data/constants/string_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter_api/google_places_flutter_api.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common/colors.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/apis/api_methods/api_methods.dart';
import '../../../data/constants/icons_constant.dart';

class MapController extends GetxController {
  TextEditingController searchController = TextEditingController();
  GoogleMapController? xController;
  LatLng myCurrentPosition = LatLng(51.1657, 10.4515);
  List<AllProviderData> providerList = [];
  Map<MarkerId, Marker> markers = {};
  final currentAddress = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    checkPermission();
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
  Future<void> addMarker(LatLng position, String userImage, String id) async {
    final Uint8List markerIcon =
        await _getCircularMarkerIconFromNetwork(userImage, 55);
    BitmapDescriptor userIcon = BitmapDescriptor.fromBytes(markerIcon);
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: userIcon, position: position);
    markers[markerId] = marker;
  }

  Future<Uint8List> _getCircularMarkerIconFromNetwork(
      String imageUrl, double radius) async {
    // Load the marker background image
    ByteData data = await rootBundle.load(IconConstants.icMarker);
    ui.Codec markerCodec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo markerFrame = await markerCodec.getNextFrame();
    ui.Image markerImage = markerFrame.image;

    // Load the user image
    final Completer<ui.Image> completer = Completer();
    final ImageStream stream =
        CachedNetworkImageProvider(imageUrl).resolve(ImageConfiguration());

    stream.addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));

    final ui.Image userImage = await completer.future;

    // Draw the custom marker
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final Paint paint = Paint()..isAntiAlias = true;

    final double markerWidth = markerImage.width.toDouble();
    final double markerHeight = markerImage.height.toDouble();
    final double centerX = markerWidth / 2;
    final double centerY = markerHeight / 2.5;
    final double size = radius * 2;

    // Draw the marker background
    canvas.drawImage(markerImage, Offset.zero, paint);

    // Draw the user image inside the marker
    paint.blendMode = BlendMode.srcIn;

    canvas.drawCircle(
      Offset(
          markerWidth / 6, markerHeight / 6), // Adjust the position as needed
      radius,
      paint,
    );

    // Draw the user image inside the circle
    paint.blendMode = BlendMode.srcIn;
    final Rect oval = Rect.fromCircle(
      center: Offset(markerWidth / 2, markerHeight / 2.2),
      radius: radius,
    );
    canvas.clipPath(Path()..addOval(oval));
    canvas.drawImageRect(
      userImage,
      Rect.fromLTRB(0, 0, userImage.width.toDouble() - 20,
          userImage.height.toDouble() - 20),

      // Rect.fromLTRB((markerWidth / 2) - radius, (markerHeight / 2.5) - radius,
      //     (markerWidth / 2) + radius, (markerHeight / 2.5) + radius),
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      paint,
    );

    final ui.Image customMarkerImage = await recorder
        .endRecording()
        .toImage(markerWidth.toInt(), markerHeight.toInt());
    final ByteData? byteData =
        await customMarkerImage.toByteData(format: ui.ImageByteFormat.png);
    print('Done...........');
    increment();
    return byteData!.buffer.asUint8List();
  }

  clickOnAllLocationsTextField() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: Get.context!,
      apiKey: "AIzaSyDT62NXFvZu9qKdh96SkstdkV43cXadFyc",
      mode: Mode.overlay,
    );
    if (p != null) {
      currentAddress.value = p.description ?? '';
      final locations = await locationFromAddress(p.description ?? '');
      onMapTapped(LatLng(locations.first.latitude, locations.first.longitude));
    }
  }

  Future<void> getProvider(double lat, double lon) async {
    Map<String, dynamic> bodyParameter = {
      ApiKeyConstants.currentLat: lat.toString(),
      ApiKeyConstants.currentLon: lon.toString(),
    };
    markers.clear();
    providerList.clear();
    AllProviderModel? allProviderModel =
        await ApiMethods.getAllProviderApi(bodyParams: bodyParameter);

    if (allProviderModel != null &&
        allProviderModel.status == '1' &&
        allProviderModel.data != null &&
        allProviderModel.data!.isNotEmpty) {
      providerList = allProviderModel.data!;
      for (int i = 0; i < providerList.length; i++) {
        addMarker(
            LatLng(double.parse(providerList[i].lat ?? '51.1657'),
                double.parse(providerList[i].lon ?? '10.4515')),
            providerList[i].gallery![0].image ??
                StringConstants.defaultNetworkImage,
            providerList[i].id ?? '1');
        print("driver nu..." + (i.toString()));
        print("list of marker : ${markers.length}");
      }

      // increment();
    }
  }

  void onMapTapped(LatLng position) async {
    print("Position:-${position.latitude},${position.longitude}");
    myCurrentPosition = position;
    getProvider(myCurrentPosition.latitude, myCurrentPosition.longitude);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    currentAddress.value =
        '${placemarks.reversed.last.subLocality ?? ''},${placemarks.reversed.last.administrativeArea ?? ''}'
        '${placemarks.reversed.last.postalCode ?? ''},${placemarks.reversed.last.country ?? ''}';
    searchController.text = currentAddress.value;
    xController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: position,
      zoom: 15,
    )));
    increment();
  }

  Future<void> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showPermissionAlert();
    } else {
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Permission Denied.....');
      showPermissionAlert();
    } else {
      print('Permission Granted.....');
      Position currentPosition = await Geolocator.getCurrentPosition();
      onMapTapped(LatLng(currentPosition.latitude, currentPosition.longitude));
    }
  }

  void showPermissionAlert() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.px)), //this right here
            child: Container(
              height: 450.px,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 150.px,
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: 20.px,
                  ),
                  CommonWidgets.gradientText(
                      StringConstants.enableLocation, 25),
                  SizedBox(
                    height: 10.px,
                  ),
                  Text(
                    StringConstants
                        .toUseThisServicesWeNeedPermissionToAccess.tr,
                    style: MyTextStyle.titleStyle12b,
                    textAlign: TextAlign.center,
                  ),
                  CommonWidgets.commonGradientButton(
                      onPressed: () async {
                        Get.back();
                        LocationPermission permission =
                            await Geolocator.requestPermission();
                        if (permission == LocationPermission.denied) {
                          print('Permission Denied.....');
                          showPermissionAlert();
                        } else {
                          print('Permission Granted.....');
                          getCurrentLocation();
                        }
                      },
                      child: Text(
                        StringConstants.enableLocation,
                        style: MyTextStyle.titleStyle16bw,
                      ),
                      buttonMargin: EdgeInsets.only(bottom: 10.px, top: 20)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      CommonWidgets.showMyToastMessage(
                          'Without location permission you can not use app...');
                      showPermissionAlert();
                    },
                    child: Container(
                      height: 50.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10.px, bottom: 20.px),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.px),
                          color: Colors.purpleAccent.withOpacity(0.1)),
                      child: Text(
                        StringConstants.cancel.tr,
                        style: MyTextStyle.titleStyle16bw,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
