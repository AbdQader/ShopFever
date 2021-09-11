import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/utils/components.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;
  const ProductItem({ required this.productModel });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Card(
            elevation: 3.0,
            child: Container(
              width: 190.0,
              height: 260.0,
              padding: EdgeInsets.all(8.0),
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
                      height: 170,
                      image: NetworkImage(productModel.photos[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 15.0),
                      const SizedBox(width: 10.0),
                      Text('23'),
                      const SizedBox(width: 50.0),
                      Icon(Icons.remove_red_eye_outlined, size: 15.0),
                      const SizedBox(width: 10.0),
                      Text('2078'),
                    ],
                  ),
                  buildText(
                    text: productModel.name,
                    size: 18.0,
                    weight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  buildText(
                    text: '${productModel.price} ILS',
                    size: 16.0,
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