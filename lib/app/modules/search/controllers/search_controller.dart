import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class SearchController extends GetxController {

  final _currentUser = Get.find<HomeController>().currentUser;
  Rx<String> search = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(search, (_) => getProducts(search.value), time: Duration(seconds: 5));
  }

  List<ProductModel> getProducts(String text) {
    var products = <ProductModel>[];
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(
          Constants.PRODUCTS_URL,
          query: {
            'searchKey': text
          },
          headers: {
            Constants.API_AUTHORIZATION: _currentUser.token
          },
        );
      },
      onSuccess: (response)
      {
        response['products'].forEach((product) {
          products.add(ProductModel.fromJson(product));
        });
      },
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
    return products;
  }

}
