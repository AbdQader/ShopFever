import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';

class FavoriteItem extends StatelessWidget {
  final dynamic data;
  const FavoriteItem({ this.data });

  @override
  Widget build(BuildContext context) {
    bool isUserData = data is UserModel;
    return InkWell(
      onTap: () {
        if (isUserData) {
          Get.toNamed(AppPages.PROFILE, arguments: data);
        } else {
          Get.find<HomeController>().currentProduct = data;
          Get.toNamed(AppPages.PRODUCT_DETAILS);
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
                  Image(
                    image: NetworkImage(isUserData ? data.photo : data.photos[0]),
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
                    child: IconButton(
                      onPressed: () {},
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
                text: data.name,
                size: 24.0,
                color: Colors.black,
                weight: FontWeight.bold
              ),
              buildText(
                text: isUserData
                  ? data.productsCount.toString()
                  : data.currency == 'd' ? '\$ ${data.price}' : 'ILS ${data.price}',
                size: 20.0,
                color: Get.theme.accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}