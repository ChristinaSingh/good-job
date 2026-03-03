import 'dart:convert';
import 'dart:io';

import 'package:good_job/app/data/apis/api_models/add_booking_model.dart';
import 'package:good_job/app/data/apis/api_models/get_all_provider_model.dart';
import 'package:good_job/app/data/apis/api_models/get_booking_request_model.dart';
import 'package:good_job/app/data/apis/api_models/get_chats_model.dart';
import 'package:good_job/app/data/apis/api_models/get_contact_info_model.dart';
import 'package:good_job/app/data/apis/api_models/get_conversation_model.dart';
import 'package:good_job/app/data/apis/api_models/get_notification.dart';
import 'package:good_job/app/data/apis/api_models/get_payment_history_model.dart';
import 'package:good_job/app/data/apis/api_models/get_service_provider_model.dart';
import 'package:good_job/app/data/apis/api_models/get_simple_model.dart';
import 'package:good_job/app/data/apis/api_models/payment_model.dart';
import 'package:http/http.dart' as http;

import '../../../../common/http_methods.dart';
import '../api_constants/api_url_constants.dart';
import '../api_models/get_checkout_session_model.dart';
import '../api_models/get_privacy_policy.dart';
import '../api_models/get_service_provider_detail_model.dart';
import '../api_models/get_user_model.dart';
import '../api_models/set_otp_model.dart';
import '../api_models/update_profile_model.dart';

class ApiMethods {
  /// Send Otp For Login...
  static Future<SendOtpModel?> sendOtpForLogin({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    SendOtpModel? sendOtpModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfSendUserOtp,
      checkResponse: checkResponse,
    );
    if (response != null) {
      sendOtpModel = SendOtpModel.fromJson(jsonDecode(response.body));
      return sendOtpModel;
    }
    return null;
  }

  ///  Otp verification ...
  static Future<UserModel?> otpVerificationApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    UserModel? userModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfCheckOtp,
      checkResponse: checkResponse,
    );
    if (response != null) {
      print("Response:-${response.body}");
      userModel = UserModel.fromJson(jsonDecode(response.body));
      return userModel;
    }
    return null;
  }

  ///  Otp verification ...
  static Future<UserModel?> getProfileApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    UserModel? userModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      wantSnackBar: false,
      url: ApiUrlConstants.endPointOfGetProfile,
      checkResponse: checkResponse,
    );
    if (response != null) {
      userModel = UserModel.fromJson(jsonDecode(response.body));
      return userModel;
    }
    return null;
  }

  ///provider create profile Api ....
  static Future<SimpleModel?> providerCreateProfileApi(
      {void Function(int)? checkResponse,
      Map<String, dynamic>? bodyParams,
      List<File>? imageList}) async {
    SimpleModel simpleModel;
    http.Response? response = await MyHttp.multipart(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfRegisterProfessionalProfile,
      images: imageList,
      imageKey: 'gallery_images[]',
      checkResponse: checkResponse,
    );
    if (response != null) {
      simpleModel = SimpleModel.fromJson(jsonDecode(response.body));
      return simpleModel;
    }
    return null;
  }

  ///update provider document Api ....
  static Future<UserModel?> updateProviderDocumentApi(
      {void Function(int)? checkResponse,
      Map<String, dynamic>? bodyParams,
      List<File>? imageList}) async {
    UserModel userModel;
    http.Response? response = await MyHttp.multipart(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfUpdateProviderDocument,
      images: imageList,
      imageKey: 'document_images[]',
      checkResponse: checkResponse,
    );
    if (response != null) {
      userModel = UserModel.fromJson(jsonDecode(response.body));
      return userModel;
    }
    return null;
  }

  ///Update Profile Api Calling.....
  static Future<UpdateProfileModel?> updateProfileApi(
      {void Function(int)? checkResponse,
      Map<String, dynamic>? bodyParams,
      Map<String, File?>? imageMap,
      List<File>? serviceImages}) async {
    UpdateProfileModel? logInModel;

    http.Response? response = await MyHttp.multipart(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfUpdateProfile,
      imageMap: imageMap,
      images: serviceImages,
      imageKey: 'gallery_images[]',
      checkResponse: checkResponse,
    );

    if (response != null) {
      print("Response:------${response.body}");
      logInModel = UpdateProfileModel.fromJson(jsonDecode(response.body));
      return logInModel;
    }
    return null;
  }

  /// Get Service Provider Model...
  static Future<ServiceProviderModel?> getServiceProviderList({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    ServiceProviderModel? serviceProviderModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      wantSnackBar: false,
      url: ApiUrlConstants.endPointOfGetServiceProviderList,
      checkResponse: checkResponse,
    );
    if (response != null) {
      serviceProviderModel =
          ServiceProviderModel.fromJson(jsonDecode(response.body));
      return serviceProviderModel;
    }
    return null;
  }

  /// Get Service Provider Details Model...
  static Future<ServiceProviderDetailModel?> getServiceProviderDetails({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    ServiceProviderDetailModel? serviceProviderDetailModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      wantSnackBar: false,
      url: ApiUrlConstants.endPointOfGetServiceProviderDetails,
      checkResponse: checkResponse,
    );
    if (response != null) {
      serviceProviderDetailModel =
          ServiceProviderDetailModel.fromJson(jsonDecode(response.body));
      return serviceProviderDetailModel;
    }
    return null;
  }

  ///Add booking Api ....
  static Future<AddBookingModel?> addBookingApi(
      {void Function(int)? checkResponse,
      Map<String, dynamic>? bodyParams,
      List<File>? imageList}) async {
    AddBookingModel simpleModel;
    http.Response? response = await MyHttp.multipart(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfAddBooking,
      images: imageList,
      imageKey: 'booking_images[]',
      checkResponse: checkResponse,
    );
    if (response != null) {
      simpleModel = AddBookingModel.fromJson(jsonDecode(response.body));
      return simpleModel;
    }
    return null;
  }

  /// Get Provider booking request...
  static Future<BookingRequestModel?> getProviderBookingRequest({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    BookingRequestModel? serviceProviderModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      wantSnackBar: false,
      url: ApiUrlConstants.endPointOfPendingBooking,
      checkResponse: checkResponse,
    );
    if (response != null) {
      serviceProviderModel =
          BookingRequestModel.fromJson(jsonDecode(response.body));
      return serviceProviderModel;
    }
    return null;
  }

  /// Get User booking request...
  static Future<BookingRequestModel?> getUserBookingRequestApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    BookingRequestModel? serviceProviderModel;
    http.Response? response = await MyHttp.postMethod(
        bodyParams: bodyParams,
        url: ApiUrlConstants.endPointOfGetUserBookingList,
        checkResponse: checkResponse,
        wantSnackBar: false);
    if (response != null) {
      serviceProviderModel =
          BookingRequestModel.fromJson(jsonDecode(response.body));
      return serviceProviderModel;
    }
    return null;
  }

  /// Accept_Reject booking request...
  static Future<SimpleModel?> acceptRejectBookingRequestApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    SimpleModel? simpleModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfBookingAcceptReject, //
      checkResponse: checkResponse,
    );
    if (response != null) {
      simpleModel = SimpleModel.fromJson(jsonDecode(response.body));
      return simpleModel;
    }
    return null;
  }

  /// Get Provider booking request...
  static Future<BookingRequestModel?> getProviderBookingRequestApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    BookingRequestModel? serviceProviderModel;
    http.Response? response = await MyHttp.postMethod(
        bodyParams: bodyParams,
        url: ApiUrlConstants.endPointOfGetProviderBookingList,
        checkResponse: checkResponse,
        wantSnackBar: false);
    if (response != null) {
      serviceProviderModel =
          BookingRequestModel.fromJson(jsonDecode(response.body));
      return serviceProviderModel;
    }
    return null;
  }

  /// collect booking amount request...
  static Future<SimpleModel?> collectBookingAmountApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    SimpleModel? simpleModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      wantSnackBar: false,
      url: ApiUrlConstants.endPointOfCollectBookingAmount, //
      checkResponse: checkResponse,
    );
    if (response != null) {
      simpleModel = SimpleModel.fromJson(jsonDecode(response.body));
      return simpleModel;
    }
    return null;
  }

  /// get wallet history api...
  static Future<PaymentHistoryModel?> getWalletHistoryApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    PaymentHistoryModel? paymentHistoryModel;
    http.Response? response = await MyHttp.postMethod(
        bodyParams: bodyParams,
        url: ApiUrlConstants.endPointOfMyPayments, //
        checkResponse: checkResponse,
        wantSnackBar: false);
    if (response != null) {
      paymentHistoryModel =
          PaymentHistoryModel.fromJson(jsonDecode(response.body));
      return paymentHistoryModel;
    }
    return null;
  }

  /// privacy Policy api.......
  static Future<PrivacyPolicyModel?> privacyPolicyApi(
      {void Function(int)? checkResponse}) async {
    PrivacyPolicyModel privacyPolicyModel;
    http.Response? response = await MyHttp.getMethod(
        url: ApiUrlConstants.endPointOfGetPrivacyPolicy,
        checkResponse: checkResponse);
    if (response != null) {
      privacyPolicyModel =
          PrivacyPolicyModel.fromJson(jsonDecode(response.body));
      return privacyPolicyModel;
    }
    return null;
  }

  /// About Us api.......
  static Future<PrivacyPolicyModel?> aboutUsApi(
      {void Function(int)? checkResponse}) async {
    PrivacyPolicyModel privacyPolicyModel;
    http.Response? response = await MyHttp.getMethod(
        url: ApiUrlConstants.endPointOfGetAboutUs,
        checkResponse: checkResponse);
    if (response != null) {
      privacyPolicyModel =
          PrivacyPolicyModel.fromJson(jsonDecode(response.body));
      return privacyPolicyModel;
    }
    return null;
  }

  /// About Us api.......
  static Future<ContactInfoModel?> getContactInfoApi(
      {void Function(int)? checkResponse}) async {
    ContactInfoModel contactInfoModel;
    http.Response? response = await MyHttp.getMethod(
        url: ApiUrlConstants.endPointOfContactInfo,
        checkResponse: checkResponse);
    if (response != null) {
      contactInfoModel = ContactInfoModel.fromJson(jsonDecode(response.body));
      return contactInfoModel;
    }
    return null;
  }

  /// Support Inquiries  api...
  static Future<SimpleModel?> supportInquiriesApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    SimpleModel? simpleModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfSupportInquiries,
      checkResponse: checkResponse,
    );
    if (response != null) {
      simpleModel = SimpleModel.fromJson(jsonDecode(response.body));
      return simpleModel;
    }
    return null;
  }

  /// Contact Us submission   api...
  static Future<SimpleModel?> contactUsSubmissionApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    SimpleModel? simpleModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfContactUsSubmission,
      checkResponse: checkResponse,
    );
    if (response != null) {
      simpleModel = SimpleModel.fromJson(jsonDecode(response.body));
      return simpleModel;
    }
    return null;
  }

  /// Get all provider   api...
  static Future<AllProviderModel?> getAllProviderApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    AllProviderModel? allProviderModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfGetServiceProviderNearBy,
      checkResponse: checkResponse,
    );
    if (response != null) {
      allProviderModel = AllProviderModel.fromJson(jsonDecode(response.body));
      return allProviderModel;
    }
    return null;
  }

  /// Add review   api...
  static Future<SimpleModel?> addReviewApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    SimpleModel? simpleModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfAddReview,
      checkResponse: checkResponse,
    );
    if (response != null) {
      simpleModel = SimpleModel.fromJson(jsonDecode(response.body));
      return simpleModel;
    }
    return null;
  }

  ///Get Notification api
  static Future<NotificationModel?> getNotificationApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    NotificationModel? notificationModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfGetNotification,
      checkResponse: checkResponse,
    );
    if (response != null) {
      notificationModel = NotificationModel.fromJson(jsonDecode(response.body));
      return notificationModel;
    }
    return null;
  }

  ///Set Notification ON OFF api
  static Future<SimpleModel?> setNotificationApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    SimpleModel? simpleModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfUpdateProfile,
      checkResponse: checkResponse,
    );
    if (response != null) {
      simpleModel = SimpleModel.fromJson(jsonDecode(response.body));
      return simpleModel;
    }
    return null;
  }

  ///Set Chats Api api
  static Future<ChatsModel?> getChatsApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    ChatsModel? chatsModel;
    http.Response? response = await MyHttp.postMethod(
        bodyParams: bodyParams,
        url: ApiUrlConstants.endPointOfChatHistory,
        checkResponse: checkResponse,
        wantSnackBar: false);
    if (response != null) {
      chatsModel = ChatsModel.fromJson(jsonDecode(response.body));
      return chatsModel;
    }
    return null;
  }

  ///Add Chats Api api
  static Future<SimpleModel?> addChatsApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    SimpleModel? simpleModel;
    http.Response? response = await MyHttp.postMethod(
        bodyParams: bodyParams,
        url: ApiUrlConstants.endPointOfSendMessage,
        checkResponse: checkResponse,
        wantSnackBar: false);
    if (response != null) {
      simpleModel = SimpleModel.fromJson(jsonDecode(response.body));
      return simpleModel;
    }
    return null;
  }

  ///Get Conversation Api api
  static Future<ConversationModel?> getConversationApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    ConversationModel? conversationModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      wantSnackBar: false,
      url: ApiUrlConstants.endPointOfGetChatList,
      checkResponse: checkResponse,
    );
    if (response != null) {
      conversationModel = ConversationModel.fromJson(jsonDecode(response.body));
      return conversationModel;
    }
    return null;
  }

  /// Create CheckOut Session api
  static Future<CheckOutSessionModel?> createCheckOutSession(
      {void Function(int)? checkResponse,
      Map<String, dynamic>? bodyParams,
      bool wantSnackBar = false}) async {
    CheckOutSessionModel checkOutSessionModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfCheckOutSession,
      checkResponse: checkResponse,
      wantSnackBar: false,
    );
    if (response != null) {
      checkOutSessionModel =
          CheckOutSessionModel.fromJson(jsonDecode(response.body));
      return checkOutSessionModel;
    }
    return null;
  }

  /// new payment method
  static Future<PaymentModel?> processPayment({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    PaymentModel? paymentModel;
    http.Response? response = await MyHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfProcessPayment,
      checkResponse: checkResponse,
    );
    if (response != null) {
      paymentModel = PaymentModel.fromJson(jsonDecode(response.body));
      return paymentModel;
    }
    return null;
  }
}
