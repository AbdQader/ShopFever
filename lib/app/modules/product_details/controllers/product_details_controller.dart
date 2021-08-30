import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';

class ProductDetailsController extends GetxController {
  
  // for image slider
  int currentIndex = 0;

  // to change image slider index
  void changeCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  // to get the product category name
  String productCategory(String categoryId) {
    return Get.find<HomeController>().categories
      .firstWhere((category) => categoryId == category.id).name;
  }

  // to change product publish date format
  String productPublishDate(String date) {
    var dateFormat = DateFormat('d / MM / yyyy');
    return dateFormat.format(DateTime.parse(date));
  }

}
