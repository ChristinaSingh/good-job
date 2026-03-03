import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:good_job/app/routes/app_pages.dart';
import 'package:good_job/common/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/FirebaseMessagingService.dart';
import '../../../../common/PushNotificationService.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/local_data.dart';
import '../../../../common/text_styles.dart';
import '../../../data/apis/api_constants/api_key_constants.dart';
import '../../../data/constants/string_constants.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  SharedPreferences? prefs;
  Future<void> setupInteractedMessage() async {
    print('Push Notification for ios in foreground.......');
    // Get device token...
    PushNotificationService.getToken();
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    print('Notification pressed ios:-');
    print('Notification title:-${notification!.title}');
    print('Notification body:-${notification.body}');
    await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
     Get.toNamed(Routes.NOTIFICATION);
  }


  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
    if (Platform.isAndroid) {
      await notificationSetup();
    } else {
      if (Platform.isIOS) {
        await setupInteractedMessage();
      }
    }
    manageSession();
    // checkPermission();
    // sendNotification();
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

  manageSession() async {
    checkPermission();
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("TOKEN:::::::::::${prefs.getString(ApiKeyConstants.userId)}");
    if (prefs.getString(ApiKeyConstants.userId) != null) {
      if (prefs.getString(ApiKeyConstants.type) == 'USER') {
        Get.offNamed(Routes.NAV_BAR);
      } else {
        Get.offNamed(Routes.PROVIDER_NAV_BAR);
      }
    } else {
      Get.offAndToNamed(Routes.USER_TYPE);
    }
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
      String lat = currentPosition.latitude.toString();
      String lon = currentPosition.longitude.toString();
      List<Placemark> list = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      String address =
          '${list[0].locality},${list[0].postalCode},${list[0].country}';
      LocalData.setLatLon(lat, lon, address);
      //manageSession();
    }
  }
  Future<void> notificationSetup() async {
    var initialzationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print('Push Notification for android in foreground.......');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                //   channel.description,
                color: Colors.white,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
      if (message != null) {
        print('Notification aaaaaaaaaaaaaaaaaaa ::::::::::::::::::::::');
        print(
            'Notification aaaaaaaaaaaaaaaaaaa :::::::::::::::::::::: ${notification!.title}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('Notification pressed:-');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print('Notification pressed:-');
        print('Notification pressed:-${notification.body!}');
        await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
        Get.toNamed(Routes.NOTIFICATION);
      }
    });
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    PushNotificationService.getToken();
  }

  void sendNotification() {
    final MyLocalNotificationService _localNotificationService =
    MyLocalNotificationService();
    _localNotificationService.initializeSettings(Get.context!);
    // _localNotificationService.showSimpleNotification();
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
