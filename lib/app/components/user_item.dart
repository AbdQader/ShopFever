import 'package:flutter/material.dart';
import 'package:shop_fever/app/utils/components.dart';

class UserItem extends StatelessWidget {

  final String username;
  final String userImage;
  final String productImage;
  final int productsCount;

  const UserItem({
    required this.username,
    required this.userImage,
    required this.productImage,
    required this.productsCount
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            width: 160.0,
            height: 230.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(productImage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildText(
                  text: '$productsCount',
                  size: 22.0,
                  color: Colors.white,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 5.0),
                buildText(
                  text: username,
                  size: 22.0,
                  color: Colors.white,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
          Positioned(
            top: 5,
            left: 10,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 32.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(userImage),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}