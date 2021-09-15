import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_fever/app/modules/profile/views/favorites_item.dart';
import 'package:shop_fever/app/utils/components.dart';

class FavoritesView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 2.0,
            title: buildText(
              text: 'المفضلة',
              size: 24.0,
              color: Colors.black,
              weight: FontWeight.bold
            ),
            iconTheme: IconThemeData(color: Colors.black),
            bottom: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: buildText(
                    text: 'السلع (${controller.products.length})',
                    size: 18.0,
                    color: Colors.black
                  ),
                ),
                Tab(
                  child: buildText(
                    text: 'المشتركين (${controller.users.length})',
                    size: 18.0,
                    color: Colors.black
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return FavoritesItem(
                    data: controller.products[index],
                  );
                },
              ),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.users.length,
                itemBuilder: (BuildContext context, int index) {
                  return FavoritesItem(
                    data: controller.users[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}