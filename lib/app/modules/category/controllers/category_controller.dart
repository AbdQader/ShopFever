import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';

class CategoryController extends GetxController {
  
  // to get the category products
  List<ProductModel> getCategoryProducts(String categoryId) {
    var products = <ProductModel>[];
    Get.find<HomeController>().products.forEach((product) {
      if (product.categoryId == categoryId)
        products.add(product);
    });
    return products;
  }

}
