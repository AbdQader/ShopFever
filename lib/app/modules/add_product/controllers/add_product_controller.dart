import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_fever/app/utils/components.dart';

class AddProductController extends GetxController {

  // For ImagePicker
  ImagePicker _picker = ImagePicker();
  List<File> images = [];
  //List<XFile> pickedImages = [];
  //File? pickedImage;

  // For DropdownButton
  final categoryList = ['سيارات' ,'طعام' ,'ملابس' ,'تجميل' ,'هواتف'];
  final statusList = ['جديد', 'مستخدم'];
  final currencyList = ['JOD دينار', 'ILS شيكل', 'USD دولار'];

  // For TextFormField
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  // For DropdownButton
  late String category;
  late String status;
  late String currency;

  // Submit the product data
  void submit() {
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
      // send the data to the database
    }
  }

  // To get the image that user select it
  Future<void> pickImage() async {
    final pickedImageFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150
    );
    if (pickedImageFile != null) {
      images.add(File(pickedImageFile.path));
      //pickedImage = File(pickedImageFile.path);
      update();
    }
  }

  // For TextFormField Validation
  String? validateValue(String? value) {
    if (value.toString().trim().isEmpty || value == null)
      return 'هذا الحقل مطلوب';
    return null;
  }

  // void pickImages() async {
  //   try {
  //     var images = await _picker.pickMultiImage();
  //     if (images != null)
  //       pickedImages = images;
  //     update();
  //   } catch (error) {
  //     print('abd => MultiImagePicker Error: $error');
  //   }
  // }

}
