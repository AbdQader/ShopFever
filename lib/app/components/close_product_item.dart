import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';

class CloseProductItem extends StatelessWidget {

  final ProductModel productModel;
  const CloseProductItem({required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppPages.PRODUCT_DETAILS, arguments: productModel),
      child: Container(
        width: 190.0,
        height: 290.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.green[50],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(productModel.photos[0]),
              fit: BoxFit.cover,
              height: 220,
            ),
            const SizedBox(height: 5.0),
            buildText(
              text: ' ${productModel.price} ILS',
              size: 18.0,
              color: Get.theme.accentColor,
              overflow: TextOverflow.ellipsis,
            ),
            buildText(
              text: ' ${productModel.name}',
              size: 20.0,
              overflow: TextOverflow.ellipsis,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Icon(Icons.location_on_outlined, size: 12.0),
            //     buildText(text: '83.4KM', size: 12.0),
            //     const SizedBox(width: 5.0),
            //     Icon(Icons.access_time, size: 12.0),
            //     buildText(text: '1 شهر', size: 12.0),
            //     const SizedBox(width: 5.0),
            //     Icon(Icons.remove_red_eye_outlined, size: 12.0),
            //     buildText(text: '16.4KM', size: 12.0),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}