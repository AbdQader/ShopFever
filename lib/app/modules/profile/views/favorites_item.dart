import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/utils/components.dart';

class FavoritesItem extends StatelessWidget {

  final String photo;
  final String title;
  final String subtitle;

  const FavoritesItem({
    required this.photo,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(photo),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      bottomLeft: const Radius.circular(30.0),
                      bottomRight: const Radius.circular(30.0),
                    )
                  ),
                  child: const Icon(
                    Icons.cancel_outlined,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            buildText(
              text: title,
              size: 24.0,
              color: Colors.black,
              weight: FontWeight.bold
            ),
            buildText(
              text: subtitle,
              size: 20.0,
              color: Get.theme.accentColor,
            ),
          ],
        ),
      ),
    );
  }
}