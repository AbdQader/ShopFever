import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class ProductDetailsController extends GetxController {
  // for image slider
  int currentIndex = 0;

  //product
  late ProductModel product;

  //watch and fav times for the product
  var favTimes = 0;
  var watchedTimes = 0;

  //home controller
  HomeController homeController = Get.find();

  // for favorites icon
  bool isFavorites = false;

  //current user
  late UserModel currentUser;

  //to show loading when user mark/remove from favourite
  var isFavLoading = true;

  @override
  void onInit() {
    product = homeController.currentProduct;
    Logger().e(product.user.name);
    markProductAsWatched(product.id);
    currentUser = homeController.currentUser;
    checkIfProductIsFavourite();
    getWatchedTimes();
    getFavTimes();
    super.onInit();
  }

  ///check if the product is in favourite
  checkIfProductIsFavourite() async {
    var headers = {Constants.API_AUTHORIZATION : currentUser.token};
    HelperFunctions.safeApiCall(execute: () {
      return BaseClient.get(Constants.CHECK_IF_FAVOURITE+'/'+product.id,headers: headers);
    }, onSuccess: (response) {
      isFavorites = response['isFavorite'];
      isFavLoading = false;
      update(['Favorites']);
    },onError: (error){
      isFavLoading = false;
      update(['Favorites']);
    });
  }

  ///get watched time
  getWatchedTimes() {
    HelperFunctions.safeApiCall(execute: () {
      var headers = {Constants.API_AUTHORIZATION : currentUser.token};
      return BaseClient.get(Constants.WATCHED_COUNT+'/'+product.id,headers: headers);
    }, onSuccess: (response) {
      watchedTimes = response['count'];
      update(['WatchedTimes']);
    },onError: (error){
      Logger().e(error);
    });
  }

  ///get favourite time
  getFavTimes() {
    HelperFunctions.safeApiCall(execute: () {
      var headers = {Constants.API_AUTHORIZATION : currentUser.token};
      return BaseClient.get(Constants.FAVOURITE_COUNT+'/'+product.id,headers: headers);
    }, onSuccess: (response) {
      favTimes = response['count'];
      update(['FavTimes']);
    },onError: (error){
      Logger().e(error);
    });
  }

  ///to change image slider index
  void changeCurrentIndex(int index) {
    currentIndex = index;
    update(['ImageSlider']);
  }

  ///to get the product category name
  String productCategory(String categoryId) {
    return Get.find<HomeController>()
        .categories
        .firstWhere((category) => categoryId == category.id)
        .name;
  }

  ///to change product publish date format
  String productPublishDate(String date) {
    var dateFormat = DateFormat('d / MM / yyyy');
    return dateFormat.format(DateTime.parse(date));
  }

  ///to add the product to the favorites
  void markProductAsFavorites(String productId) {
    HelperFunctions.safeApiCall(
        execute: () async {
          return isFavorites ?
          BaseClient.delete(
              Constants.DELETE_FROM_FAVOURITE + '/$productId',
              headers: {
                Constants.API_AUTHORIZATION:
                Get.find<HomeController>().currentUser.token
              })
              :
          BaseClient.post(
              Constants.FAVORITE_PRODUCTS_URL + '/$productId',
              headers: {
                Constants.API_AUTHORIZATION:
                Get.find<HomeController>().currentUser.token
              });
        },
        onSuccess: (response) {
          isFavorites = !isFavorites;
          isFavLoading = false;
          update(['Favorites']);
        },
        onError: (error) {
          ErrorHandler.handleError(error);
          isFavLoading = false;
        },
        onLoading: () {
          isFavLoading = true;
          update(['Favorites']);
        });
  }

  ///to mark the product as watched
  void markProductAsWatched(String productId) {
    HelperFunctions.safeApiCall(
      execute: () async {
        return await BaseClient.post(
            Constants.WATCHED_PRODUCTS_URL + '/$productId',
            headers: {
              Constants.API_AUTHORIZATION:
              Get.find<HomeController>().currentUser.token
            });
      },
      onSuccess: (response) {
        print('abd => Response: $response');
      },);
  }

}