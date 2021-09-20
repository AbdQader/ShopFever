import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/components/empty_view.dart';
import 'package:shop_fever/app/components/special_product_item.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    controller.getCategoryProducts();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            controller.currentCategory.name,
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
        body: GetBuilder<CategoryController>(
          id: 'CategoryProducts',
          builder: (controller) => controller.isLoading
            ? showProgressIndicator()
            : controller.categoryProducts.isEmpty
              ? EmptyView(text: 'عذراً هذه الفئة لا تحتوي على اي سلع!')
              : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    childAspectRatio: 2/3.2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: controller.categoryProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SpecialProductItem(
                      productModel: controller.categoryProducts[index]
                    );
                  },
                )
        ),
      ),
    );
  }
}