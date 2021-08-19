import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/utils/components.dart';

class SpecialProductItem extends StatelessWidget {
  
  final String title;
  final String image;
  final double price;

  const SpecialProductItem({
    required this.title,
    required this.image,
    required this.price,
  });

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
              height: 300.0,
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
                      height: 220,
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  buildText(
                    text: title,
                    size: 20.0,
                    weight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  buildText(
                    text: '$price ILS',
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