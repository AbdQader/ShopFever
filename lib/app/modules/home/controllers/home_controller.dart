import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shop_fever/app/data/models/category_model.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';

class HomeController extends GetxController {

  // For Categories
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  // For Special Users
  Rx<List<UserModel>> _users = Rx<List<UserModel>>([]);
  List<UserModel> get users => _users.value;

  // For Special Products
  Rx<List<ProductModel>> _products = Rx<List<ProductModel>>([]);
  List<ProductModel> get products => _products.value;

  onInit(){
    //getData();
    getCategories();
    getSpecialUsers();
    super.onInit();
  }

  // This function to fetch the categories
  void getCategories() async {
    try {
      var response = await BaseClient.get(
        CATEGORIES_URL,
        headers: {
          'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMWQxNTc2MzRkMDhkMDAxNmNjN2I0OCIsImlhdCI6MTYyOTMwNzk0MywiZXhwIjoxNjM3MDgzOTQzfQ.3iKb-WHc70Q1nWTIyDUywmTgvJtFxdRaVTU1gEExT44'
        }
      );

      Logger().e('C response: $response');
      if (response['status'] == 'success')
      {
        response['data']['categories'].forEach((category) {
          _categories.add(CategoryModel.fromJson(category));
        });
        update();
      }
    } catch (error) {
      ErrorHandler.handleError(error);
    }
  }

  // This function to fetch the special users
  void getSpecialUsers() async {
    try {
      var response = await BaseClient.get(
        SPECIAL_USERS_URL,
        headers: {
          'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMWQxNTc2MzRkMDhkMDAxNmNjN2I0OCIsImlhdCI6MTYyOTMwNzk0MywiZXhwIjoxNjM3MDgzOTQzfQ.3iKb-WHc70Q1nWTIyDUywmTgvJtFxdRaVTU1gEExT44'
        }
      );

      Logger().e('SU response: $response');
      if (response['status'] == 'success')
      {
        response['users'].forEach((user) {
          _users.value.add(UserModel.fromJson(user));
        });
      }
    } catch (error) {
      ErrorHandler.handleError(error);
    }
  }

  // This function to fetch the special products
  void getSpecialProducts() async {
    try {
      var response = await BaseClient.get(
        SPECIAL_PRODUCTS_URL,
        headers: {
          'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMWQxNTc2MzRkMDhkMDAxNmNjN2I0OCIsImlhdCI6MTYyOTMwNzk0MywiZXhwIjoxNjM3MDgzOTQzfQ.3iKb-WHc70Q1nWTIyDUywmTgvJtFxdRaVTU1gEExT44'
        }
      );

      Logger().e('SP response: $response');
      if (response['status'] == 'success')
      {
        response['products'].forEach((product) {
          _products.value.add(ProductModel.fromJson(product));
        });
      }
    } catch (error) {
      ErrorHandler.handleError(error);
    }
  }

  /**
   *  Example of making http call with base client
   * */
  getData() async
  {
    try{
      var url = 'https://jsonplaceholder.typicode.com/todosx/1';
      var response = await BaseClient.get(url);
    }catch(error){ //if any type of error happen
      //this class will only show snackbar with the error
      //u can change it and handle error as u want
      ErrorHandler.handleError(error);
    }
  }
}
