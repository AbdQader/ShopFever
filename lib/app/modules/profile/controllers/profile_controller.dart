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

  // For Favorites Users
  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  // For Favorites Products
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  var _productsIds = [];

  // For TabBar
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getProductsIds();
  }

  // to get favorites users
  void getUsers() {}

  // to get favorites products ids
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
          print('abd => ProductId: ${productId['_id']}');
          _productsIds.add(productId['_id']);
        });
        getProducts();
      },
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
  }

  // to get favorites products
  void getProducts() {
    Get.find<HomeController>().products.forEach((product) {
      _productsIds.forEach((productId) {
        if (product.id == productId)
          _products.add(product); print('abd => Product: ${product.name}');
      });
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

}
