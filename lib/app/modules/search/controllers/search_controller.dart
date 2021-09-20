import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class SearchController extends GetxController {

  // For Current User
  final _currentUser = Get.find<HomeController>().currentUser;

  // For Searched Products
  var products = <ProductModel>[];

  // For Search Text
  Rx<String> search = ''.obs;

  // For Loading
  Rx<bool> isLoading = false.obs;

  // For Products List
  Rx<bool> isListEmpty = false.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(search, (_) => getProducts(), time: Duration(seconds: 5));
  }

  void getProducts() {
    isLoading.value = true;
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(
          Constants.SEARCH_PRODUCTS_URL,
          query: {
            'search': search.value.trim()
          },
          headers: {
            Constants.API_AUTHORIZATION: _currentUser.token
          },
        );
      },
      onSuccess: (response)
      {
        products.clear();
        response['products'].forEach((product) {
          print('abd => Search Products: ${ProductModel.fromJson(product).toJson()}');
          products.add(ProductModel.fromJson(product));
        });
        isListEmpty.value = products.isEmpty;
        isLoading.value = false;
        update();
      },
      onError: (error) {
        isLoading.value = false;
        ErrorHandler.handleError(error);
      },
      onLoading: () {}
    );
  }

}