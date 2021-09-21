import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class FavoriteController extends GetxController with SingleGetTickerProviderMixin {

  // For Current User
  UserModel currentUser = Get.find<HomeController>().currentUser;

  // For Favorites Users
  List<UserModel> _favUsers = [];
  List<UserModel> get favUsers => _favUsers;

  // For Favorites Products
  List<ProductModel> _favProducts = [];
  List<ProductModel> get favProducts => _favProducts;

  // For Loading
  bool isLoading = false;

  // For TabBar
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getUsers();
    getProducts();
  }

  ///to get favorites users
  void getUsers() {
    isLoading = true;
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(
          Constants.FAVORITE_USERS_URL,
          headers: {
            Constants.API_AUTHORIZATION: currentUser.token
          }
        );
      },
      onSuccess: (response)
      {
        response['favouriteUsers'].forEach((user) {
          _favUsers.add(UserModel.fromJson(user));
        });
        isLoading = false;
        update();
      },
      onError: (error) {
        isLoading = false;
        ErrorHandler.handleError(error);
      },
      onLoading: () {}
    );
  }

  ///to get favorites products
  void getProducts() {
    isLoading = true;
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(
          Constants.FAVORITE_PRODUCTS_URL,
          headers: {
            Constants.API_AUTHORIZATION: currentUser.token
          }
        );
      },
      onSuccess: (response)
      {
        response['products'].forEach((product) {
          _favProducts.add(ProductModel.fromJson(product));
        });
        isLoading = false;
        update();
      },
      onError: (error) {
        isLoading = false;
        ErrorHandler.handleError(error);
      },
      onLoading: () {}
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

}