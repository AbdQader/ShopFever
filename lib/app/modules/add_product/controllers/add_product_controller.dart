import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shop_fever/app/data/local/my_hive.dart';
import 'package:shop_fever/app/data/models/category_model.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/components.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class AddProductController extends GetxController {
  //home controller
  HomeController _homeController = Get.find<HomeController>();
 
  // For Edit Product
  ProductModel? product;

  // For ImagePicker
  ImagePicker _picker = ImagePicker();
  List<File> images = <File>[];
  List<dynamic> urlImages = <dynamic>[];

  // For DropdownButton
  late final List<CategoryModel> categoryList;
  final statusList = ['جديد', 'مستخدم'];
  final currencyList = ['ILS شيكل', 'USD دولار'];

  // For TextFormField
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  // For DropdownButton
  String? category;
  String? status;
  String? currency;

  //for location
  double? lon;
  double? lat;
  String? address;

  @override
  void onInit() {
    if (Get.arguments != null)
    {
      product = Get.arguments;
      urlImages = product!.photos;
      nameController.text = product!.name;
      descriptionController.text = product!.description;
      priceController.text = product!.price.toString();
      category = getCategoryName(product!.categoryId);
      status = product!.isItUsed ? 'مستخدم' : 'جديد';
      currency = product!.currency == 'd' ? 'USD دولار' : 'ILS شيكل';
    }
    categoryList = _homeController.categories;
    update();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.onClose();
  }

  ///Submit the product data to the database
  Future<void> submit() async {
    // Close the keyboard
    Get.focusScope!.unfocus();

    // Check images picked
    if (images.isEmpty && urlImages.isEmpty) {
      showSnackbar('لم تختار اي صور', 'يرجى اختيار بعض الصور للسلعة');
      return;
    }

    // Check form validation
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (product != null &&
          product!.name == nameController.text &&
          product!.description == descriptionController.text &&
          product!.price.toString() == priceController.text &&
          getCategoryName(product!.categoryId) == category &&
          getStatus(product!.isItUsed) == status &&
          getCurrency(product!.currency) == currency
      ) {
        showSnackbar('لم تقم بتغيير اي شيء', 'لم تقم باجراء اي تعديلات على المنتج');
        return;
      }
      await addProductToDatabase();
    }
  }

  ///to add the product to the database
  Future<void> addProductToDatabase() async {
    //photos
    List<MultipartFile> photos = <MultipartFile>[];
    images.forEach((element) {
      photos.add(
        MultipartFile(
          element,
          filename: DateTime.now().millisecondsSinceEpoch.toString()
        )
      );
    });

    // send the data to the database
    var formData = FormData({
      Constants.USER_ID: (await MyHive.getCurrentUser())!.id,
      Constants.CATEGORY_ID: categoryList.firstWhere((element) => element.name == category).id,
      Constants.NAME: nameController.value.text,
      Constants.DESCRIPTION: descriptionController.value.text,
      Constants.PRICE: int.parse(priceController.value.text),
      Constants.CURRENCY: currency!.contains('USD') ? 'd' : 's',
      Constants.IS_IT_USED: statusList.indexWhere((element) => element == status) == 0 ? false : true,
      Constants.PHOTOS: photos
    });

    var headers = {
      Constants.API_ACCEPT: Constants.API_MULTIPART_DATA,
      Constants.API_AUTHORIZATION :(await MyHive.getCurrentUser())!.token
    };

    HelperFunctions.safeApiCall(
      execute: () {
        return BaseClient.post(Constants.CREATE_PRODUCT_URL, headers: headers, body: formData);
      },
      onSuccess: (response) {
        Logger().e('Response => $response');
        Get.back();
      },
      onError: (error) {
        Logger().e('Error => ${error.message}');
        ErrorHandler.handleError(error);
      },
    );
  }

  ///to get categories names
  List<String> getCategories() {
    List<String> cate = <String>[];
    categoryList.forEach((element) {
      cate.add(element.name);
    });
    return cate;
  }

  ///to get category name
  String getCategoryName(String categoryId) {
    return _homeController.categories
      .firstWhere((cate) => cate.id == product!.categoryId).name;
  }

  ///to get product status "new" or "used"
  String getStatus(bool isItUsed) {
    return isItUsed ? 'مستخدم' : 'جديد';
  }

  ///to get product currency "$" or "ILS"
  String getCurrency(String currency) {
    return currency == 'd' ? 'USD دولار' : 'ILS شيكل';
  }

  ///remove selected image
  void removeImage(int index) {
    images.removeAt(index);
    update();
  }

  ///remove selected image url
  void removeImageUrl(int index) {
    urlImages.removeAt(index);
    update();
  }

  ///to get the image that user select it
  Future<void> pickImage() async {
    final pickedImages = await _picker.pickMultiImage(
      imageQuality: 30,
    );
    if (pickedImages != null) {
      //to only allow 10 images
      pickedImages.forEach((element) {
        if (images.length >= 10) return;
        images.add(File(element.path));
      });
      update();
    }
  }

  ///for TextFormField validation
  String? validateValue(String? value) {
    if (value.toString().trim().isEmpty || value == null)
      return 'هذا الحقل مطلوب';
    return null;
  }

  ///allow user to pick user location
  ///let user chose start distanation
  Future<void> pickLocation(BuildContext context) async {
    CameraPosition cameraPosition = CameraPosition(
      //bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      //tilt: 59.440717697143555,
      zoom: 14.151926040649414
    );
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: PlacePicker(
            apiKey: 'AIzaSyCpG3MH8zjWJpX7X-pWKAotpclwF1I2-e0',
            autocompleteLanguage: 'ar',
            enableMapTypeButton: true,
            onPlacePicked: (result) {
              if (result.geometry == null) return;
        
              lat = result.geometry!.location.lat;
              lon = result.geometry!.location.lng;  
        
              address = result.formattedAddress ?? 'موقع غير معروف';
              print('abd => address: $address');
              print('abd => lat: $lat || lon: $lon');
              update();
            },
            initialPosition: cameraPosition.target,
            useCurrentLocation: true,
          ),
        ),
      ),
    );
  }

}