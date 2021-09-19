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

class ProfileController extends GetxController with SingleGetTickerProviderMixin {

  // For Home Controller
  final _homeController = Get.find<HomeController>();

  // For Users
  UserModel currentUser = Get.find<HomeController>().currentClickedUser;

  // For Current User Products
  List<ProductModel> _userProducts = [];
  List<ProductModel> get userProducts => _userProducts;

  //List<ProductModel> _otherUserProducts = [];
  //List<ProductModel> get otherUserserProducts => _otherUserProducts;

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
    getUserProducts();
    getProductsIds();
    //getUserProducts();
  }

  bool isTheCurrent()
    => _homeController.currentUser.id== currentUser.id;


  ///to get the user products
  void getUserProducts() {
    HelperFunctions.safeApiCall(execute: (){
      var headers = {Constants.API_AUTHORIZATION : Get.find<HomeController>().currentUser.token};
      return BaseClient.get(Constants.USER_PRODUCTS_URL+'/${currentUser.id}',headers: headers);
    }, onSuccess: (response){
      response['products'].forEach((product) {
        //_products.value.add(ProductModel.fromJson(product));
        userProducts.add(ProductModel.fromJson(product));
      });
      Logger().e(userProducts.length);
      Logger().e(_userProducts.length);
      update(['UserProduct']);
    },onError: (error){
      Logger().e(error);
    });
  }

  // ///to get the current user products
  // void getUserProducts() {
  //   _homeController.products.forEach((product) {
  //     if (currentUser.id == product.user.id)
  //       _userProducts.add(product);
  //   });
  //   update(['UserProduct']);
  // }

  // ///to get the other user products
  // void getOtherUserProducts() {
  //   _homeController.products.forEach((product) {
  //     if (otherUser!.id == product.user.id)
  //       _otherUserProducts.add(product);
  //   });
  //   update(['UserProduct']);
  // }

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
    _homeController.products.forEach((product) {
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
