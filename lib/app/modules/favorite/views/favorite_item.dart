import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';

class FavoriteItem extends GetView<FavoriteController> {
  
  final UserModel? userModel;
  final ProductModel? productModel;
  const FavoriteItem({
    required this.userModel,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (userModel != null) {
          Get.toNamed(AppPages.PROFILE, arguments: userModel);
        } else {
          Get.toNamed(AppPages.PRODUCT_DETAILS, arguments: productModel);
        }
      },
      child: Card(
        elevation: 3.0,
        margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: productModel != null ? productModel!.id : '',
                    child: Image(
                      image: NetworkImage(
                        userModel != null
                          ? userModel!.photo
                          : productModel!.photos[0]
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200.0,
                    ),
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
                    child: IconButton(
                      onPressed: () => userModel != null
                        ? controller.removeUserFromFavorites(userModel!.id)
                        : controller.removeProductFromFavorites(productModel!.id),
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 30.0,
                        color: Colors.white,
                      )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              buildText(
                text: userModel != null
                  ? userModel!.name
                  : productModel!.name,
                size: 24.0,
                color: Colors.black,
                weight: FontWeight.bold
              ),
              buildText(
                text: userModel != null
                  ? 'متوفر'
                  : productModel!.currency == 'd'
                    ? '\$ ${productModel!.price}'
                    : 'ILS ${productModel!.price}',
                size: 20.0,
                color: Get.theme.colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}