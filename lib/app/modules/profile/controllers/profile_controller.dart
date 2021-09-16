import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class ProfileController extends GetxController with SingleGetTickerProviderMixin {

  // For Current User
  UserModel currentUser = Get.find<HomeController>().currentUser;

  // For Current User Products
  List<ProductModel> _userProducts = [];
  List<ProductModel> get userProducts => _userProducts;

  // For Favorites Users
  List<UserModel> _favUsers = [];
  List<UserModel> get favUsers => _favUsers;

  // For Favorites Products
  List<ProductModel> _favProducts = [];
  List<ProductModel> get favProducts => _favProducts;
  
  // For Favorites Products Ids
  List<String> _productsIds = [];

  // For TabBar
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getProductsIds();
    getUserProducts();
  }

  ///to get the current user products
  void getUserProducts() {
    Get.find<HomeController>().products.forEach((product) {
      if (currentUser.id == product.id)
        _userProducts.add(product);
    });
  }

  ///to get favorites users
  void getUsers() {}

  ///to get favorites products ids
  void getProductsIds() {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(
          Constants.FAVORITE_PRODUCTS_URL,
          headers: {
            Constants.API_AUTHORIZATION: currentUser.token
          });
      },
      onSuccess: (response)
      {
        response['products'].forEach((productId) {
          _productsIds.add(productId['_id']);
        });
        getProducts();
      },
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
  }

  ///to get favorites products
  void getProducts() {
    Get.find<HomeController>().products.forEach((product) {
      _productsIds.forEach((productId) {
        if (product.id == productId)
          _favProducts.add(product);
      });
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

}
