import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';

class SpecialProductItem extends StatelessWidget {
  
  final ProductModel productModel;
  const SpecialProductItem({required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppPages.PRODUCT_DETAILS, arguments: productModel),
      child: Column(
        children: [
          Card(
            elevation: 3.0,
            child: Container(
              width: 190.0,
              height: 300.0,
              padding: const EdgeInsets.all(8.0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      height: 220,
                      image: NetworkImage(productModel.photos[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  buildText(
                    text: productModel.name,
                    size: 20.0,
                    weight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  buildText(
                    text: '${productModel.price} ILS',
                    size: 18.0,
                    color: Get.theme.accentColor,
                    weight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}