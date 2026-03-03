import 'package:get/get.dart';

import '../modules/BookingSucessPopUp/bindings/booking_sucess_pop_up_binding.dart';
import '../modules/BookingSucessPopUp/views/booking_sucess_pop_up_view.dart';
import '../modules/Booking_details_user/bindings/booking_details_user_binding.dart';
import '../modules/Booking_details_user/views/booking_details_user_view.dart';
import '../modules/about_us/bindings/about_us_binding.dart';
import '../modules/about_us/views/about_us_view.dart';
import '../modules/add_review/bindings/add_review_binding.dart';
import '../modules/add_review/views/add_review_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/booking_tacking/bindings/booking_tacking_binding.dart';
import '../modules/booking_tacking/views/booking_tacking_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/create_your_profile/bindings/create_your_profile_binding.dart';
import '../modules/create_your_profile/views/create_your_profile_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/mobile_transfer/bindings/mobile_transfer_binding.dart';
import '../modules/mobile_transfer/views/mobile_transfer_view.dart';
import '../modules/nav_bar/bindings/nav_bar_binding.dart';
import '../modules/nav_bar/views/nav_bar_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/notification_setting/bindings/notification_setting_binding.dart';
import '../modules/notification_setting/views/notification_setting_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/provider_booking/bindings/provider_booking_binding.dart';
import '../modules/provider_booking/views/provider_booking_view.dart';
import '../modules/provider_documernt/bindings/provider_documernt_binding.dart';
import '../modules/provider_documernt/views/provider_documernt_view.dart';
import '../modules/provider_edit_profile/bindings/provider_edit_profile_binding.dart';
import '../modules/provider_edit_profile/views/provider_edit_profile_view.dart';
import '../modules/provider_home/bindings/provider_home_binding.dart';
import '../modules/provider_home/views/provider_home_view.dart';
import '../modules/provider_map/bindings/provider_map_binding.dart';
import '../modules/provider_map/views/provider_map_view.dart';
import '../modules/provider_nav_bar/bindings/provider_nav_bar_binding.dart';
import '../modules/provider_nav_bar/views/provider_nav_bar_view.dart';
import '../modules/provider_profile/bindings/provider_profile_binding.dart';
import '../modules/provider_profile/views/provider_profile_view.dart';
import '../modules/provider_project_detail/bindings/provider_project_detail_binding.dart';
import '../modules/provider_project_detail/views/provider_project_detail_view.dart';
import '../modules/provider_wallet/bindings/provider_wallet_binding.dart';
import '../modules/provider_wallet/views/provider_wallet_view.dart';
import '../modules/provider_working_process/bindings/provider_working_process_binding.dart';
import '../modules/provider_working_process/views/provider_working_process_view.dart';
import '../modules/searvice_form/bindings/searvice_form_binding.dart';
import '../modules/searvice_form/views/searvice_form_view.dart';
import '../modules/service_providers/bindings/service_providers_binding.dart';
import '../modules/service_providers/views/service_providers_view.dart';
import '../modules/service_providers_details/bindings/service_providers_details_binding.dart';
import '../modules/service_providers_details/views/service_providers_details_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/views/support_view.dart';
import '../modules/typing/bindings/typing_binding.dart';
import '../modules/typing/views/typing_view.dart';
import '../modules/user_type/bindings/user_type_binding.dart';
import '../modules/user_type/views/user_type_view.dart';
import '../modules/waiting_request/bindings/waiting_request_binding.dart';
import '../modules/waiting_request/views/waiting_request_view.dart';
import '../modules/webView_payment/bindings/web_view_payment_binding.dart';
import '../modules/webView_payment/views/web_view_payment_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.USER_TYPE,
      page: () => const UserTypeView(),
      binding: UserTypeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.NAV_BAR,
      page: () => const NavBarView(),
      binding: NavBarBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.SEARVICE_FORM,
      page: () => const SearviceFormView(),
      binding: SearviceFormBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_PROVIDERS,
      page: () => const ServiceProvidersView(),
      binding: ServiceProvidersBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_PROVIDERS_DETAILS,
      page: () => const ServiceProvidersDetailsView(),
      binding: ServiceProvidersDetailsBinding(),
    ),
    GetPage(
      name: _Paths.WAITING_REQUEST,
      page: () => const WaitingRequestView(),
      binding: WaitingRequestBinding(),
    ),
    GetPage(
      name: _Paths.TYPING,
      page: () => const TypingView(),
      binding: TypingBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SETTING,
      page: () => const NotificationSettingView(),
      binding: NotificationSettingBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_YOUR_PROFILE,
      page: () => const CreateYourProfileView(),
      binding: CreateYourProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_NAV_BAR,
      page: () => const ProviderNavBarView(),
      binding: ProviderNavBarBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_HOME,
      page: () => const ProviderHomeView(),
      binding: ProviderHomeBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_BOOKING,
      page: () => const ProviderBookingView(),
      binding: ProviderBookingBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_PROFILE,
      page: () => const ProviderProfileView(),
      binding: ProviderProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_WALLET,
      page: () => const ProviderWalletView(),
      binding: ProviderWalletBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_PROJECT_DETAIL,
      page: () => const ProviderProjectDetailView(),
      binding: ProviderProjectDetailBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_MAP,
      page: () => ProviderMapView(),
      binding: ProviderMapBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_WORKING_PROCESS,
      page: () => const ProviderWorkingProcessView(),
      binding: ProviderWorkingProcessBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE_TRANSFER,
      page: () => const MobileTransferView(),
      binding: MobileTransferBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_DOCUMERNT,
      page: () => const ProviderDocumerntView(),
      binding: ProviderDocumerntBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_TACKING,
      page: () => const BookingTackingView(),
      binding: BookingTackingBinding(),
    ),
    GetPage(
      name: _Paths.ADD_REVIEW,
      page: () => const AddReviewView(),
      binding: AddReviewBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_EDIT_PROFILE,
      page: () => const ProviderEditProfileView(),
      binding: ProviderEditProfileBinding(),
    ),
    GetPage(
      name: _Paths.WEB_VIEW_PAYMENT,
      page: () => const WebViewPaymentView(),
      binding: WebViewPaymentBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_SUCESS_POP_UP,
      page: () => const BookingSucessPopUpView(),
      binding: BookingSucessPopUpBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_DETAILS_USER,
      page: () => const BookingDetailsUserView(),
      binding: BookingDetailsUserBinding(),
    ),
  ];
}
