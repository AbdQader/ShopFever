import 'package:get/get.dart';
import 'package:shop_fever/app/data/local/my_hive.dart';
import 'package:shop_fever/app/data/models/category_model.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';

class HomeController extends GetxController {

  // For Current User
  UserModel? _currentUser;

  // For Categories
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  // For Special Users
  Rx<List<UserModel>> _users = Rx<List<UserModel>>([]);
  List<UserModel> get users => _users.value;

  // For Special Products
  Rx<List<ProductModel>> _specialProducts = Rx<List<ProductModel>>([]);
  List<ProductModel> get specialProducts => _specialProducts.value;

  // For Close Products
  Rx<List<ProductModel>> _closeProducts = Rx<List<ProductModel>>([]);
  List<ProductModel> get closeProducts => _closeProducts.value;

  @override
  void onInit() async {
    super.onInit();
    await getCurrentUser();
    getCategories();
    getSpecialUsers();
    getCloseProducts();
  }

  // to get current user from local db
  Future<void> getCurrentUser() async {
    try {
      _currentUser = await MyHive.getCurrentUser();
    } catch (error) {
      print('abd => GCU: $error');
    }
  }

  // to fetch the categories
  void getCategories() async {
    try {
      var response = await BaseClient.get(
        CATEGORIES_URL,
        headers: {
          'authorization': _currentUser!.token
        }
      );
      // Success
      if (response['status'] == 'success')
      {
        response['data']['categories'].forEach((category) {
          _categories.add(CategoryModel.fromJson(category));
        });
        update();
      }
    } catch (error) {
      // Error
      ErrorHandler.handleError(error);
    }
  }

  // to fetch the special users
  void getSpecialUsers() async {
    try {
      var response = await BaseClient.get(
        SPECIAL_USERS_URL,
        headers: {
          'authorization': _currentUser!.token
        }
      );
      // Success
      if (response['status'] == 'success')
      {
        response['users'].forEach((user) {
          _users.value.add(UserModel.fromJson(user));
        });
      }
    } catch (error) {
      // Error
      ErrorHandler.handleError(error);
    }
  }

  // to fetch the special products
  void getSpecialProducts() async {
    try {
      var response = await BaseClient.get(
        SPECIAL_PRODUCTS_URL,
        headers: {
          'authorization': _currentUser!.token
        }
      );
      // Success
      if (response['status'] == 'success')
      {
        response['products'].forEach((product) {
          _specialProducts.value.add(ProductModel.fromJson(product));
        });
      }
    } catch (error) {
      // Error
      ErrorHandler.handleError(error);
    }
  }

  // to fetch the close products
  void getCloseProducts() async {
    try {
      var response = await BaseClient.get(
        CLOSE_PRODUCTS_URL,
        headers: {
          'authorization': _currentUser!.token
        }
      );
      // Success
      if (response['status'] == 'success')
      {
        response['products'].forEach((product) {
          _closeProducts.value.add(ProductModel.fromJson(product));
        });
      }
    } catch (error) {
      // Error
      ErrorHandler.handleError(error);
    }
  }

}
