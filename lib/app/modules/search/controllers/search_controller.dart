import 'package:flutter/material.dart';
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

  final searchController = TextEditingController();

  // For Search Text
  Rx<String> search = ''.obs;

  // For Loading
  Rx<bool> isLoading = false.obs;

  // For Products List
  Rx<bool> isListEmpty = false.obs;

  @override
  void onInit() {
    super.onInit();
    // call "getProducts" method when "search" variable change with 5 seconds
    debounce(search, (_) => getProducts(), time: Duration(seconds: 5));
  }

  ///to get the searched products
  void getProducts() {
    if (search.value.trim().isEmpty)
    {
      products.clear();
      isLoading.value = false;
      return;
    }  
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
          products.add(ProductModel.fromJson(product));
        });
        isListEmpty.value = products.isEmpty;
        isLoading.value = false;
        update();
      },
      onError: (error) {
        ErrorHandler.handleError(error);
        isLoading.value = false;
        update();
      },
      onLoading: () {
        isLoading.value = true;
        update();
      }
    );
  }

  ///to clear the search field and search result
  void clearSearch() {
    searchController.clear();
    products.clear();
    isLoading.value = false;
    update();
  }

}