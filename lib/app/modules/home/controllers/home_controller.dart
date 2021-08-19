import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shop_fever/app/data/models/category_model.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';

class HomeController extends GetxController {

  // For Categories
  // Rx<List<CategoryModel>> _categories = Rx<List<CategoryModel>>([]);
  // List<CategoryModel> get categories => _categories.value;
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  onInit(){
    //getData();
    getCategories();
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

      Logger().e('response: $response');
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
