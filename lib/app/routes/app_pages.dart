import 'package:get/get.dart';
import 'package:savepy/app/common/In_progress.dart';
import 'package:savepy/app/modules/auth/bindings/registration_binding.dart';
import 'package:savepy/app/modules/auth/views/registration_view.dart';
import 'package:savepy/app/modules/group_detail/model/group_payment_model.dart';
import 'package:savepy/app/modules/group_list/view/group_list_view.dart';
import 'package:savepy/app/modules/member_list/view/member_list_view.dart';
import 'package:savepy/app/modules/my_profile/view/myprofile_view.dart';
import 'package:savepy/app/modules/payment_history/view/payment_histroy_view.dart';
import '../../splash_screen.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MYGROUPS,
      page: () => GroupListView(),
    ),
    GetPage(
      name: _Paths.MYMEMBERS,
      page: () => MemberListView(),
    ),
    GetPage(
      name: _Paths.MYPROFILE,
      page: () => MyProfile(),
    ),
    GetPage(
      name: _Paths.PAYMENTHISTORY,
      page: () => PaymentHistoryView(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => SplashView(),
      // binding: RegistrationBinding(),
    ),

  ];
}