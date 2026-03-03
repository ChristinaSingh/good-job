import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/data/apis/api_constants/api_key_constants.dart';
import 'common_widgets.dart';

class MyHttp {
  static Future<http.Response?> getMethod(
      {required String url, void Function(int)? checkResponse}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ApiKeyConstants.token);
    Map<String, String> authorization = {};
    authorization = {
      "Authorization": "Bearer ${token ?? ''}",
      'Accept': 'application/json'
    };
    if (kDebugMode) print("URL:: $url");
    if (kDebugMode) print("TOKEN:: $authorization");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.get(
          Uri.parse(url),
          headers: authorization,
        );
        if (kDebugMode) print("CALLING:: ${response.body}");
        if (await CommonWidgets.responseCheckForGetMethod(response: response)) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            print(
                "ERROR::statusCode=${response.statusCode}: :response=${response.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) print("EXCEPTION:: Server Down $e");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> getMethodParams(
      {required Map<String, dynamic> queryParameters,
      required String baseUri,
      required String endPointUri,
      void Function(int)? checkResponse}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ApiKeyConstants.token);
    Map<String, String> authorization = {};
    authorization = {
      "Authorization": "Bearer ${token ?? ''}",
      'Accept': 'application/json'
    };
    if (kDebugMode) print("endPointUri:: $endPointUri");
    if (kDebugMode) print("BASEURL:: $baseUri");
    if (kDebugMode) print("TOKEN:: $authorization");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        Uri uri = Uri.http(baseUri, endPointUri, queryParameters);
        if (kDebugMode) print("URI:: $uri");
        http.Response? response = await http.get(uri, headers: authorization);
        if (kDebugMode) print("CALLING:: ${response.body}");
        if (await CommonWidgets.responseCheckForGetMethod(
          response: response,
        )) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            print(
                "ERROR::statusCode=${response.statusCode}: :response=${response.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) print("EXCEPTION:: Server Down");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> postMethod(
      {required String url,
      Map<String, dynamic>? bodyParams,
      bool wantSnackBar = false,
      void Function(int)? checkResponse}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ApiKeyConstants.token);
    Map<String, String> authorization = {};
    authorization = {
      "Authorization": "Bearer ${token ?? ''}",
      'Accept': 'application/json'
    };
    if (kDebugMode) print("URL:: $url");
    if (kDebugMode) print("TOKEN:: $authorization");
    if (kDebugMode) print("bodyParams:: ${bodyParams ?? {}}");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.post(
          Uri.parse(url),
          body: bodyParams ?? {},
          headers: authorization,
        );
        if (kDebugMode) print("CALLING:: ${response.statusCode}");
        if (kDebugMode) print("CALLING:: ${response.body}");
        if (await CommonWidgets.responseCheckForPostMethod(
          wantSnackBar: wantSnackBar,
          response: response,
        )) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            print(
                "ERROR::statusCode=${response.statusCode}: :response=${response.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) print("EXCEPTION:: Server Down $e");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> deleteMethod(
      {required String url,
      required Map<String, dynamic> bodyParams,
      void Function(int)? checkResponse}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ApiKeyConstants.token);
    Map<String, String> authorization = {};
    authorization = {
      "Authorization": "Bearer ${token ?? ''}",
      'Accept': 'application/json'
    };
    if (kDebugMode) print("URL:: $url");
    if (kDebugMode) print("TOKEN:: $authorization");
    if (kDebugMode) print("bodyParams:: $bodyParams}");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.delete(Uri.parse(url),
            body: bodyParams, headers: authorization);
        if (kDebugMode) print("CALLING:: ${response.body}");
        if (await CommonWidgets.responseCheckForPostMethod(
            response: response)) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            print(
                "ERROR::statusCode=${response.statusCode}: :response=${response.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) print("EXCEPTION:: Server Down");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> multipart({
    String multipartRequestType = 'POST', // POST or GET
    required String url,
    // Single Image Upload
    File? image,
    String? imageKey,
    Map<String, dynamic>? bodyParams,
    // Upload with Multiple keys
    Map<String, File?>? imageMap,
    // Upload with Single key (list of images)
    List<File>? images,
    void Function(int)? checkResponse,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ApiKeyConstants.token);

    if (kDebugMode) print("bodyParams:: ${bodyParams ?? {}}");
    if (kDebugMode) print("URL:: $url");
    if (kDebugMode) print("TOKEN:: $token");

    if (!await CommonWidgets.internetConnectionCheckerMethod()) return null;

    try {
      var request = http.MultipartRequest(multipartRequestType, Uri.parse(url));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': "Bearer ${token ?? ''}",
      });

      if (kDebugMode) print("CALLING:: $url");

      // Upload single image
      if (image != null && imageKey != null) {
        if (kDebugMode)
          print("Uploading single image: $imageKey -> ${image.path}");
        request.files.add(getUserProfileImageFile(
            image: image, userProfileImageKey: imageKey));
      }

      // Upload multiple images with keys
      if (imageMap != null) {
        print('Uploading map images...');
        imageMap.forEach((key, value) {
          if (value != null) {
            if (kDebugMode) print("Uploading file: $key -> ${value.path}");
            request.files.add(getUserProfileImageFile(
                image: value, userProfileImageKey: key));
          }
        });
      }

      // Upload list of images with single key (e.g., gallery)
      if (images != null && imageKey != null) {
        print('Uploading list<File> images...');
        for (int i = 0; i < images.length; i++) {
          request.files.add(getUserProfileImageFile(
              image: images[i], userProfileImageKey: imageKey));
          if (kDebugMode) print("Gallery Image: ${images[i].path}");
        }
      }

      // Add body parameters
      if (bodyParams != null) {
        if (kDebugMode) print("Adding bodyParams:: $bodyParams");
        bodyParams.forEach((key, value) {
          request.fields[key] = value.toString();
        });
      }

      // Send request
      var response = await request.send();
      var res = await http.Response.fromStream(response);

      if (kDebugMode) print("Server Response: ${res.body}");

      // Check response
      if (await CommonWidgets.responseCheckForPostMethod(
          response: res, wantSnackBar: false)) {
        checkResponse?.call(response.statusCode);
        return res;
      } else {
        checkResponse?.call(response.statusCode);
        if (kDebugMode)
          print("ERROR::statusCode=${res.statusCode}:response=${res.body}");
        return null;
      }
    } catch (e) {
      if (kDebugMode) print("EXCEPTION:: Server Down $e");
      return null;
    }
  }

  static Future<http.Response?> myMultipart(
      {String multipartRequestType = 'POST', // POST or GET
      required String url,
      File? image,
      String? imageKey,
      Map<String, dynamic>? bodyParams,
      List<File>? images,
      void Function(int)? checkResponse}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ApiKeyConstants.token);
    if (kDebugMode) print("bodyParams:: ${bodyParams ?? {}}");
    if (kDebugMode) print("URL:: $url");
    //if (kDebugMode) print("TOKEN:: $token");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response res;
        var request =
            http.MultipartRequest(multipartRequestType, Uri.parse(url));
        request.headers.addAll({'Content-Type': 'multipart/form-data'});
        request.headers.addAll({'Accept': 'application/json'});
        // request.headers['Authorization'] = "Bearer ${token ?? ''}";
        if (kDebugMode) print("CALLING:: $url");
        //Single Image Upload
        if (image != null && imageKey != null) {
          if (kDebugMode) print("imageKey:: $imageKey   image::$image");
          request.files.add(getUserProfileImageFile(
              image: image, userProfileImageKey: imageKey));
        }
        //Upload with Single key
        if (images != null && imageKey != null) {
          for (int i = 0; i < images.length; i++) {
            request.files.add(getUserProfileImageFile(
                image: images[i], userProfileImageKey: imageKey));
          }
        }

        if (bodyParams != null) {
          if (kDebugMode) print("bodyParams:: $bodyParams");
          bodyParams.forEach((key, value) {
            request.fields[key] = value;
          });
        }
        var response = await request.send();
        res = await http.Response.fromStream(response);
        if (kDebugMode) print("CALLING:: ${res.body}");
        if (await CommonWidgets.responseCheckForPostMethod(response: res)) {
          checkResponse?.call(response.statusCode);
          return res;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            print("ERROR::statusCode=${res.statusCode}: :response=${res.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) print("EXCEPTION:: Server Down");
        return null;
      }
    } else {
      return null;
    }
  }

  static http.MultipartFile getUserProfileImageFile(
      {File? image, required String userProfileImageKey}) {
    return http.MultipartFile.fromBytes(
      userProfileImageKey, image!.readAsBytesSync(),
      filename: image.uri.pathSegments.last,
      //  contentType: MediaType('image', 'jpg')
    );
  }
}
