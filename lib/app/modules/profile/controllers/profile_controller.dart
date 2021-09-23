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

  // For TabBar
  late final TabController tabController;

  // For Home Controller
  HomeController homeController = Get.find<HomeController>();

  // For Users
  UserModel currentUser = Get.find<HomeController>().currentClickedUser;

  // For Current User Products
  List<ProductModel> _userProducts = [];
  List<ProductModel> get userProducts => _userProducts;

  //favorite times for the user
  var favTimes = 0;

  // for favorites icon
  bool isFavorites = false;

  //to show loading when user mark/remove from favourite
  var isFavLoading = true;

  // For Loading
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getUserProducts();
    checkIfUserIsFavourite();
    getFavTimes();
  }

  ///to check if the user is the current or not
  bool isTheCurrent() => homeController.currentUser.id == currentUser.id;

  ///to get the user products
  void getUserProducts() {
    HelperFunctions.safeApiCall(
        execute: () {
          var headers = {Constants.API_AUTHORIZATION : homeController.currentUser.token};
          return BaseClient.get(Constants.USER_PRODUCTS_URL+'/${currentUser.id}',headers: headers);
        },
        onSuccess: (response) {
          response['products'].forEach((product) {
            _userProducts.add(ProductModel.fromJson(product));
          });
          isLoading = false;
          update(['UserProduct']);
        },
        onError: (error) {
          isLoading = false;
          update(['UserProduct']);
          ErrorHandler.handleError(error);
        },
        onLoading: () {
          isLoading = true;
          update(['UserProduct']);
        }
    );
  }

  ///check if the product is in favourite
  void checkIfUserIsFavourite() async {
    var headers = {Constants.API_AUTHORIZATION : homeController.currentUser.token};
    HelperFunctions.safeApiCall(
        execute: () {
          return BaseClient.get(Constants.CHECK_IF_USER_FAVOURITE+'/'+currentUser.id,headers: headers);
        },
        onSuccess: (response) {
          isFavorites = response['isFavorite'];
          isFavLoading = false;
          update(['Favorites']);
        },
        onError: (error) {
          isFavLoading = false;
          update(['Favorites']);
          ErrorHandler.handleError(error);
        },
        onLoading: () {
          isFavLoading = true;
          update(['Favorites']);
        }
    );
  }

  ///get favourite times
  void getFavTimes() {
    HelperFunctions.safeApiCall(
        execute: () {
          var headers = {Constants.API_AUTHORIZATION : homeController.currentUser.token};
          var query = {Constants.USER_ID: currentUser.id};
          return BaseClient.get(Constants.FAVOURITE_USERS_COUNT, query: query, headers: headers);
        },
        onSuccess: (response) {
          Logger().e('res: $response');
          favTimes = response['count'];
          update(['FavTimes']);
        },
        onError: (error) {
          ErrorHandler.handleError(error);
        }
    );
  }

  ///to add the product to the favorites
  void markUserAsFavorites() {
    HelperFunctions.safeApiCall(
        execute: () async {
          return isFavorites
              ? BaseClient.delete(
              Constants.FAVORITE_USERS_URL,
              query: { Constants.USER_ID: currentUser.id },
              headers: { Constants.API_AUTHORIZATION: homeController.currentUser.token }
          )
              : BaseClient.post(
              Constants.FAVORITE_USERS_URL + '/${currentUser.id}',
              headers: { Constants.API_AUTHORIZATION: homeController.currentUser.token }
          );
        },
        onSuccess: (response) {
          isFavorites = !isFavorites;
          isFavLoading = false;
          update(['Favorites']);
        },
        onError: (error) {
          isFavLoading = false;
          update(['Favorites']);
          ErrorHandler.handleError(error);
        },
        onLoading: () {
          isFavLoading = true;
          update(['Favorites']);
        }
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

}