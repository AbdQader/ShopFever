import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/utils/components.dart';

class CloseProductItem extends StatelessWidget {

  final String title;
  final String image;
  final double price;

  const CloseProductItem({
    required this.title,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              image: NetworkImage(image),
              fit: BoxFit.cover,
              height: 220,
            ),
            const SizedBox(height: 5.0),
            buildText(
              text: ' $price ILS',
              size: 18.0,
              color: Get.theme.accentColor,
              overflow: TextOverflow.ellipsis,
            ),
            buildText(
              text: ' عصير فاخر',
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