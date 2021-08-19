import 'package:get/get.dart';

import 'package:shop_fever/app/modules/auth/bindings/auth_binding.dart';
import 'package:shop_fever/app/modules/auth/views/login_view.dart';
import 'package:shop_fever/app/modules/auth/views/register_view.dart';
import 'package:shop_fever/app/modules/home/bindings/home_binding.dart';
import 'package:shop_fever/app/modules/home/views/home_view.dart';
import 'package:shop_fever/app/modules/profile/bindings/profile_binding.dart';
import 'package:shop_fever/app/modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  //static const AUTH = Routes.AUTH;
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const PROFILE = Routes.PROFILE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.AUTH,
    //   page: () => LoginView(),
    //   binding: AuthBinding(),
    // ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      //binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
