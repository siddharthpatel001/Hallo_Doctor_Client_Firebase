import 'package:get/get.dart';

import 'package:hallo_doctor_client/app/modules/appointment/bindings/appointment_binding.dart';
import 'package:hallo_doctor_client/app/modules/appointment/views/appointment_view.dart';
import 'package:hallo_doctor_client/app/modules/appointment_detail/bindings/appointment_detail_binding.dart';
import 'package:hallo_doctor_client/app/modules/appointment_detail/views/appointment_detail_view.dart';
import 'package:hallo_doctor_client/app/modules/chat/bindings/chat_binding.dart';
import 'package:hallo_doctor_client/app/modules/chat/views/chat_view.dart';
import 'package:hallo_doctor_client/app/modules/consultation_confirm/bindings/consultation_confirm_binding.dart';
import 'package:hallo_doctor_client/app/modules/consultation_confirm/views/consultation_confirm_view.dart';
import 'package:hallo_doctor_client/app/modules/consultation_date_picker/bindings/consultation_date_picker_binding.dart';
import 'package:hallo_doctor_client/app/modules/consultation_date_picker/views/consultation_date_picker_view.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/views/dashboard_view.dart';
import 'package:hallo_doctor_client/app/modules/detail_doctor/bindings/detail_doctor_binding.dart';
import 'package:hallo_doctor_client/app/modules/detail_doctor/views/detail_doctor_view.dart';
import 'package:hallo_doctor_client/app/modules/detail_order/bindings/detail_order_binding.dart';
import 'package:hallo_doctor_client/app/modules/detail_order/views/detail_order_view.dart';
import 'package:hallo_doctor_client/app/modules/doctor_category/bindings/doctor_category_binding.dart';
import 'package:hallo_doctor_client/app/modules/doctor_category/views/doctor_category_view.dart';
import 'package:hallo_doctor_client/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:hallo_doctor_client/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:hallo_doctor_client/app/modules/home/bindings/home_binding.dart';
import 'package:hallo_doctor_client/app/modules/home/views/home_view.dart';
import 'package:hallo_doctor_client/app/modules/list_chat/bindings/list_chat_binding.dart';
import 'package:hallo_doctor_client/app/modules/list_chat/views/list_chat_view.dart';
import 'package:hallo_doctor_client/app/modules/list_doctor/bindings/list_doctor_binding.dart';
import 'package:hallo_doctor_client/app/modules/list_doctor/views/list_doctor_view.dart';
import 'package:hallo_doctor_client/app/modules/login/bindings/login_binding.dart';
import 'package:hallo_doctor_client/app/modules/login/views/login_view.dart';
import 'package:hallo_doctor_client/app/modules/payment_success/bindings/payment_success_binding.dart';
import 'package:hallo_doctor_client/app/modules/payment_success/views/payment_success_view.dart';
import 'package:hallo_doctor_client/app/modules/profile/bindings/profile_binding.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/profile_view.dart';
import 'package:hallo_doctor_client/app/modules/register/bindings/register_binding.dart';
import 'package:hallo_doctor_client/app/modules/register/views/register_view.dart';
import 'package:hallo_doctor_client/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:hallo_doctor_client/app/modules/reset_password/views/reset_password_view.dart';
import 'package:hallo_doctor_client/app/modules/review/bindings/review_binding.dart';
import 'package:hallo_doctor_client/app/modules/review/views/review_view.dart';
import 'package:hallo_doctor_client/app/modules/search_doctor/bindings/search_doctor_binding.dart';
import 'package:hallo_doctor_client/app/modules/search_doctor/views/search_doctor_view.dart';
import 'package:hallo_doctor_client/app/modules/top_rated_doctor/bindings/top_rated_doctor_binding.dart';
import 'package:hallo_doctor_client/app/modules/top_rated_doctor/views/top_rated_doctor_view.dart';
import 'package:hallo_doctor_client/app/modules/video_call/bindings/video_call_binding.dart';
import 'package:hallo_doctor_client/app/modules/video_call/views/video_call_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const DASHBOARD = Routes.DASHBOARD;
  static const LOGIN = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_CATEGORY,
      page: () => DoctorCategoryView(),
      binding: DoctorCategoryBinding(),
    ),
    GetPage(
      name: _Paths.LIST_DOCTOR,
      page: () => ListDoctorView(),
      binding: ListDoctorBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_DOCTOR,
      page: () => DetailDoctorView(),
      binding: DetailDoctorBinding(),
    ),
    GetPage(
      name: _Paths.CONSULTATION_DATE_PICKER,
      page: () => ConsultationDatePickerView(),
      binding: ConsultationDatePickerBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ORDER,
      page: () => DetailOrderView(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_SUCCESS,
      page: () => PaymentSuccessView(),
      binding: PaymentSuccessBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CALL,
      page: () => VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT,
      page: () => AppointmentView(),
      binding: AppointmentBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_DETAIL,
      page: () => AppointmentDetailView(),
      binding: AppointmentDetailBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW,
      page: () => ReviewView(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.TOP_RATED_DOCTOR,
      page: () => TopRatedDoctorView(),
      binding: TopRatedDoctorBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_DOCTOR,
      page: () => SearchDoctorView(),
      binding: SearchDoctorBinding(),
    ),
    GetPage(
      name: _Paths.CONSULTATION_CONFIRM,
      page: () => ConsultationConfirmView(),
      binding: ConsultationConfirmBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.LIST_CHAT,
      page: () => ListChatView(),
      binding: ListChatBinding(),
    ),
  ];
}
