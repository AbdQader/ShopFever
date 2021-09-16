import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shop_fever/app/data/local/my_hive.dart';
import 'package:shop_fever/app/data/models/category_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/utils/components.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';

class AddProductController extends GetxController {
  //home controller
  HomeController _homeController = Get.put(HomeController());

  // For ImagePicker
  ImagePicker _picker = ImagePicker();
  List<File> images = <File>[];

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
  late String category;
  late String status;
  late String currency;

  @override
  void onInit() {
    categoryList = _homeController.categories;
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.onClose();
  }

  ///to get categories names
  List<String> getCategories() {
    List<String> cate = <String>[];
    categoryList.forEach((element) {
      cate.add(element.name);
    });
    return cate;
  }

  ///Submit the product data to the database
  submit() async {
    // Close the keyboard
    Get.focusScope!.unfocus();

    // Check images picked
    if (images.isEmpty) {
      showSnackbar('لم تختار اي صور', 'يرجى اختيار بعض الصور للسلعة');
      return;
    }

    // Check form validation
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //photos
      List<MultipartFile> photos = <MultipartFile>[];
      images.forEach((element) {
        photos.add(MultipartFile(element,
            filename: DateTime.now().millisecondsSinceEpoch.toString()));
      });

      // send the data to the database
      var formData = FormData({
        Constants.USER_ID: (await MyHive.getCurrentUser())!.id,
        Constants.CATEGORY_ID: categoryList.firstWhere((element) => element.name == category).id,
        Constants.NAME: nameController.value.text,
        Constants.DESCRIPTION: descriptionController.value.text,
        Constants.PRICE: int.parse(priceController.value.text),
        Constants.CURRENCY: currency.contains('USD') ? 'd' : 's',
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
          //showSnackbar('تمت الاضافة', 'تم اضافة المنتج بنجاح');
          Get.back();
        },
        onError: (error) {
          Logger().e('Error => ${error.message}');
        },
      );
    }
  }

  ///remove selected image
  removeImage(int index) {
    images.removeAt(index);
    update();
  }

  ///to get the image that user select it
  Future<void> pickImage() async {
    final pickedImages = await _picker.pickMultiImage();
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

}
