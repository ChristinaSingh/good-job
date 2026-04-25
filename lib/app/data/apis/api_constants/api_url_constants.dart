class ApiUrlConstants {
  static const String baseUrl =
      // 'https://server-php-8-2.technorizen.com/good_job/api/';
      'https://s82.technorizen.com/good_job/api/';
  static const String baseUrlForGetMethodParams = 's82.technorizen.com';
  static const String endPointOfUserSignup = '${baseUrl}Register';
  static const String endPointOfSendUserOtp = '${baseUrl}sendUserOtp';
  static const String endPointOfCheckOtp = '${baseUrl}check-otp';
  static const String endPointOfGetProfile = '${baseUrl}get-profile';
  static const String endPointOfRegisterProfessionalProfile =
      '${baseUrl}register_professional_provider';
  static const String endPointOfUpdateProviderDocument =
      '${baseUrl}Update-Provider-Document';
  static const String endPointOfUpdateProfile = '${baseUrl}update-profile';
  static const String endPointOfChatHistory = '${baseUrl}getChatHistory';
  static const String endPointOfSendMessage = '${baseUrl}sendMessage';
  static const String endPointOfGetChatList = '${baseUrl}getChatList';
  static const String endPointOfGetServiceProviderList =
      '${baseUrl}get-service-provider-list';
  static const String endPointOfAddBooking = '${baseUrl}add-Booking';
  static const String endPointOfGetServiceProviderDetails =
      '${baseUrl}get-service-provider-detail';
  static const String endPointOfPendingBooking =
      '${baseUrl}get-Pending-Booking';
  static const String endPointOfGetUserBookingList =
      '${baseUrl}get-user-booking-list';
  static const String endPointOfGetProviderBookingList =
      '${baseUrl}get-provider-booking-list';
  static const String endPointOfBookingAcceptReject =
      '${baseUrl}booking-accept-reject';
  static const String endPointOfGetPrivacyPolicy =
      '${baseUrl}get_privacy_policy';
  static const String endPointOfGetAboutUs = '${baseUrl}get_about_us';
  static const String endPointOfContactInfo = '${baseUrl}contact_info ';
  static const String endPointOfSupportInquiries =
      '${baseUrl}support_inquiries';
  static const String endPointOfContactUsSubmission =
      '${baseUrl}contact_us_submissions';
  static const String endPointOfGetServiceProviderNearBy =
      '${baseUrl}get-service-provider-near-by';
  static const String endPointOfAddReview = '${baseUrl}add_review';
  static const String endPointOfGetNotification = '${baseUrl}getNotifications';
  static const String endPointOfCollectBookingAmount =
      '${baseUrl}collect-booking-amount';
  static const String endPointOfMyPayments = '${baseUrl}my-payments';
  static const String endPointOfCheckOutSession =
      '${baseUrl}create-checkout-session';

  static const String endPointOfProcessPayment =
      '${baseUrl}payment_status_complete';
}
