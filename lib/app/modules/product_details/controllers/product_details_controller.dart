import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class ProductDetailsController extends GetxController {
  
  // for image slider
  int currentIndex = 0;

  // for favorites icon
  bool isFavorites = false;

  // to change image slider index
  void changeCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  // to get the product category name
  String productCategory(String categoryId) {
    return Get.find<HomeController>().categories
      .firstWhere((category) => categoryId == category.id).name;
  }

  // to change product publish date format
  String productPublishDate(String date) {
    var dateFormat = DateFormat('d / MM / yyyy');
    return dateFormat.format(DateTime.parse(date));
  }

  // to add the product to the favorites
  void markProductAsFavorites(String productId) {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.post(
          Constants.FAVORITE_PRODUCTS_URL + '/$productId',
          headers: {
            Constants.API_AUTHORIZATION: Get.find<HomeController>().currentUser.token
          }
        );
      },
      onSuccess: (response)
      {
        isFavorites = true;
        update();
      },
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
  }

  void markProductAsWatched(String productId) {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.post(
          Constants.WATCHED_PRODUCTS_URL + '/$productId',
          headers: {
            Constants.API_AUTHORIZATION: Get.find<HomeController>().currentUser.token
          }
        );
      },
      onSuccess: (response)
      {
        print('abd => Response: $response');
      },
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
  }

}
