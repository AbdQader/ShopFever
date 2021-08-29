import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';

class UserItem extends StatelessWidget {

  final UserModel userModel;

  const UserItem({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppPages.PROFILE, arguments: userModel),
      child: Stack(
        children: [
          Container(
            width: 160.0,
            height: 230.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(userModel.productPhoto!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildText(
                  text: userModel.productsCount.toString(),
                  size: 22.0,
                  color: Colors.white,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 5.0),
                buildText(
                  text: userModel.name,
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
                    backgroundImage: NetworkImage(userModel.photo),
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