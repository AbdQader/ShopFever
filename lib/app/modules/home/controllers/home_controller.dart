import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shop_fever/app/data/local/my_hive.dart';
import 'package:shop_fever/app/data/models/category_model.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class HomeController extends GetxController {
  // For Current User
  UserModel? _currentUser;
  UserModel get currentUser => _currentUser!;

  // For User Location
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  // For Categories
  // Rx<List<CategoryModel>> _categories = Rx<List<CategoryModel>>([]);
  // List<CategoryModel> get categories => _categories.value;
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  // For Special Users
  // Rx<List<UserModel>> _users = Rx<List<UserModel>>([]);
  // List<UserModel> get users => _users.value;
  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  // For Products
  // Rx<List<ProductModel>> _products = Rx<List<ProductModel>>([]);
  // List<ProductModel> get products => _products.value;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  // For Special Products
  // Rx<List<ProductModel>> _specialProducts = Rx<List<ProductModel>>([]);
  // List<ProductModel> get specialProducts => _specialProducts.value;
  List<ProductModel> _specialProducts = [];
  List<ProductModel> get specialProducts => _specialProducts;

  // For Close Products
  // Rx<List<ProductModel>> _closeProducts = Rx<List<ProductModel>>([]);
  // List<ProductModel> get closeProducts => _closeProducts.value;
  List<ProductModel> _closeProducts = [];
  List<ProductModel> get closeProducts => _closeProducts;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser().then((_) {
      getUserLocation();
      getCategories();
      getProducts();
      getSpecialUsers();
      getSpecialProducts();
    });
  }

  // to get current user from local db
  Future<void> getCurrentUser() async {
    try {
      _currentUser = await MyHive.getCurrentUser();
    } catch (error) {
      print('abd => getCurrentUser Error: $error');
    }
  }

  // to get the user location
  void getUserLocation() async {
    // check if the service is enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    // check if the permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationData = await location.getLocation();
    await updateUserLocation(_locationData.latitude!, _locationData.longitude!);
  }

  // to update the user location
  Future<void> updateUserLocation(double lat, double lon) async {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.post(
          Constants.USER_LOCATION_URL,
          body: {'location': [lon, lat]},
          headers: {
            Constants.API_AUTHORIZATION: _currentUser!.token,
            Constants.API_CONTENT_TYPE: Constants.API_APPLICATION_JSON,
          }
        );
      },
      onSuccess: (response) => getCloseProducts(),
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
  }

  // to fetch the categories
  void getCategories() async {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return BaseClient.get(Constants.CATEGORIES_URL, headers: {Constants.API_AUTHORIZATION: _currentUser!.token});
      },
      onSuccess: (response)
      {
        response['data']['categories'].forEach((category) {
          //_categories.value.add(CategoryModel.fromJson(category));
          _categories.add(CategoryModel.fromJson(category));
        });
        update();
      },
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
  }

  // to fetch the products
  void getProducts() async {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(Constants.PRODUCTS_URL, headers: {Constants.API_AUTHORIZATION: _currentUser!.token});
      },
      onSuccess: (response)
      {
        response['products'].forEach((product) {
          //_products.value.add(ProductModel.fromJson(product));
          _products.add(ProductModel.fromJson(product));
        });
        update();
      },
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
  }

  // to fetch the special users
  void getSpecialUsers() async {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(Constants.SPECIAL_USERS_URL, headers: {Constants.API_AUTHORIZATION: _currentUser!.token});
      },
      onSuccess: (response)
      {
        response['users'].forEach((user) {
          //_users.value.add(UserModel.fromJson(user));
          _users.add(UserModel.fromJson(user));
        });
        update();
      },
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
  }

  // to fetch the special products
  void getSpecialProducts() async {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(Constants.SPECIAL_PRODUCTS_URL, headers: {Constants.API_AUTHORIZATION: _currentUser!.token});
      },
      onSuccess: (response)
      {
        response['products'].forEach((product) {
          //_specialProducts.value.add(ProductModel.fromJson(product));
          _specialProducts.add(ProductModel.fromJson(product));
        });
        update();
      },
      onError: (error) => ErrorHandler.handleError(error),
      onLoading: () {}
    );
  }

  // to fetch the close products
  void getCloseProducts() async {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.get(Constants.CLOSE_PRODUCTS_URL, headers: {Constants.API_AUTHORIZATION: _currentUser!.token});
      },
      onSuccess: (response)
      {
        response['products'].forEach((product) {
          //_closeProducts.value.add(ProductModel.fromJson(product));
          _closeProducts.add(ProductModel.fromJson(product));
        });
        update();
      },
      onError: (error) {
        ErrorHandler.handleError(error);
      },
      onLoading: () {}
    );
  }

}
