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
  //home controller
  HomeController homeController = Get.find<HomeController>();

  //current user
  late UserModel currentUser;

  //product
  late ProductModel product;

  // for image slider
  int currentIndex = 0;

  //watch and fav times for the product
  var favTimes = 0;
  var watchedTimes = 0;

  // for favorites icon
  bool isFavorites = false;

  //to show loading when user mark/remove from favourite
  var isFavLoading = true;

  @override
  void onInit() {
    currentUser = homeController.currentUser;
    product = homeController.currentProduct;
    markProductAsWatched();
    checkIfProductIsFavourite();
    getWatchedTimes();
    getFavTimes();
    super.onInit();
  }

  ///check if the product is in favourite
  void checkIfProductIsFavourite() async {
    var headers = {Constants.API_AUTHORIZATION : currentUser.token};
    HelperFunctions.safeApiCall(
        execute: () {
          return BaseClient.get(Constants.CHECK_IF_PRODUCT_FAVOURITE+'/'+product.id,headers: headers);
        },
        onSuccess: (response) {
          isFavorites = response['isFavorite'];
          isFavLoading = false;
          update(['Favorites']);
        },
        onError: (error){
          isFavLoading = false;
          update(['Favorites']);
        }
    );
  }

  ///get watched time
  void getWatchedTimes() {
    HelperFunctions.safeApiCall(
        execute: () {
          var headers = {Constants.API_AUTHORIZATION : currentUser.token};
          return BaseClient.get(Constants.WATCHED_COUNT+'/'+product.id,headers: headers);
        },
        onSuccess: (response) {
          watchedTimes = response['count'];
          update(['WatchedTimes']);
        },
        onError: (error){
          ErrorHandler.handleError(error);
          Logger().e(error);
        }
    );
  }

  ///get favourite time
  void getFavTimes() {
    HelperFunctions.safeApiCall(
        execute: () {
          var headers = {Constants.API_AUTHORIZATION : currentUser.token};
          return BaseClient.get(Constants.FAVOURITE_PRODUCTS_COUNT+'/'+product.id,headers: headers);
        },
        onSuccess: (response) {
          favTimes = response['count'];
          update(['FavTimes']);
        },
        onError: (error){
          ErrorHandler.handleError(error);
          Logger().e(error);
        }
    );
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
  void markProductAsFavorites() {
    HelperFunctions.safeApiCall(
        execute: () async {
          return isFavorites
              ? BaseClient.delete(
              Constants.DELETE_FROM_FAVOURITE + '/${product.id}',
              headers: {
                Constants.API_AUTHORIZATION:
                Get.find<HomeController>().currentUser.token
              }
          )
              : BaseClient.post(
              Constants.FAVORITE_PRODUCTS_URL + '/${product.id}',
              headers: {
                Constants.API_AUTHORIZATION:
                Get.find<HomeController>().currentUser.token
              }
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
        });
  }

  ///to mark the product as watched
  void markProductAsWatched() {
    HelperFunctions.safeApiCall(
      execute: () async {
        return await BaseClient.post(
            Constants.WATCHED_PRODUCTS_URL + '/${product.id}',
            headers: {
              Constants.API_AUTHORIZATION:
              Get.find<HomeController>().currentUser.token
            }
        );
      },
      onSuccess: (response) {
        print('abd => Response: $response');
      },
    );
  }

}