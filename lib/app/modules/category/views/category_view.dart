import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/components/special_product_item.dart';
import 'package:shop_fever/app/data/models/category_model.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  final args = Get.arguments as CategoryModel;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            args.name,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            childAspectRatio: 2/3.2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: controller.getCategoryProducts(args.id).length,
          itemBuilder: (BuildContext context, int index) {
            return SpecialProductItem(
              productModel: controller.getCategoryProducts(args.id)[index]
            );
         },
        ),
      ),
    );
  }
}
