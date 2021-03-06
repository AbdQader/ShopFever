import 'package:get/get.dart';
import 'package:shop_fever/app/modules/add_product/bindings/add_product_binding.dart';
import 'package:shop_fever/app/modules/add_product/views/add_product_view.dart';
import 'package:shop_fever/app/modules/auth/bindings/auth_binding.dart';
import 'package:shop_fever/app/modules/auth/views/login_view.dart';
import 'package:shop_fever/app/modules/auth/views/register_view.dart';
import 'package:shop_fever/app/modules/category/bindings/category_binding.dart';
import 'package:shop_fever/app/modules/category/views/category_view.dart';
import 'package:shop_fever/app/modules/favorite/bindings/favorite_binding.dart';
import 'package:shop_fever/app/modules/favorite/views/favorite_view.dart';
import 'package:shop_fever/app/modules/home/bindings/home_binding.dart';
import 'package:shop_fever/app/modules/home/views/home_view.dart';
import 'package:shop_fever/app/modules/product_details/bindings/product_details_binding.dart';
import 'package:shop_fever/app/modules/product_details/views/product_details_view.dart';
import 'package:shop_fever/app/modules/profile/bindings/profile_binding.dart';
import 'package:shop_fever/app/modules/profile/views/edit_profile_view.dart';
import 'package:shop_fever/app/modules/profile/views/profile_view.dart';
import 'package:shop_fever/app/modules/search/bindings/search_binding.dart';
import 'package:shop_fever/app/modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const PROFILE = Routes.PROFILE;
  static const EDIT_PROFILE = Routes.EDIT_PROFILE;
  static const FAVORITES = Routes.FAVORITES;
  static const PRODUCT_DETAILS = Routes.PRODUCT_DETAILS;
  static const ADD_PRODUCT = Routes.ADD_PRODUCT;
  static const CATEGORY = Routes.CATEGORY;
  static const SEARCH = Routes.SEARCH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
  ];
}
