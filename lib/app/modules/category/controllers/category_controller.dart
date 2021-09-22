import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/category_model.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class CategoryController extends GetxController {
  
  // For Current User
  final currentUser = Get.find<HomeController>().currentUser;

  // For Current Category
  late CategoryModel currentCategory;

  // For Category Products
  var categoryProducts = <ProductModel>[];

  // For Loading
  bool isLoading = false;

  ///to get the category products
  void getCategoryProducts() {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(
          Constants.CATEGORIES_PRODUCTS_URL,
          query: {
            Constants.CATEGORY_ID: currentCategory.id
          },
          headers: {
            Constants.API_AUTHORIZATION: currentUser.token
          }
        );
      },
      onSuccess: (response)
      {
        categoryProducts.clear();
        response['products'].forEach((product) {
          categoryProducts.add(ProductModel.fromJson(product));
        });
        isLoading = false;
        update(['CategoryProducts']);
      },
      onError: (error) {
        isLoading = false;
        update(['CategoryProducts']);
        ErrorHandler.handleError(error);
      },
      onLoading: () {
        isLoading = true;
        update(['CategoryProducts']);
      }
    );
  }

}