import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/components.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class ProfileController extends GetxController {

  // For Home Controller
  HomeController homeController = Get.find<HomeController>();

  // For Users
  UserModel currentUser = Get.arguments;

  // For Current User Products
  List<ProductModel> _userProducts = [];
  List<ProductModel> get userProducts => _userProducts;

  // For favorite feature
  int favTimes = 0; //favorite times for the user
  bool isFavorites = false; //check if product is favorite
  bool isFavLoading = true; //to show loading when user mark/remove from favourite

  // For Loading
  bool isLoading = false;

  // for edit profile
  final editProfileFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final codeController = TextEditingController();

  // For Initial Country Code
  String countryCode = '+970';

  // for image picker
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    getUserProducts();
    checkIfUserIsFavourite();
    getFavTimes();
  }

  ///to check if the user is the current or not
  bool isTheCurrent() => homeController.currentUser.id == currentUser.id;

  ///to get the user products
  void getUserProducts() {
    HelperFunctions.safeApiCall(
        execute: () {
          var headers = {Constants.API_AUTHORIZATION : homeController.currentUser.token};
          return BaseClient.get(Constants.USER_PRODUCTS_URL+'/${currentUser.id}',headers: headers);
        },
        onSuccess: (response) {
          response['products'].forEach((product) {
            _userProducts.add(ProductModel.fromJson(product));
          });
          isLoading = false;
          update(['UserProduct']);
        },
        onError: (error) {
          isLoading = false;
          update(['UserProduct']);
          ErrorHandler.handleError(error);
        },
        onLoading: () {
          isLoading = true;
          update(['UserProduct']);
        }
    );
  }

  ///check if the product is in favourite
  void checkIfUserIsFavourite() async {
    var headers = {Constants.API_AUTHORIZATION : homeController.currentUser.token};
    HelperFunctions.safeApiCall(
        execute: () {
          return BaseClient.get(Constants.CHECK_IF_USER_FAVOURITE+'/'+currentUser.id,headers: headers);
        },
        onSuccess: (response) {
          isFavorites = response['isFavorite'];
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
        }
    );
  }

  ///get favourite times
  void getFavTimes() {
    HelperFunctions.safeApiCall(
        execute: () {
          var headers = {Constants.API_AUTHORIZATION : homeController.currentUser.token};
          var query = {Constants.USER_ID: currentUser.id};
          return BaseClient.get(Constants.FAVOURITE_USERS_COUNT, query: query, headers: headers);
        },
        onSuccess: (response) {
          update(['FavTimes']);
        },
        onError: (error) {
          ErrorHandler.handleError(error);
        }
    );
  }

  ///to add the product to the favorites
  void markUserAsFavorites() {
    HelperFunctions.safeApiCall(
        execute: () async {
          return isFavorites
              ? BaseClient.delete(
              Constants.FAVORITE_USERS_URL,
              query: { Constants.USER_ID: currentUser.id },
              headers: { Constants.API_AUTHORIZATION: homeController.currentUser.token }
          )
              : BaseClient.post(
              Constants.FAVORITE_USERS_URL + '/${currentUser.id}',
              headers: { Constants.API_AUTHORIZATION: homeController.currentUser.token }
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
        }
    );
  }

  ///to get the image that user select it
  Future<void> pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.pickImage(
      source: src,
      imageQuality: 50,
      maxWidth: 150
    );
    if (pickedImageFile != null) {
      pickedImage = File(pickedImageFile.path);
      update(['PickImage']);
    }
  }

  ///to submit the new user data to the database
  void submit() {
    // Close the keyboard
    Get.focusScope!.unfocus();

    // Check image picked
    if (pickedImage == null) {
      showSnackbar('الصورة مفقودة' ,'يرجى إختيار صورة أولاً');
      return;
    }

    // Check form validation
    if (editProfileFormKey.currentState!.validate()) {
      editProfileFormKey.currentState!.save();
      _editProfile();
    }
  }

  ///to edit user profile data
  void _editProfile() {}

}